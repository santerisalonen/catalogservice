<?php

use CatalogService\ListCategory;
use CatalogService\ListBrand;

if(count($path_arr) < 2) {
  throw new \Exception('Not found', 404);

}

switch($path_arr[1]) {
  
  case 'list':
    if( !isset($path_arr[2])) {
      throw new \Exception('Not found', 404);
    }
    
    switch( $path_arr[2] ) {
        
        
        case 'category':
        
          $list = new ListCategory();
          
          $list->parent_slug = ( isset($path_arr[3]) ) ? $path_arr[3] : null;
          
          $categories = $list->select();
          
          echo json_encode($categories);
          break;
          
        case 'brand':        
        
          $list = new ListBrand();
         
          if( isset($_GET['category']) ) {
             $list->category = $_GET['category'];
          }
            
          echo json_encode( $list->select() );
  
          break;
          
        default:
          throw new \Exception('Not found', 404);
          break;
          
          
      
    }
    
    break;
  
  case 'product':
    
    break;
  
  default:
    
    throw new Exception('Not found', 404);
    break;
}
  