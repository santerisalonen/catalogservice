<?php

namespace CatalogService;

class ListBrand {
  
  public $has_products = true;
  public $category;
  
  public function select() {
    $params = array();
    if( $this->category ) {
      $params['in_category'] = ListCategory::getChildSlugs($this->category);  
    }
    
    $brands = $this->getBrands($params);
    
    return $brands;
    
  }
 
  
  private function getBrands(array $conf_t = array()) {

    $conf = array(
      'in_category' => 0,
      'has_products' => 1
    );
    foreach($conf_t as $key => $val) {
      if( isset( $conf[$key] ) ) {
        $conf[$key] = $val;
      }
    }
    $db = DB::getInstance();
    $sql = 'SELECT * FROM brands';
    if( $conf['has_products'] || $conf['in_category'] ) {
      $sql .= ' WHERE slug IN ( SELECT DISTINCT brand FROM products WHERE ( enabled = 0 OR enabled = 1 )';
      if( is_array($conf['in_category']) ) {
        $sql .= ' AND pid IN ( SELECT pid FROM product_to_category WHERE category_slug IN ("' . implode('","', $conf['in_category']) . '") )';
      }
      $sql .= ')';
    }
    
    $query = $db->prepare($sql);
    
    $query->execute();
    
    return $query->fetchAll(\PDO::FETCH_ASSOC);
                
    
  }

  
  
}