<?php

namespace CatalogService;

class FlatFileCache {
	public static function load($type, $slug) {		
		switch ($type) {
			case 'category_filters':
				$expires = 100; // 1 min
				break;
			case 'category_products':
				$expires = 100 * 60 * 60; // 1 min
				break;
			case 'category_pids':
				$expires = 100; // 1 min
				break;
			case 'cart':
				$expires = 1;
				break;
		}
		$dir = self::getDir($type);
		$file = $dir . '/' . $slug;
		if(file_exists($file) && filemtime($file) < time() + $expires ) {
			return unserialize(file_get_contents($file));
		} else {
			return false;
		}
	}
	public static function save($type, $slug, $data ) {
		$dir = self::getDir($type);
		if(!file_exists($dir)) {
			mkdir($dir, 0777, true);
		}
		$file = $dir . '/' . $slug;
		$file = fopen($file, 'w');
		fwrite($file, serialize($data));
		fclose($file);
	}
	public static function delete($type, $slug) {
		$dir = self::getDir($type);
		$file = $dir . '/' . $slug;
		unlink($file);
	}
	private static function getDir($type) {
		switch ($type) {
			case 'category_filters':
				$dir = BASE_DIR . '/cache/category_filters';
				break;
			case 'category_products':
				$dir = BASE_DIR . '/cache/category_products';
				break;
			case 'category_pids':
				$dir = BASE_DIR . '/cache/category_pids';
				break;
			case 'cart':
				$dir = BASE_DIR . '/cache/cart';
				break;
		}
		return $dir;
	}
}