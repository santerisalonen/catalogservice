<?php

namespace CatalogService;

class Category {
	public $slug;
	public $base_url;
	
	/*
	 * Constructor, Load category data
	*/
	function __construct() {

		if(!isset($this->base_url)) {
			$this->buildBaseUrl();
		}
    if( isset($this->breadcrumb_trail) && !is_array($this->breadcrumb_trail) ) {
      $this->breadcrumb_trail = json_decode($this->breadcrumb_trail, true);
    }
		$this->init();
    
    $this->canonical_url = $this->getCanonicalUrl();
	}	
  
	/*
	 * check conditions and 
	*/
	public function getCanonicalUrl() {		
		// create possible url params
		$params = array();
		if(count($this->filters_active) == 1) { 
			$filter = array ( $this->filters_active[0]['slug'] => $this->filters_active[0]['value'] );
			if ($this->filters_active[0]['canonical'] && $this->filters_active[0]['operator'] == 'equals')  {
				// create filtered category canonical_url if one filter specified
				$params['filter'] = $filter;			
			}
		}
		if($this->pagination->page > 1) {
			$params['page'] = $this->pagination->page;
		}
		if(!empty($params)) {
			return $this->base_url . '?' . http_build_query($params);
		}
    else {
      return $this->base_url;
    }
	}
	function init() {
		
		if( isset ( $_GET['filter'] ) && !empty($_GET['filter'] ) ) {
			// this is a filtered view, set active filter before loading the products and available filters
			$this->setActiveFilters($_GET['filter']);
		} else {
			$this->filters_active = false;
		}
		$this->loadAvailablePids();
		$this->loadAvailableFilters();

		
		// Set pagination
		$page_no = ( isset($_GET['page'])) ? $_GET['page'] : 1;
		$sort_by = ( isset($_GET['sort'])) ? $_GET['sort'] : null;
		$this->setPagination($page_no, $sort_by);
		
		// Load products
		$this->loadProducts();		
	}

