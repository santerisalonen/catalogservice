<?php

namespace CatalogService;

class Config {
  public static $debug;
  public static $domain_path;
  public static $memory_limit_mb;
  public static $rds = array();
  
  public static function init($json_path) {
    $confs = json_decode( file_get_contents($json_path), true);
    foreach( $confs as $key => $val ) {
      if( property_exists( 'CatalogService\Config', $key) ) {
        self::$$key = $val;
      }
    }
    if( self::$domain_path !== '/') {
      self::$domain_path = ltrim(self::$domain_path, '/');
      self::$domain_path = '/' . self::$domain_path;
      self::$domain_path = rtrim(self::$domain_path, '/');
      self::$domain_path = self::$domain_path . '/';
    }
  }
  
}