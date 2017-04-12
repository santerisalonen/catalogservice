<?php

DEFINE('BASE_DIR', __DIR__ );

set_include_path(BASE_DIR);

require('vendor/autoload.php');

$config = BASE_DIR . '/config.json';

use CatalogService\Config;
Config::init($config);

ini_set('memory_limit', Config::$memory_limit_mb . 'M');

function exception_handler($e) {
	// print error in JSON
	if( CatalogService\Config::$debug ) {
		$error['message'] = $e->getMessage();
		$error['file'] = $e->getFile();
		$error['line'] = $e->getLine();
	}
	else {
		$error['message'] = $e->getMessage();
	}	
	http_response_code($e->getCode());
	echo json_encode($error);
	return;
}
set_exception_handler('exception_handler');