	/*
	 *
	 * @return canonical url and breadcrumb trail 
	*/
	public function buildBaseUrl() {
	
    $bt = ListCategory::getCategoryPath($this->slug);

    $base_url = $bt[ count($bt) - 1 ]['url'];

		$db = DB::getInstance();
		$sql = 'UPDATE categories  SET base_url = :base_url, breadcrumb_trail = :bt WHERE slug = :slug';
		$query = $db->prepare($sql);
		$query->execute(array(
			'slug' => $this->slug, 
      'bt' => json_encode($bt),
			'base_url' => $base_url
		));
		$this->base_url = $base_url;
    $this->breadcrumb_trail = $bt;

		return;
	}
	/*
	 * @return boolean
	*/
	public function hasProducts() {
		if (!$this->pids) {
			return false;
		} else {
			return true;
		}
	}
	/*
	 * @return boolean
	*/
	public function hasAvailableFilters() {
		if (!$this->filters_available) {
			return false;
		} else {
			return true;
		}
	}
	/*
	 * @return boolean
	*/
	public function hasActiveFilters() {
		if (!$this->filters_active) {
			return false;
		} else {
			return true;
		}
	}
	/*
	 * load category products to $this->pids
	*/
	public function loadAvailablePids() {
		
		
		// try load from cache if this is not filtered view
		if(!$this->hasActiveFilters()) {

			if( Config::$flat_file_cache ) {
				$pids = FlatFileCache::load('category_pids', $this->slug);
				if($pids) {
					$this->pids = $pids;
					$this->pid_count = count($this->pids);
					return;
				}
			}
			
			// else query from db
			$db = DB::getInstance();
			
			$sql = 'SELECT pid FROM product_to_category
									  WHERE category_slug = :category_slug';
			$query = $db->prepare($sql);
		}
		else {
			
			$filters = $this->filters_active;
			
			$db = DB::getInstance();
			
			$sql = 'SELECT pid FROM product_to_category WHERE category_slug = :category_slug';
			
			// add conditions for each applied filter
			for($i = 0;$i < count($filters); $i++) {

				// handle brand
				if($filters[$i]['slug'] == 'brand') {
					
					$sql .= ' AND pid IN (
											SELECT pid FROM products WHERE FIND_IN_SET(brand, :value' . $i .')
										)';
        } 
				elseif($filters[$i]['operator'] == 'between') {
					$sql .= ' AND pid IN 
									(
										SELECT pa.pid FROM product_to_attribute as pa
										WHERE pa.attribute_slug = :key' . $i .' 
										AND CAST(pa.value AS unsigned) BETWEEN :value_min' . $i . ' AND :value_max'.$i.' 
										UNION
										SELECT pv.pid FROM product_versions as pv
										WHERE pv.attribute_slug = :key' .$i .'
										AND CAST(pv.value AS unsigned) BETWEEN :value_min' . $i . ' AND :value_max'.$i.' 
								 
									)
								';
				} 
				elseif($filters[$i]['operator'] == 'smaller than') {
					$sql .= ' AND pid IN 
									(
										SELECT pa.pid FROM product_to_attribute as pa
										WHERE pa.attribute_slug = :key' . $i .' 
										AND CAST(pa.value AS unsigned) <= :value' . $i . ' 
										UNION
										SELECT pv.pid FROM product_versions as pv
										WHERE pv.attribute_slug = :key' .$i .'
										AND CAST(pv.value AS unsigned) <= :value' . $i . ' 
								 
									)
								';
					
				}
				elseif($filters[$i]['operator'] == 'bigger than') {
					$sql .= ' AND pid IN 
									(
										SELECT pa.pid FROM product_to_attribute as pa
										WHERE pa.attribute_slug = :key' . $i .' 
										AND CAST(pa.value AS unsigned) >= :value' . $i . ' 
										UNION
										SELECT pv.pid FROM product_versions as pv
										WHERE pv.attribute_slug = :key' .$i .'
										AND CAST(pv.value AS unsigned) >= :value' . $i . ' 
								 
									)
								';
				}
				else {
					// operator = equals
					$sql .= ' AND pid IN 
									(
										SELECT pa.pid FROM product_to_attribute as pa
										WHERE pa.attribute_slug = :key' . $i .' 
										AND FIND_IN_SET(pa.value, :value' . $i . ') 
										UNION
										SELECT pv.pid FROM product_versions as pv
										WHERE pv.attribute_slug = :key' .$i .'
										AND FIND_IN_SET(pv.value, :value' . $i . ') 

									)
								';
				}

			}
			
			$query = $db->prepare($sql);
			
	
			// bind values
			$i = 0;
			foreach($filters as $filter) {
				// brand filter has only value
				if($filter['slug'] == 'brand') {
					$query->bindValue('value'.$i, $filter['value']);
				}
				else {
					if($filter['operator'] == 'between') {
						$values = explode('-', $filter['value']);
						$min = $values[0];
						$max = $values[1];
						$query->bindValue('value_min'.$i, $min);
						$query->bindValue('value_max'.$i, $max);
					}
					else {
						if($filter['type'] == 'scalar') {
							// scalar and not range
							$filter['value'] = preg_replace('#[^0-9]#', '', $filter['value']);
						}
						$query->bindValue('value'.$i, $filter['value']);
					}
					$query->bindValue('key'.$i, $filter['slug']);
				}
				
				$i++;
			}	
		}
		

		$query->bindValue('category_slug', $this->slug);
		$query->execute();
		
	
		while ($pid = $query->fetch(\PDO::FETCH_ASSOC)) {
			$this->pids[] = $pid['pid'];
		}
		

		// save to cache
		if(!empty($this->pids)) {
			$this->pid_count = count($this->pids);
			if( Config::$flat_file_cache && !$this->hasActiveFilters()) {
				FlatFileCache::save('category_pids', $this->slug, $this->pids);
			}
		}			
		else {
			$this->pids = false;
			$this->pid_count = 0;
		}

