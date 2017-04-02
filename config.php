<?php

DEFINE('BASE_DIR', __DIR__ );

set_include_path(BASE_DIR);

require('vendor/autoload.php');

$config = BASE_DIR . '/config.json';

use CatalogService\Config;
Config::init($config);