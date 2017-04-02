<?php

use CatalogService\Config;

$path = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);

header('Content-Type: application/json');

// remove app folder and version id from path
$rm_path = strtolower( Config::$domain_path );
$path = str_replace( $rm_path, '/', strtolower($path));
// remove slashes
$path = ltrim( rtrim($path, '/'), '/') ;

$path_arr = array_filter(explode('/', $path));

if(count($path_arr) < 1) {
  throw new \Exception('Not found', 404);
}
switch( $path_arr[0] ) {
  case 'v1':
    include( BASE_DIR . '/controller/v1/main.php' );
    break;
  
  default:
    throw new \Exception('Not found', 404);
    break;
}