		return;
	}

	/*
	 * 
	*/
	
	
	
	public function setActiveFilters(array $filters) {
		if (!empty( $filters) )  {
			$db = DB::getInstance();

			$results = array();
			
			$i = 0;
			foreach ($filters as $slug => $value) {
				
				// handle brand
				if($slug === 'brand') {
					$results[$i]['slug'] = 'brand';
					$results[$i]['name'] = 'Brändi';
					$results[$i]['type'] = 'string';
					$results[$i]['unit'] = null;
					$results[$i]['value'] = $value;
					$results[$i]['operator'] = 'equals';
					$results[$i]['canonical'] = true;
					$results[$i]['filter'] = true;
					
					if( strstr($results[$i]['value'], ',') ) {
						$results[$i]['operator'] = 'list';
					}
					continue;
				}
				
				$sql = 'SELECT *, :value as "value" FROM product_attributes WHERE slug =  :slug';
				$query = $db->prepare($sql);
				$query->execute(array('slug' => $slug, 'value' => $value));
				$results[$i] = $query->fetch(\PDO::FETCH_ASSOC);
				
				if(strstr($value, '-')) {
					// two values
					$results[$i]['operator'] = 'between';
					// allow only numeric comparision and force integrer
					if(!preg_match('#^([0-9]+)-([0-9]+)$#', $value)) {
						throw new Exception('Bad Request');
					} 
				}
				elseif(strstr($value, ',') ) {
					// list of values
					$results[$i]['operator'] = 'list';
				}
				else {
					// single value
					if(preg_match('#^<#', $value)) {
						$results[$i]['operator'] = 'smaller than'; 
						
						// allow only numeric comparision and force integrer
						if(!preg_match('#^<([0-9]+)$#', $value)) {
							throw new Exception('Bad Request');
						} 
					}
					elseif(preg_match('#^>#', $value)) {
						$results[$i]['operator'] = 'bigger than'; 
						// allow only numeric comparision and force integrer
						if(!preg_match('#^>([0-9]+)$#', $value)) {
							throw new Exception('Bad Request');
						} 
					}
					else {
						$results[$i]['operator'] = 'equals'; 
					}
				
				}
				
				$i++;
				
			}

			if(!empty($results)) {	
				$this->filters_active = $results;
			} 
			else {
				$this->filters_active = false;
			}
		}
		else {
			$this->filters_active = false;
		}
	}
	/*
	 * Fetch available category filters from database
	*/
	public function loadAvailableFilters() {
						
		// try to load from cache
		if( Config::$flat_file_cache && !$this->hasActiveFilters()) {
			$filters = FlatFileCache::load('category_filters', $this->slug);
			if($filters) {
				$this->filters_available = $filters;
				return;
			}
		}
		
		// ensure we have products
		if(!$this->pids) {
			$this->filters_available = false;
			return;
		}
		
		// then rebuild if needed
		if($this->hasActiveFilters()) {			
	
	
			$sql = 'SELECT slug, name, unit, type, direction, value, count(value) as counter FROM 
						( 
							SELECT pid, attribute_slug, value FROM product_versions as pv WHERE pv.pid IN (' . implode(',', $this->pids) .')
							UNION 
							SELECT pid, attribute_slug, value FROM product_to_attribute as pta WHERE pta.pid IN(' . implode(',', $this->pids) . ') 
						) as filters 
					JOIN product_attributes ON filters.attribute_slug = product_attributes.slug
					WHERE product_attributes.filter = true
					GROUP BY value';
		} else {
			$sql = 'SELECT slug, name, unit, type, direction, value, count(value) as counter FROM 
						( 
							SELECT pid, attribute_slug, value FROM product_versions as pv WHERE pv.pid IN	
								(
									SELECT pid FROM product_to_category
									WHERE category_slug = :category_slug
								) 
							UNION 
							SELECT pid, attribute_slug, value FROM product_to_attribute as pta WHERE pta.pid IN
								(
									SELECT pid FROM product_to_category
									WHERE category_slug = :category_slug
								) 
						) as filters 
					JOIN product_attributes ON filters.attribute_slug = product_attributes.slug
					WHERE product_attributes.filter = true
					GROUP BY value';
		}

		
		$db = DB::getInstance();
		$query = $db->prepare($sql);
		$params = array(
			'category_slug' => $this->slug
		);
		$query->execute($params);

		$result = $query->fetchAll(\PDO::FETCH_ASSOC);
		
		
		// set available brands and prices as filter
		$i = 0;
		$brands = array();

		$sql = 'SELECT brand, count(brand) as counter from products WHERE pid IN ("' . implode('","', $this->pids) .'") GROUP BY brand';
		$query = $db->prepare($sql);
		
		$query->execute();
		$brands = $query->fetchAll(\PDO::FETCH_ASSOC);
		
		// add to existing filter array
		$i = count($result);
		foreach ($brands as $brand) {
			$result[$i]['slug'] = 'brand';
			$result[$i]['name'] = 'brändi';
			$result[$i]['type'] = 'brand';
			$result[$i]['unit'] = NULL;
			$result[$i]['direction'] = NULL;
			$result[$i]['filter'] = true;
			$result[$i]['canonical'] = true;
			$result[$i]['value'] = $brand['brand'];
			$result[$i]['counter'] = $brand['counter'];
			$i++;
		}

		if(!empty($result)) {
			
			// extract active filters url params
			$filter_active_params = array();
			if($this->filters_active) {
				foreach($this->filters_active as $filter) {
					$filter_active_params[$filter['slug']] = $filter['value'];
					
				}
			}
			
			
			 
			$filters = array();

			foreach($result as $row) {
				// continue for if already active filter
				if (in_array($row['slug'], array_keys($filter_active_params))) {
					continue;
				}
				// continue if set same as current number of products
				if($row['counter'] >= count($this->pids)) {
					continue;
				}
				// extract unique attributes
				if (!array_key_exists($row['slug'], $filters)) {
					$filters[$row['slug']]['slug'] =  $row['slug'];
					$filters[$row['slug']]['name'] =  $row['name'];
					$filters[$row['slug']]['type'] =  $row['type'];
					$filters[$row['slug']]['unit'] =  $row['unit'];
					$filters[$row['slug']]['direction'] =  $row['direction'];
					// set min max values for if one wants to use range slider
					if($row['type'] == 'scalar') {
						$filters[$row['slug']]['min'] = $row['value'];
						$filters[$row['slug']]['max'] = $row['value'];
					}
				}
				
				// set min max values 
				if($row['type'] == 'scalar') {
					$filters[$row['slug']]['min'] = min($row['value'], $filters[$row['slug']]['min']);
					$filters[$row['slug']]['max'] = max($row['value'], $filters[$row['slug']]['max']);
				}
						
				// reset/declare
	
				$filter_params = array();
				
				// add active filters' params to be used in url
				if($this->filters_active) {
					$filter_params = $filter_active_params;
	
				}
				$filter_params[$row['slug']] = $row['value'];
				
				
				// set uniques values into filter
				$filters[$row['slug']]['uniqueValues'][] = array ( 
															'value' => $row['value'],
															'count' => $row['counter'],
															'href' => $this->base_url . '?' . http_build_query(array( 'filter' => $filter_params ) )
															);								
																
			}
			if(Config::$flat_file_cache && !$this->hasActiveFilters()) {
				FlatFileCache::save('category_filters', $this->slug, $filters);
			}
			$this->filters_available = $filters;
			return;
		}
		else {
			$this->filters_available = false;
			return;
		}
	}
	/*
	 * Set pagination 
	*/
	public function setPagination($page = 1, $sort_by = 'price DESC') {
		$params = array();
		$params['page'] = $page;
		$params['num_pids'] = $this->pid_count;
		
		if($this->filters_active) {
			$params['base_url'] = $this->base_url . '?' . http_build_query(array( 'filter' => $_GET['filter'])) . '&page=';
		}
		else {
			$params['base_url'] = $this->base_url . '?page=';
		}
		$this->pagination = new Pagination($params);			

	}
	public function hasPagination() {
		if($this->pagination->n_pages > 1) {
			return true;
		}
		else {
			return false;
		}
	}
	/*
	 * load products to category->products array
	*/
	public function loadProducts() {

		if(!$this->pids) {
			$this->products = false;
			return false;
		}
      
		$sql = 'SELECT 
            products.base_url,
            products.pid,
            products.name,
            products.slug,
            products.type,
            products.price,
            offers.type as offer_type,
            offers.value as offer_value,
            images.file_name as main_image
            FROM ( 	
              SELECT * FROM products
              WHERE pid IN ("' . implode('","', $this->pids) . '") 
              ORDER BY ' . $this->pagination->sort_by . ' 
              LIMIT '.$this->pagination->offset.', '.$this->pagination->pids_per_page . '
            ) AS products
            LEFT JOIN (
              SELECT pid, type, value FROM product_offers
              WHERE product_offers.valid_to > now() 
              AND product_offers.valid_from < now()
            ) 
            AS offers ON products.pid = offers.pid
            LEFT JOIN (
              SELECT 
              pid, file_name 
              FROM product_to_images
              GROUP BY pid
              ORDER BY sort_order ASC
            ) as images ON products.pid = images.pid';
				
				
		$db = DB::getInstance();
		$query = $db->prepare($sql);
		$query->execute();

   
		$this->products = $query->fetchAll(\PDO::FETCH_ASSOC);
    
		if(empty($this->products)) {
			$this->products = false;
			// throw new Exception('No products found', 404);
		}
		return true;
    
	}

}