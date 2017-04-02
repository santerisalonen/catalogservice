<?php
 
namespace CatalogService;

class DB {
 
	//variable to hold connection object.
	protected static $db;
	 
	//private construct - class cannot be instatiated externally.
	private function __construct() {	
		self::$db = new \PDO("mysql:host=".Config::$rds['host'].";dbname=".Config::$rds['database'].";charset=utf8", Config::$rds['user'], Config::$rds['password']);
		if( Config::$debug == true) {
			self::$db->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_EXCEPTION);
		} 
	}
	 
	public static function getInstance() {
	 
		//Guarantees single instance, if no connection object exists then create one.
		if (!self::$db) {
			//new connection object.
			new DB();
		}
		 
		//return connection.
		return self::$db;
	}
 
}