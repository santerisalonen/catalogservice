<?php 

namespace CatalogService;

class Factory {
  
  	public static function loadBySlug($slug, $class) {
		
		switch ($class) {
			case 'Category':
				$sql = 'SELECT * FROM categories WHERE slug = :slug LIMIT 1';
				break;

      case 'Product':
        $sql = 'SELECT * FROM products WHERE slug = :slug LIMIT 1';
        break;
        
      case 'ProductAttribute':
        $sql = 'SELECT * FROM product_attributes WHERE slug = :slug LIMIT 1';
        break;
        
      default:
        throw new \Exception('Class ' . $class . ' not implemented', 400);
        
		}
		
		$db = DB::getInstance();
		$query = $db->prepare($sql);
		$query->execute(array(
			'slug' => $slug
		));
	
		$result = $query->fetchObject(__namespace__ . '\\' . $class);
    if(!$result) {
      throw new \Exception('Not found', 404);
    }
		return $result;
	}
}