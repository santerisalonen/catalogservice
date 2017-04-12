<?php

namespace CatalogService;

class ListCategory {
  public $parent_slug = null;
  
  public function select() { 
    return self::getCategoryChildren($this->parent_slug);    
  
  }
  
  public static function getCategoryPath($slug) {
    $steps = self::getCategoryPath_rec($slug);
    $url = '';
    for($i = 0;$i < count($steps); $i++){
      $url .= '/' . $steps[$i]['slug'];
      if( !$steps[$i]['base_url'] ) {
        $steps[$i]['base_url'] = $url; 
      }
      $steps[$i] = array(
        'name' => $steps[$i]['name'],
        'url' => $steps[$i]['base_url']
        );
        
    }
    return $steps;
  }
  /*
   * get path to category
   *
   * recursive function
   *
   * @return array (parent categories)
  */
  private static function getCategoryPath_rec($slug, array $parents = array()) {
    if($parents == null) {
      $parents = array();
    }
    $cat_curr = self::getAllCategories("WHERE slug = '" . $slug . "'");
    
    $parents[] = $cat_curr[0];
    
    if($cat_curr[0]['parent_slug']) {
      $parents =  self::getCategoryPath_rec($cat_curr[0]['parent_slug'], $parents);	
      return $parents;
    }
    else {
      return array_reverse($parents);
    }
  }

 /*
   * get children of a category
   *
   * recursive function
   *
   * @return array (child categories)
  */
  public static function getChildSlugs($slug) {
    $slugs = self::getChildSlugs_str($slug);
    return array_filter(explode(',', $slugs));
  }
  public static function getChildSlugs_str($slug, $slugs = '') {
    
    $slugs .= $slug.',';
   
    $db = DB::getInstance();
    $sql = 'SELECT slug FROM categories WHERE parent_slug = :slug';
    $query = $db->prepare($sql);
    $query->execute( array('slug' => $slug) ); 
    $sub_cats = $query->fetchAll(\PDO::FETCH_NUM);
   
    if( !empty($sub_cats )) {
      foreach($sub_cats as $cat) {
        $slugs .= self::getChildSlugs_str($cat[0]);
      }
      return $slugs;
    }
    else {
      // nothing found
      return $slugs;
    }
  }
  /*
   * get children of a category
   *
   * recursive function
   *
   * @return array (child categories)
  */
  public static function getCategoryChildren($slug) {

    if(!$slug) {
      $sql = 'WHERE parent_slug IS null';
    }
    else {
      $sql = 'WHERE parent_slug = "'.$slug.'"';
    }
    $sub_cats = self::getAllCategories($sql);
    if(!empty($sub_cats)) {
      for ($i = 0; $i < count($sub_cats); $i++) {
        $children[$i] = $sub_cats[$i];
        $children[$i]['children'] = self::getCategoryChildren($children[$i]['slug']);
      }
      return $children;
    }
    else {
      // nothing found
      return array();
    }
  }
  /*
   * get all available categories
   *
   * @return array (categories)
  */
  private static function getAllCategories($filter = null) {
    $db = DB::getInstance();
    if($filter == null) {
      $sql = 'SELECT parent_slug, slug, name, base_url FROM categories';
    }
    else {
      $sql = 'SELECT parent_slug, slug, name, base_url FROM categories ' .$filter;
    }
    $query = $db->prepare($sql);
    $query->execute();
    $query->setFetchMode(\PDO::FETCH_ASSOC);
    $cats = $query->fetchALL();
    return $cats;
  }

}