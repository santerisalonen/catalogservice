<?php
/*
 * Shared product attributes and methods
 *
*/

namespace CatalogService;

class Product {
	public $pid;
	public $slug;
	public $name;
	public $seo_title;
	public $base_url;
	public $description;
	public $long_description;
	public $brand;
	public $price;
	public $quantity_in_stock;
	public $enabled;
	public $main_image;
	public $attributes = false;
	public $versions = false;
	public $offer = false;
	public $bundles = false;
	public $type;
	

	public function __construct() {
    
    if(!isset($this->base_url)) {
			$this->buildBaseUrl();
		}
		$this->loadAttributes();
		$this->loadVersions();
		$this->loadOffers();
		$this->loadBundles();
    $this->getImages();

	}
  private function buildBaseUrl2($slug) {
    
    $breadcrumb = ListCategory::getCategoryPath($slug);
    $canonical = '';
    foreach($breadcrumb as $step) {
      $canonical .='/' . $step['slug'];
    }
    return $canonical;
    
  }
	/*
	 *
	*/
	public function buildBaseUrl() {
	
    $sql = 'SELECT category_slug FROM product_to_category WHERE pid = :pid';
    $db = DB::getInstance();
    $query = $db->prepare($sql);
    $query->execute(array('pid' => $this->pid));
    
    $slug = $query->fetch(\PDO::FETCH_NUM)[0];
 
    $breadcrumb = ListCategory::getCategoryPath($slug);
		
    var_dump($breadcrumb);
    die();
    
    $base_url = ( $this->base_url ) ? $this->base_url : $this->buildBaseUrl2($this->slug);
    $bt = array();
		foreach($breadcrumb as $step) {
      $step['base_url'] = ( $step['base_url'] ) ? $step['base_url'] : $this->buildBaseUrl2($step['slug']);
      $bt[] = array( 'name' => $step['name'], 'url' => $step['base_url'] );
		}
		// $db = DB::getInstance();
		// $sql = 'UPDATE categories  SET base_url = :base_url, breadcrumb_trail = :bt WHERE slug = :slug';
		// $query = $db->prepare($sql);
		// $query->execute(array(
			// 'slug' => $this->slug, 
      // 'bt' => json_encode($bt),
			// 'base_url' => $base_url
		// ));
		$this->base_url = $base_url;
    $this->breadcrumb_trail = $bt;
    var_dump($this->base_url);
    var_dump($this->breadcrumb_trail);
    die();

		return;
	}
	/*
	 * Get product images
	*/
	private function getImages() {

		$sql = 'SELECT p.file_name, p.alt_text FROM product_images as p JOIN product_to_images 
            ON p.file_name = product_to_images.file_name 
            WHERE product_to_images.pid = :pid 
            ORDER BY product_to_images.sort_order DESC';
            
		$db = DB::getInstance();
		$query = $db->prepare($sql);
		$query->execute(array('pid' => $this->pid));
		$results = $query->fetchAll(\PDO::FETCH_ASSOC);
		if(!empty($results)) {

      for ($i=0;$i<count($results);$i++) {
        $results[$i]['file_name'] = $results[$i]['file_name'];
        $results[$i]['alt_text'] = $results[$i]['alt_text'];
      }

			$this->images = $results;
		}
		else { 
			$this->images = false;	
		}
	}

	/*
	 * @return array|false
	*/
	protected function loadTags() {
		$db = DB::getInstance();
		$sql = 'SELECT * FROM tags WHERE id IN 
					(SELECT tag_id FROM product_to_tag WHERE pid = :pid)';
		$query = $db->prepare($sql);
		$query->execute(array(
			'pid' => $this->pid
		));
		$query->setFetchMode(\PDO::FETCH_ASSOC);
		return $query->fetchAll();	
	}
	/*
	 * no return
	*/
	protected function loadAttributes() {
		$db = DB::getInstance();
		$sql = 'SELECT attribute_slug as slug, value FROM product_to_attribute
				WHERE pid = :pid';
		$query = $db->prepare($sql);
		$query->execute(array(
		'pid' => $this->pid
		));
		$attributes = array();
	
		foreach( $query->fetchAll(\PDO::FETCH_ASSOC) as $attr) {
			$sql = 'SELECT *, :value as "value" FROM product_attributes WHERE slug =  :slug';
			$query = $db->prepare($sql);
			$query->execute(array(
				'slug' => $attr['slug'],
				'value' => $attr['value']
			));
			$attributes[] = $query->fetch(\PDO::FETCH_ASSOC);
		}
		if(!empty($attributes)) {
			$this->attributes = $attributes;
		} else {
			$this->attributes = false;
		}
	}
	/*
	 * no return
	*/
	protected function loadVersions() {
		if($this->type == 'multi') {
			
			// load versions
			$versions = array();
			$db = DB::getInstance();
			$sql = 'SELECT attribute_slug FROM product_versions WHERE pid = :pid GROUP BY attribute_slug';
			$query = $db->prepare($sql);
			$query->execute(array('pid' => $this->pid));
			$rows = $query->fetchAll(\PDO::FETCH_ASSOC);
			
		
			for($i = 0; $i < count($rows); $i++) {
				$versions[$i]['attribute'] = Factory::loadBySlug($rows[$i]['attribute_slug'], 'ProductAttribute');
				$sql = 'SELECT * FROM product_versions WHERE pid = :pid AND attribute_slug = :slug';
				$query = $db->prepare($sql);
				$params = array('pid' => $this->pid, 'slug' => $versions[$i]['attribute']->slug );
				$query->execute($params);
				$versions[$i]['versions'] = $query->fetchAll(\PDO::FETCH_ASSOC);
			}						
			if(!empty($versions)) {
				$this->versions = $versions;
			}
		} else {
			$this->version_id = 1;
		}
		return;
	}
	/*
	 * no return
	*/
	protected function loadOffers() {

		$offer = array();
		$db = DB::getInstance();
		$sql = 'SELECT * FROM product_offers WHERE pid = :pid
				AND product_offers.valid_to > now() 
				AND product_offers.valid_from < now()';
		$query = $db->prepare($sql);
		$query->execute(array('pid' => $this->pid));
		$offer = $query->fetch(\PDO::FETCH_ASSOC);
		// set offer price
		if(!empty($offer)) {			
			$this->offer = $offer;
			$this->offer['price'] = ( $this->offer['type'] == 'replace') ? $this->offer['value'] : $this->price * ( 1 - $this->offer['value'] );
		}
		return;
	}
	protected function loadBundles() {
		$db = DB::getInstance();
		$sql = 'SELECT bundle_id FROM bundle_to_product WHERE pid = :pid';
		$query = $db->prepare($sql);
		$query->execute(array('pid' => $this->pid));
		$i = 0;
		while ( $bundle = $query->fetch(\PDO::FETCH_ASSOC)) {
			$bundles[$i] = Factory::loadById($bundle['bundle_id'], 'FrontEnd_Bundle');
			$i++;
		}
		if(!empty($bundles)) {
			$this->bundles = $bundles;
		}
	}
	/*
	 * @return bool
	*/
	public function inBundles() {
		if(!$this->bundles) {
			return false;
		} else {
			return true;
		}
	}
}