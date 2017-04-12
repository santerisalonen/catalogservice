<?php

namespace CatalogService;

class Functions {
  
  /*
   * remove query string from url 
  */
  public static function removeUrlParam($url, $varname) {
      list($urlpart, $qspart) = array_pad(explode('?', $url), 2, '');
      parse_str($qspart, $qsvars);
      unset($qsvars[$varname]);
      $newqs = http_build_query($qsvars);
    if(empty($newqs)) {
      return $urlpart;
    } else {
      return $urlpart . '?' . $newqs;
    }
  }
  
}
    