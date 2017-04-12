<?php

namespace CatalogService;

class Pagination {
	public $pids_per_page = 4;
	public $sort_by = 'price DESC';
	public $next_page_href = false;
	public $prev_page_href = false;
	public $pages = false;
	public $allowed_sort_methods = array(
		'price DESC',
		'price ASC'
	);
	
	public function __construct(array $params) {
		if(
			isset($params['page']) && 
			isset($params['num_pids']) && 
			isset($params['base_url'])
			
		) {
			$this->base_url = $params['base_url'];
			$this->num_pids = (int) $params['num_pids'];
			$this->page = (int) $params['page'];
			$this->offset = (int) ( $this->page - 1) * $this->pids_per_page;
			$this->n_pages = (int) ceil( $this->num_pids / $this->pids_per_page);
			
			// override defaults if specified
			if(isset($params['sort_by'])) {
				if(in_array($params['sort_by'], $this->allowed_sort_methods)) {
					$this->sort_by = $params['sort_by'];
				}
			}
			if(isset($params['pids_per_page'])) {
				$this->pids_per_page = $params['pids_per_page'];
			}
			
			// throw exception if page is not in range
			if($this->offset > $this->num_pids) {
				throw new Exception('Not found', 404);
			}
			// ready
			$this->init();
			
		}
		else {
			throw new Exception('Pagination parameters are missing', 500);
		}
	}
	public function init() {
		// skip the loop if already done
		$i = 0; 
		$page_no = 0;
		$break1 = false;
		$break2 = false;
		while($page_no < $this->n_pages) {
			
			$page_no++;
			
			// skip some
			if($page_no !== 1 && $page_no !== $this->n_pages) {
				if( $page_no > $this->page + 2) {
					if(!$break1) {
						$result[$i]['page'] = '...';
						$result[$i]['href'] = null;
						$result[$i]['pos'] = 'break';
						$i++;
					}
					$break1 = true;
					continue;
				}
				elseif( $page_no < $this->page - 2) {
					if(!$break2) {
						$result[$i]['page'] = '...';
						$result[$i]['href'] = null;
						$result[$i]['pos'] = 'break';
						$i++;
					}
					$break2 = true;
					continue;
				}
			}
			$result[$i]['page'] = $page_no;
			$result[$i]['href'] = $this->base_url . $page_no;
			
			if($this->page === $page_no) {
				$result[$i]['pos'] = 'current';
			} 
			else if($this->page === $this->n_pages) {
				$result[$i]['pos'] = 'last';
			}
			elseif($page_no === 1) {
				$result[$i]['pos'] = 'first';
			}
			else {
				$result[$i]['pos'] = '';
			}
			if($page_no === $this->page + 1) {
				$this->next_page_href = $this->base_url . $page_no;
			}
			if($page_no === $this->page - 1) {
				if($page_no === 1) {
					$this->prev_page_href = Functions::removeUrlParam($this->base_url, 'page');
				}
				else {
					$this->prev_page_href = $this->base_url . $page_no;
				}
			}
			
			$i++;
		}
		if(empty($result) || count($result) < 2) {
			$this->pages = false;
			return false;
		} else {
			$this->pages = $result;
		}
	}
}