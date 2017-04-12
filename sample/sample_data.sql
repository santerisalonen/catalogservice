INSERT IGNORE INTO product_versions
	(id)
VALUES
	(1);
  
INSERT IGNORE INTO brands 
	(name, slug, image)
VALUES
	('Logitech','logitech','logitech-logo.jpg'),
	('Nokia','nokia','nokia-logo.jpg'),
	('Apple','apple','apple-logo.jpg'),
	('Acer','acer','acer-logo.jpg'),
	('Adidas','adidas','adidas-logo.jpg'),
	('Nike','nike','nike-logo.jpg'),
	('Asus','asus','asus-logo.jpg'),
	('Asics','asics','asics-logo.jpg'),
	('Saucony','saucony','saucony-logo.jpg'),
	('Merrell','merrell','merrell-logo.jpg'),
	('LG','lg','lg-logo.jpg'),
	('Brooks','brooks','brooks-logo.jpg'),
	('Puma','puma','puma-logo.jpg'),
	('Lenovo','lenovo','lenovo-logo.jpg'),
	('HP','hp','hp-logo.jpg'),
	('Speedo','speedo','speedo-logo.jpg'),
	('Microsoft','microsoft','microsoft-logo.jpg'),
	('Caterpillar','caterpillar','caterpillar-logo.jpg');
  
INSERT IGNORE INTO categories 
	(parent_slug, slug, name, description) 
VALUES 
	( NULL,'elektroniikka','elektroniikka','dummy description of elektroniikka'),
	( 'elektroniikka', 'tabletit','tabletit', 'tänne asiaa tableteista'),
	( 'tabletit', 'suojakotelot', 'suojakotelot', 'tänne asiaa tablettien suojakoteloista'),
	( 'elektroniikka', 'puhelimet', 'puhelimet', 'tänne asiaa luureista'),
	( 'puhelimet', 'alypuhelimet', 'alypuhelimet', 'tänne asiaa älypuhelimista'),
	( NULL, 'urheilu', 'urheilu', 'täällä urheilukauppa on'),
	( 'urheilu', 'juoksu', 'juoksu', 'juoksu tuotteita on tällä'),
	( 'juoksu', 'juoksukengat', 'juoksukengät', 'yleistietoa juoksukengistä tänne näin'),
	('urheilu','uinti','uinti','tänne uinnista stuffia'),
	('urheilu','jalkapallo','jalkapallo','ronaldo tekee scorea'),
	( NULL, 'kirjat', 'kirjat', 'kirjakaupan description'),
	( 'kirjat', 'tietokirjat', 'tietokirjat', 'tänne kaikkea sivistävää tulee'),
	( 'tietokirjat', 'historia', 'historia', 'historia-aiheisia tietokirjoja'),
	( 'tietokirjat', 'politiikka', 'politiikka', 'politiikka-aiheisia tietokirjoja');
  
INSERT IGNORE INTO product_attributes 
	(slug, name, type, unit, filter, canonical, direction)
VALUES
	('color', 'väri', 'color', NULL, 1, 0, NULL),
	('disk_space_gb', 'tallennustila', 'scalar', 'Gt', 1, 1, 'increase'),
	('screen_size_inches', 'näytön koko', 'scalar', 'tuumaa', 1, 0, 'both'),
	('screen_resolution', 'näytön resoluutio', 'string', NULL, 1, 0, NULL),
	('camera_mpix', 'kameran resoluutio', 'scalar', 'megapikseliä', 1, 0, 'increase'),
	('warranty_months', 'takuu', 'scalar', 'kuukautta', 1, 0, 'increase'),
	('battery_hours', 'Akun kesto', 'scalar', 'tuntia', 1, 0, 'increase'),
	('operating_system', 'käyttöjärjestelmä', 'string', NULL, 1, 0, NULL),
	('weight_grams', 'paino', 'scalar', 'grammaa', 1, 0, 'decrease'),
	('size', 'koko', 'string', NULL, 1, 1, NULL),
	('gender', 'sukupuoli', 'string', NULL, 1, 1, NULL);
  
/* 1. Apple iPad Air 2 16 Gt Wi-Fi tabletti */	
	
INSERT IGNORE INTO products 
	(pid, slug, name, type, brand, price, quantity_in_stock, description)
VALUES	
	(1, 'apple-ipad-air-2-16gt-wifi', 'Apple iPad Air 2 16 Gt Wi-Fi tabletti', 'multi', 'Apple', 5, 399.99, 'Vain 6,1-millimetrisenä Apple iPad Air 2 on kaikkien aikojen ohuin iPad. Ja myös kaikkein kyvykkäin. Siinä on uudistettu 9,7 tuuman Retina-näyttö, mullistava Touch ID -sormenjälkitunnistin, tehokas 64-bittinen A8X-siru, uusi iSight-kamera, parannettu FaceTime HD -kamera, entistä nopeammat langattomat yhteydet, iOS 8, iCloud ja jopa 10 tuntia akun käyttöaikaa. Sen mukana tulee myös mainioita ohjelmia luovaan ja tuottavaan työhön. Ja App Storesta löytyy paljon lisää ohjelmia.');
	
INSERT IGNORE INTO product_images 
	(file_name, alt_text)
VALUES
	('ipad-air-2-white1.jpg', 'iPad Air 2 hopea'),
	('ipad-air-2-white2.jpg', 'iPad Air 2 hopea'),
	('ipad-air-2-all.jpg', 'iPad Air 2 kaikki värit'),
	('apple-ipad-air-2-dark1.jpg', 'iPad Air 2 harmaa'),
	('apple-ipad-air-2-gold.jpg', 'iPad Air 2 kulta');

INSERT IGNORE INTO product_to_images 
	(pid, file_name)
VALUES
	(1, 'ipad-air-2-white1.jpg'),
	(1, 'ipad-air-2-white2.jpg'),
	(1, 'ipad-air-2-all.jpg'),
	(1, 'apple-ipad-air-2-dark1.jpg'),
	(1, 'apple-ipad-air-2-gold.jpg');
	
INSERT IGNORE INTO product_versions
	(pid, attribute_slug, value, image, price, quantity_in_stock)
VALUES
	(1, 'color', 'hopea', 'ipad-air-2-white1.jpg', NULL, 5),
	(1, 'color', 'harmaa', 'apple-ipad-air-2-dark1.jpg', NULL, 5),
	(1, 'color', 'kulta', 'apple-ipad-air-2-gold.jpg', NULL, 5);
	
INSERT IGNORE INTO product_to_attribute
	(pid, attribute_slug, value)
VALUES
	(1, 'disk_space_gb', '16'),
	(1, 'screen_size_inches', '9.7'),
	(1, 'screen_resolution', '2048x1536'),
	(1, 'camera_mpix', '8.1'),
	(1, 'warranty_months', '12'),
	(1, 'battery_hours', '10'),
	(1, 'operating_system', 'iOS8');

INSERT IGNORE INTO product_to_category 
	(pid, category_slug)
VALUES
	(1, 'tabletit');
	
/* 2. Apple iPad Air 2 32 Gt Wi-Fi tabletti */		
	
INSERT IGNORE INTO products 
	(pid, slug, name, type, brand, price, quantity_in_stock, description)
VALUES	
	(2, 'apple-ipad-air-2-32gt-wifi', 'Apple iPad Air 2 32 Gt Wi-Fi tabletti', 'multi', 'Apple', 5, 499.99, 'Vain 6,1-millimetrisenä Apple iPad Air 2 on kaikkien aikojen ohuin iPad. Ja myös kaikkein kyvykkäin. Siinä on uudistettu 9,7 tuuman Retina-näyttö, mullistava Touch ID -sormenjälkitunnistin, tehokas 64-bittinen A8X-siru, uusi iSight-kamera, parannettu FaceTime HD -kamera, entistä nopeammat langattomat yhteydet, iOS 8, iCloud ja jopa 10 tuntia akun käyttöaikaa. Sen mukana tulee myös mainioita ohjelmia luovaan ja tuottavaan työhön. Ja App Storesta löytyy paljon lisää ohjelmia.');
	
INSERT IGNORE INTO product_to_images 
	(pid, file_name)
VALUES
	(2, 'ipad-air-2-white1.jpg'),
	(2, 'ipad-air-2-white2.jpg'),
	(2, 'ipad-air-2-all.jpg'),
	(2, 'apple-ipad-air-2-dark1.jpg'),
	(2, 'apple-ipad-air-2-gold.jpg');
	
INSERT IGNORE INTO product_versions
	(pid, attribute_slug, value, image, price, quantity_in_stock)
VALUES
	(2, 'color', 'hopea', 'ipad-air-2-white1.jpg', NULL, 5),
	(2, 'color', 'harmaa', 'apple-ipad-air-2-dark1.jpg', NULL, 5),
	(2, 'color', 'kulta', 'apple-ipad-air-2-gold.jpg', NULL, 5);
	
INSERT IGNORE INTO product_to_attribute
	(pid, attribute_slug, value)
VALUES
	(2, 'disk_space_gb', '32'),
	(2, 'screen_size_inches', '9.7'),
	(2, 'screen_resolution', '2048x1536'),
	(2, 'camera_mpix', '8.1'),
	(2, 'warranty_months', '12'),
	(2, 'battery_hours', '10'),
	(2, 'operating_system', 'iOS8');

INSERT IGNORE INTO product_to_category 
	(pid, category_slug)
VALUES
	(2, 'tabletit');
	
/* 3. Apple iPad Air 2 64 Gt Wi-Fi tabletti */		
	
INSERT IGNORE INTO products 
	(pid, slug, name, type, brand, price, quantity_in_stock, description)
VALUES	
	(3, 'apple-ipad-air-2-64gt-wifi', 'Apple iPad Air 2 64 Gt Wi-Fi tabletti', 'multi', 'Apple', 5, 599.99, 'Vain 6,1-millimetrisenä Apple iPad Air 2 on kaikkien aikojen ohuin iPad. Ja myös kaikkein kyvykkäin. Siinä on uudistettu 9,7 tuuman Retina-näyttö, mullistava Touch ID -sormenjälkitunnistin, tehokas 64-bittinen A8X-siru, uusi iSight-kamera, parannettu FaceTime HD -kamera, entistä nopeammat langattomat yhteydet, iOS 8, iCloud ja jopa 10 tuntia akun käyttöaikaa. Sen mukana tulee myös mainioita ohjelmia luovaan ja tuottavaan työhön. Ja App Storesta löytyy paljon lisää ohjelmia.');
	
INSERT IGNORE INTO product_to_images 
	(pid, file_name)
VALUES
	(3, 'ipad-air-2-white1.jpg'),
	(3, 'ipad-air-2-white2.jpg'),
	(3, 'ipad-air-2-all.jpg'),
	(3, 'apple-ipad-air-2-dark1.jpg'),
	(3, 'apple-ipad-air-2-gold.jpg');
	
INSERT IGNORE INTO product_versions
	(pid, attribute_slug, value, image, price, quantity_in_stock)
VALUES
	(3, 'color', 'hopea', 'ipad-air-2-white1.jpg', NULL, 5),
	(3, 'color', 'harmaa', 'apple-ipad-air-2-dark1.jpg', NULL, 5),
	(3, 'color', 'kulta', 'apple-ipad-air-2-gold.jpg', NULL, 5);
	
INSERT IGNORE INTO product_to_attribute
	(pid, attribute_slug, value)
VALUES
	(3, 'disk_space_gb', '64'),
	(3, 'screen_size_inches', '9.7'),
	(3, 'screen_resolution', '2048x1536'),
	(3, 'camera_mpix', '8.1'),
	(3, 'warranty_months', '12'),
	(3, 'battery_hours', '10'),
	(3, 'operating_system', 'iOS8');

INSERT IGNORE INTO product_to_category 
	(pid, category_slug)
VALUES
	(3, 'tabletit');
	
/* 4. Apple iPad Air 2 128 Gt Wi-Fi tabletti */		
	
INSERT IGNORE INTO products 
	(pid, slug, name, type, brand, price, quantity_in_stock, description)
VALUES	
	(4, 'apple-ipad-air-2-128gt-wifi', 'Apple iPad Air 2 128 Gt Wi-Fi tabletti', 'multi', 'Apple', 5, 699.99, 'Vain 6,1-millimetrisenä Apple iPad Air 2 on kaikkien aikojen ohuin iPad. Ja myös kaikkein kyvykkäin. Siinä on uudistettu 9,7 tuuman Retina-näyttö, mullistava Touch ID -sormenjälkitunnistin, tehokas 64-bittinen A8X-siru, uusi iSight-kamera, parannettu FaceTime HD -kamera, entistä nopeammat langattomat yhteydet, iOS 8, iCloud ja jopa 10 tuntia akun käyttöaikaa. Sen mukana tulee myös mainioita ohjelmia luovaan ja tuottavaan työhön. Ja App Storesta löytyy paljon lisää ohjelmia.');
	
INSERT IGNORE INTO product_to_images 
	(pid, file_name)
VALUES
	(4, 'ipad-air-2-white1.jpg'),
	(4, 'ipad-air-2-white2.jpg'),
	(4, 'ipad-air-2-all.jpg'),
	(4, 'apple-ipad-air-2-dark1.jpg'),
	(4, 'apple-ipad-air-2-gold.jpg');
	
INSERT IGNORE INTO product_versions
	(pid, attribute_slug, value, image, price, quantity_in_stock)
VALUES
	(4, 'color', 'hopea', 'ipad-air-2-white1.jpg', NULL, 5),
	(4, 'color', 'harmaa', 'apple-ipad-air-2-dark1.jpg', NULL, 5),
	(4, 'color', 'kulta', 'apple-ipad-air-2-gold.jpg', NULL, 5);
	
INSERT IGNORE INTO product_to_attribute
	(pid, attribute_slug, value)
VALUES
	(4, 'disk_space_gb', '128'),
	(4, 'screen_size_inches', '9.7'),
	(4, 'screen_resolution', '2048x1536'),
	(4, 'camera_mpix', '8.1'),
	(4, 'warranty_months', '12'),
	(4, 'battery_hours', '10'),
	(4, 'operating_system', 'iOS8');

INSERT IGNORE INTO product_to_category 
	(pid, category_slug)
VALUES
	(4, 'tabletit');	

	
/* 5. Apple iPad Air 2 16 Gt Wi-Fi + Cellular tabletti */		
	
INSERT IGNORE INTO products 
	(pid, slug, name, type, brand, price, quantity_in_stock, description)
VALUES	
	(5, 'apple-ipad-air-2-16gt-wifi-cellular', 'Apple iPad Air 2 16 Gt Wi-Fi + Cellular tabletti', 'multi', 'Apple', 5, 607.99, 'Vain 6,1-millimetrisenä Apple iPad Air 2 on kaikkien aikojen ohuin iPad. Ja myös kaikkein kyvykkäin. Siinä on uudistettu 9,7 tuuman Retina-näyttö, mullistava Touch ID -sormenjälkitunnistin, tehokas 64-bittinen A8X-siru, uusi iSight-kamera, parannettu FaceTime HD -kamera, entistä nopeammat langattomat yhteydet, iOS 8, iCloud ja jopa 10 tuntia akun käyttöaikaa. Sen mukana tulee myös mainioita ohjelmia luovaan ja tuottavaan työhön. Ja App Storesta löytyy paljon lisää ohjelmia.');
	
INSERT IGNORE INTO product_to_images 
	(pid, file_name)
VALUES
	(5, 'ipad-air-2-white1.jpg'),
	(5, 'ipad-air-2-white2.jpg'),
	(5, 'ipad-air-2-all.jpg'),
	(5, 'apple-ipad-air-2-dark1.jpg'),
	(5, 'apple-ipad-air-2-gold.jpg');
	
INSERT IGNORE INTO product_versions
	(pid, attribute_slug, value, image, price, quantity_in_stock)
VALUES
	(5, 'color', 'hopea', 'ipad-air-2-white1.jpg', NULL, 5),
	(5, 'color', 'harmaa', 'apple-ipad-air-2-dark1.jpg', NULL, 5),
	(5, 'color', 'kulta', 'apple-ipad-air-2-gold.jpg', NULL, 5);
	
INSERT IGNORE INTO product_to_attribute
	(pid, attribute_slug, value)
VALUES
	(5, 'disk_space_gb', '16'),
	(5, 'screen_size_inches', '9.7'),
	(5, 'screen_resolution', '2048x1536'),
	(5, 'camera_mpix', '8.1'),
	(5, 'warranty_months', '12'),
	(5, 'battery_hours', '10'),
	(5, 'operating_system', 'iOS8');

INSERT IGNORE INTO product_to_category 
	(pid, category_slug)
VALUES
	(5, 'tabletit');	
	
/* 6. Apple iPad Air 2 64 Gt Wi-Fi + Cellular tabletti */		
	
INSERT IGNORE INTO products 
	(pid, slug, name, type, brand, price, quantity_in_stock, description)
VALUES	
	(6, 'apple-ipad-air-2-64gt-wifi-cellular', 'Apple iPad Air 2 64 Gt Wi-Fi + Cellular tabletti', 'multi', 'Apple', 5, 727.99, 'Vain 6,1-millimetrisenä Apple iPad Air 2 on kaikkien aikojen ohuin iPad. Ja myös kaikkein kyvykkäin. Siinä on uudistettu 9,7 tuuman Retina-näyttö, mullistava Touch ID -sormenjälkitunnistin, tehokas 64-bittinen A8X-siru, uusi iSight-kamera, parannettu FaceTime HD -kamera, entistä nopeammat langattomat yhteydet, iOS 8, iCloud ja jopa 10 tuntia akun käyttöaikaa. Sen mukana tulee myös mainioita ohjelmia luovaan ja tuottavaan työhön. Ja App Storesta löytyy paljon lisää ohjelmia.');
	
INSERT IGNORE INTO product_to_images 
	(pid, file_name)
VALUES
	(6, 'ipad-air-2-white1.jpg'),
	(6, 'ipad-air-2-white2.jpg'),
	(6, 'ipad-air-2-all.jpg'),
	(6, 'apple-ipad-air-2-dark1.jpg'),
	(6, 'apple-ipad-air-2-gold.jpg');
	
INSERT IGNORE INTO product_versions
	(pid, attribute_slug, value, image, price, quantity_in_stock)
VALUES
	(6, 'color', 'hopea', 'ipad-air-2-white1.jpg', NULL, 5),
	(6, 'color', 'harmaa', 'apple-ipad-air-2-dark1.jpg', NULL, 5),
	(6, 'color', 'kulta', 'apple-ipad-air-2-gold.jpg', NULL, 5);
	
INSERT IGNORE INTO product_to_attribute
	(pid, attribute_slug, value)
VALUES
	(6, 'disk_space_gb', '64'),
	(6, 'screen_size_inches', '9.7'),
	(6, 'screen_resolution', '2048x1536'),
	(6, 'camera_mpix', '8.1'),
	(6, 'warranty_months', '12'),
	(6, 'battery_hours', '10'),
	(6, 'operating_system', 'iOS8');

INSERT IGNORE INTO product_to_category 
	(pid, category_slug)
VALUES
	(6, 'tabletit');	
	
/* 7. Apple iPad Air 2 64 Gt Wi-Fi + Cellular tabletti */		
	
INSERT IGNORE INTO products 
	(pid, slug, name, type, brand, price, quantity_in_stock, description)
VALUES	
	(7, 'apple-ipad-air-2-128gt-wifi-cellular', 'Apple iPad Air 2 128 Gt Wi-Fi + Cellular tabletti', 'multi', 'Apple', 5, 804.99, 'Vain 6,1-millimetrisenä Apple iPad Air 2 on kaikkien aikojen ohuin iPad. Ja myös kaikkein kyvykkäin. Siinä on uudistettu 9,7 tuuman Retina-näyttö, mullistava Touch ID -sormenjälkitunnistin, tehokas 64-bittinen A8X-siru, uusi iSight-kamera, parannettu FaceTime HD -kamera, entistä nopeammat langattomat yhteydet, iOS 8, iCloud ja jopa 10 tuntia akun käyttöaikaa. Sen mukana tulee myös mainioita ohjelmia luovaan ja tuottavaan työhön. Ja App Storesta löytyy paljon lisää ohjelmia.');
	
INSERT IGNORE INTO product_to_images 
	(pid, file_name)
VALUES
	(7, 'ipad-air-2-white1.jpg'),
	(7, 'ipad-air-2-white2.jpg'),
	(7, 'ipad-air-2-all.jpg'),
	(7, 'apple-ipad-air-2-dark1.jpg'),
	(7, 'apple-ipad-air-2-gold.jpg');
	
INSERT IGNORE INTO product_versions
	(pid, attribute_slug, value, image, price, quantity_in_stock)
VALUES
	(7, 'color', 'hopea', 'ipad-air-2-white1.jpg', NULL, 5),
	(7, 'color', 'harmaa', 'apple-ipad-air-2-dark1.jpg', NULL, 5),
	(7, 'color', 'kulta', 'apple-ipad-air-2-gold.jpg', NULL, 5);
	
INSERT IGNORE INTO product_to_attribute
	(pid, attribute_slug, value)
VALUES
	(7, 'disk_space_gb', '128'),
	(7, 'screen_size_inches', '9.7'),
	(7, 'screen_resolution', '2048x1536'),
	(7, 'camera_mpix', '8.1'),
	(7, 'warranty_months', '12'),
	(7, 'battery_hours', '10'),
	(7, 'operating_system', 'iOS8');

INSERT IGNORE INTO product_to_category 
	(pid, category_slug)
VALUES
	(7, 'tabletit');	


/* 8. Apple iPad Air 2 Smart Case kotelo */		
	
INSERT IGNORE INTO products 
	(pid, slug, name, type, brand, price, quantity_in_stock, description)
VALUES	
	(8, 'apple-ipad-air-2-smart-case', 'Apple iPad Air 2 Smart Case kotelo', 'multi', 'Apple', 34, 79.99, 'Apple iPad Air 2 Smart Case tarjoaa tyylikkään, aniliinivärjätyn nahkakotelon iPad Airillesi ja suojaa näytön lisäksi myös takaosaa. Silti siinäkin on iPad Airin ohut ja kevyt design. Se taittuu helposti jalustaksi lukemista, kirjoittamista ja videoiden katselua varten. Lisäksi se herättää iPad Airin ja laittaa sen nukkumaan automaattisesti avattaessa ja suljettaessa.');
	
INSERT IGNORE INTO product_images 
	(file_name, alt_text)
VALUES
	('apple-ipad-smart-case-punainen.jpg', 'iPad Air 2 smart case punainen'),
	('apple-ipad-smart-case-musta.jpg', 'iPad Air 2 smart case musta'),
	('apple-ipad-smart-case-sininen.jpg', 'iPad Air 2 smart case sininen');
	
INSERT IGNORE INTO product_to_images 
	(pid, file_name)
VALUES
	(8, 'apple-ipad-smart-case-punainen.jpg'),
	(8, 'apple-ipad-smart-case-musta.jpg'),
	(8, 'apple-ipad-smart-case-sininen.jpg');

	
INSERT IGNORE INTO product_versions
	(pid, attribute_slug, value, image, price, quantity_in_stock)
VALUES
	(8, 'color', 'punainen', 'apple-ipad-smart-case-punainen.jpg', NULL, 5),
	(8, 'color', 'musta', 'apple-ipad-smart-case-musta.jpg', NULL, 5),
	(8, 'color', 'sininen', 'apple-ipad-smart-case-sininen.jpg', NULL, 5);
	

INSERT IGNORE INTO product_to_category 
	(pid, category_slug)
VALUES
	(8, 'suojakotelot');	
	
INSERT IGNORE INTO bundles 
	(id, name, slug, description, price)
VALUES
	(1, 'Apple iPad Air 2 64 Gt Wi-Fi + Cellular tabletti ja suojakotelo', 'ipad2-air-suojakotelo', 'Ipad Air 2 sekä suojakotelo nyt yhdessä erikoishintaan', 777.99 );

INSERT IGNORE INTO bundle_to_product
	(pid, bundle_id)
VALUES
	(6, 1),
	(8, 1);
	
/* 9. LG G3 Android puhelin 32 Gt, kulta */


INSERT IGNORE INTO products 
	(pid, slug, name, type, brand, price, quantity_in_stock, description)
VALUES	
	(9, 'lg-g3-android-32gt-kulta', 'LG G3 Android puhelin 32 Gt, kulta', 'single', 'LG', 12, 389.99, 'Markkinoiden paras näyttö on kooltaan 5,5 tuumaa, ja Quad HD -tarkkuus (2560x1440) tarjoaa 75 prosenttia enemmän pikseleitä kuin Full HD -näyttö. Peräti 538 pikseliä tuumalla tekee kuvasta todella yksityiskohtaisen ja terävämmän, kuin miltä se näyttää painetussa lehdessä. LG:n IPS-tekniikka mahdollistaa myös laajemman katselukulman ja luonnollisemmat värit. Tämä näyttö erottuu edukseen kaikesta, mitä olet ennen nähnyt.');
	
INSERT IGNORE INTO product_images 
	(file_name, alt_text)
VALUES
	('lg-g3.jpg', 'LG G3'),
	('lg-g3-2.jpg', 'LG G3 takaa');
	
INSERT IGNORE INTO product_to_images 
	(pid, file_name)
VALUES
	(9, 'lg-g3.jpg'),
	(9, 'lg-g3-2.jpg');
	
INSERT IGNORE INTO product_to_attribute
	(pid, attribute_slug, value)
VALUES
	(9, 'disk_space_gb', '32'),
	(9, 'screen_size_inches', '5.5'),
	(9, 'screen_resolution', '2560x1440'),
	(9, 'color', 'kulta'),
	(9, 'camera_mpix', '13'),
	(9, 'operating_system', 'Google Android OS v4.4.2 (KitKat)'),
	(9, 'weight_grams', '153.7');


INSERT IGNORE INTO product_to_category 
	(pid, category_slug)
VALUES
	(9, 'alypuhelimet');

	
/* 10. Caterpillar B15Q Dual-SIM Android älypuhelin */


INSERT IGNORE INTO products 
	(pid, slug, name, type, brand, price, quantity_in_stock, description)
VALUES	
	(10, 'caterpillar-b15q', 'Caterpillar B15Q Dual-SIM Android älypuhelin, musta', 'single', 'Caterpillar', 12, 299.99, 'IP67-sertifioitu Android älypuhelin joka kestää pudotuksen 1.8 metristä ja upottamisen metrin syvyiseen veteen 30 minuutiksi. Ulkonäkönsä puolesta Caterpillar näyttää jämäkältä ja työkalumaiselta joka luo selkeän mielikuvan mistä puhelimessa on kyse. Ominaisuuksiltaan puhelin edustaa kuitenkin monipuolista älypuhelinta.');
	
INSERT IGNORE INTO product_images 
	(file_name, alt_text)
VALUES
	('caterpillar-dualsim.jpg', 'Caterpillar B15Q Dual-SIM Android älypuhelin');
	
INSERT IGNORE INTO product_to_images 
	(pid, file_name)
VALUES
	(10, 'caterpillar-dualsim.jpg');
	
INSERT IGNORE INTO product_to_attribute
	(pid, attribute_slug, value)
VALUES
	(10, 'disk_space_gb', '4'),
	(10, 'screen_size_inches', '4'),
	(10, 'screen_resolution', '480x800'),
	(10, 'color', 'musta'),
	(10, 'camera_mpix', '5'),
	(10, 'operating_system', 'Google Android OS v4.4.2 (KitKat)'),
	(10, 'weight_grams', '170');


INSERT IGNORE INTO product_to_category 
	(pid, category_slug)
VALUES
	(10, 'alypuhelimet');

	
/* 11. Microsoft Surface Pro 3 tablet, 128 Gt */


INSERT IGNORE INTO products 
	(pid, slug, name, type, brand, price, quantity_in_stock, description)
VALUES	
	(11, 'microsoft-surface-pro-3-128gt', 'Microsoft Surface Pro 3 tablet, 128 Gt, Win 10 Pro', 'single', 'Microsoft', 12, 978.99, 'Uusi 12-tuumainen Surface Pro 3 painaa vaivaiset 798 grammaa, mutta vaikka se onkin ohut ja kevyt, se on silti yhtä tehokas ja suorituskykyinen kuin laadukas kannettava. Laitteen mukana toimitetaan aivan uusi Surface-kynä, jolla kirjoitat ja piirrät kuin oikealla kynällä.');
	
INSERT IGNORE INTO product_images 
	(file_name, alt_text)
VALUES
	('surface-pro-3.jpg', 'Microsoft Surface Pro 3 tablet, 128 Gt, Win 10 Pro'),
	('surface-pro-3-2.jpg', 'Microsoft Surface Pro 3 tablet, 128 Gt, Win 10 Pro' );
	
INSERT IGNORE INTO product_to_images 
	(pid, file_name)
VALUES
	(11, 'surface-pro-3.jpg'),
	(11, 'surface-pro-3-2.jpg');
	
INSERT IGNORE INTO product_to_attribute
	(pid, attribute_slug, value)
VALUES
	(11, 'disk_space_gb', '128'),
	(11, 'screen_size_inches', '12'),
	(11, 'screen_resolution', '2160x1440'),
	(11, 'color', 'hopea'),
	(11, 'camera_mpix', '5'),
	(11, 'operating_system', 'Windows 10 Pro'),
	(11, 'weight_grams', '798'),
	(11, 'battery_hours', '9');


INSERT IGNORE INTO product_to_category 
	(pid, category_slug)
VALUES
	(11, 'tabletit');
	

/* 12. Acer Iconia W1-810 8" 32 GB Wi-Fi tabletti, Win 8.1 */


INSERT IGNORE INTO products 
	(pid, slug, name, type, brand, price, quantity_in_stock, description)
VALUES	
	(12, 'acer-ionia', 'Acer Iconia W1-810 8" 32 GB Wi-Fi tabletti, Win 8.1', 'single', 'Acer', 12, 119.99, 'Acer Iconia W1. Kevyt, ohut ja nopea Windows-tabletti työhön ja huviin. 8" IPS-näyttö tarjoaa rikkaat ja eläväiset värit, laajat katselukulmat sekä mainion käytettävyyden myös kirkkaassa päivänvalossa. Neljännen sukupolven Intel Atom Z3735G "Bay Trail" -neliydinsuoritin takaa jouhevan toiminnan ja tehokkasta akusta riittää virtaa jopa kahdeksaksi tunniksi. Laadukkaat stereokaiuttimet tuottavat täyteläisen äänen ja easy grip -pinnoite takakannessa takaa pitävän otteen laitteesta.');
	
INSERT IGNORE INTO product_images 
	(file_name, alt_text)
VALUES
	('acer-ionia.jpg', 'Acer Iconia W1-810'),
	('acer-ionia-2.jpg', 'Acer Iconia W1-810' );
	
INSERT IGNORE INTO product_to_images 
	(pid, file_name)
VALUES
	(12, 'acer-ionia.jpg'),
	(12, 'acer-ionia-2.jpg');
	
INSERT IGNORE INTO product_to_attribute
	(pid, attribute_slug, value)
VALUES
	(12, 'disk_space_gb', '32'),
	(12, 'screen_size_inches', '8'),
	(12, 'screen_resolution', '1280x800'),
	(12, 'color', 'valkoinen'),
	(12, 'camera_mpix', '2'),
	(12, 'operating_system', 'Win 8.1'),
	(12, 'weight_grams', '370'),
	(12, 'battery_hours', '8');


INSERT IGNORE INTO product_to_category 
	(pid, category_slug)
VALUES
	(12, 'tabletit');

	
	
/* 13. SAUCONY RIDE 7 RUNNING SHOES */

INSERT IGNORE INTO products 
	(pid, slug, name, type, brand, price, quantity_in_stock, description)
VALUES	
	(13, 'saucony-ride', 'SAUCONY RIDE 7 RUNNING SHOES', 'multi', 'Saucony', 12, 69.99, 'Run responsively with the latest, greatest edition of Saucony’s flagship neutral lightweight trainer. The latest edition of the Ride is synonymous with another four-letter word: F-A-S-T. Heel-to-toe Powergrid offers 15% less weight and 30% more durable cushioning than standard EVA for even smoother transitions with less weight, and the forefoot has been redesigned with vertical flex grooves for a more flexible foot motion and ground contact. iBR+ now extends further under the midfoot to enhance responsiveness and provide 3 times more cushioning than standard blown rubber. Ride enthusiasts will enjoy the 7th edition’s versatility, comfort and durability when running those long distances.');
	
INSERT IGNORE INTO product_images 
	(file_name, alt_text)
VALUES
	('saucony-ride.jpg', 'SAUCONY RIDE 7 RUNNING SHOES'),
	('saucony-ride-2.jpg', 'SAUCONY RIDE 7 RUNNING SHOES' ),
	('saucony-ride-3.jpg', 'SAUCONY RIDE 7 RUNNING SHOES' );
	
INSERT IGNORE INTO product_to_images 
	(pid, file_name)
VALUES
	(13, 'saucony-ride.jpg'),
	(13, 'saucony-ride-2.jpg'),
	(13, 'saucony-ride-3.jpg' );
	
INSERT IGNORE INTO product_to_attribute
	(pid, attribute_slug, value)
VALUES
	(13, 'weight_grams', '231'),
	(13, 'color', 'keltainen'),
	(13, 'color', 'punainen'),
	(13, 'gender', 'miesten');
	
INSERT IGNORE INTO product_versions
	(pid, attribute_slug, value, image, price, quantity_in_stock)
VALUES	
	(13, 'size', '7 UK', NULL, NULL, 5),
	(13, 'size', '8 UK', NULL, NULL, 5),
	(13, 'size', '9 UK', NULL, NULL, 5),
	(13, 'size', '10 UK', NULL, NULL, 5),
	(13, 'size', '11 UK', NULL, NULL, 5),
	(13, 'size', '12 UK', NULL, NULL, 5),
	(13, 'size', '13 UK', NULL, NULL, 5);


INSERT IGNORE INTO product_to_category 
	(pid, category_slug)
VALUES
	(13, 'juoksukengat');	

/* 14. ASICS GEL-CUMULUS 17 WOMENS RUNNING SHOES - AW15 */

INSERT IGNORE INTO products 
	(pid, slug, name, type, brand, price, quantity_in_stock, description)
VALUES	
	(14, 'asics-gel', 'ASICS GEL-CUMULUS 17 WOMENS RUNNING SHOES - AW15', 'multi', 'Asics', 12, 112.99, 'The award-winning GEL-Cumulus® series just keeps getting better, A continuous sought after running shoe from Asics. The Nimbus continues into its 17th Edition bringing you a fluid ride midsole and a guidence and cushioning system plus many more.');
	
	
INSERT IGNORE INTO product_images 
	(file_name, alt_text)
VALUES
	('asics-gel.jpg', 'ASICS GEL-CUMULUS'),
	('asics-gel-2.jpg', 'ASICS GEL-CUMULUS' );
	
	
INSERT IGNORE INTO product_to_images 
	(pid, file_name)
VALUES
	(14, 'asics-gel.jpg'),
	(14, 'asics-gel-2.jpg');
	
INSERT IGNORE INTO product_to_attribute
	(pid, attribute_slug, value)
VALUES
	(14, 'weight_grams', '267'),
	(14, 'color', 'pinkki'),
	(14, 'gender', 'naisten');
	
INSERT IGNORE INTO product_versions
	(pid, attribute_slug, value, image, price, quantity_in_stock)
VALUES	
	(14, 'size', '7 UK', NULL, NULL, 5),
	(14, 'size', '8 UK', NULL, NULL, 5),
	(14, 'size', '9 UK', NULL, NULL, 5),
	(14, 'size', '10 UK', NULL, NULL, 5),
	(14, 'size', '11 UK', NULL, NULL, 5);


INSERT IGNORE INTO product_to_category 
	(pid, category_slug)
VALUES
	(14, 'juoksukengat');		

/* 15. NIKE FREE 5.0 RUNNING SHOES - FA15 */

INSERT IGNORE INTO products 
	(pid, slug, name, type, brand, price, quantity_in_stock, description)
VALUES	
	(15, 'nike-free', 'NIKE FREE 5.0 RUNNING SHOES - FA15', 'multi', 'Nike', 12, 77.99, 'This updated version gets down to basics with less layers on the upper, creating a lightweight fit for an amazingly flexible ride. The Nike Free 5.0 offers a more natural barefoot-like feel, and a higher profile compared to the other Nike Free family. The engineered mesh upper provides the comfort and fit youd expect of a traditional shoe, conforming to the shape of your foot to support you as you move. Flywire integrated with the laces delivers added support and an adaptive fit. The Free 5.0 therefore provides excelled strengthening benefits of a natural motion stride, along with the cushioning, traction and underfoot protection of a traditional shoe.');
	
INSERT IGNORE INTO product_images 
	(file_name, alt_text)
VALUES
	('nike-free.jpg', 'NIKE FREE 5.0 RUNNING SHOES'),
	('nike-free-2.jpg', 'NIKE FREE 5.0 RUNNING SHOES' ),
	('nike-free-3.jpg', 'NIKE FREE 5.0 RUNNING SHOES' );
	
INSERT IGNORE INTO product_to_images 
	(pid, file_name)
VALUES
	(15, 'nike-free.jpg'),
	(15, 'nike-free-2.jpg'),
	(15, 'nike-free-3.jpg');
	
INSERT IGNORE INTO product_to_attribute
	(pid, attribute_slug, value)
VALUES
	(15, 'color', 'vihreä'),
	(15, 'gender', 'naisten'),
	(15, 'gender', 'miesten');
	
INSERT IGNORE INTO product_versions
	(pid, attribute_slug, value, image, price, quantity_in_stock)
VALUES	
	(15, 'size', '7 UK', NULL, NULL, 5),
	(15, 'size', '8 UK', NULL, NULL, 5),
	(15, 'size', '9 UK', NULL, NULL, 5),
	(15, 'size', '10 UK', NULL, NULL, 5),
	(15, 'size', '11 UK', NULL, NULL, 5);


INSERT IGNORE INTO product_to_category 
	(pid, category_slug)
VALUES
	(15, 'juoksukengat');	

/* 15. ADIDAS SUPERNOVA GLIDE BOOST 7 RUNNING SHOES */

INSERT IGNORE INTO products 
	(pid, slug, name, type, brand, price, quantity_in_stock, description)
VALUES	
	(16, 'adidas-supernova', 'ADIDAS SUPERNOVA GLIDE BOOST 7 RUNNING SHOES - AW15', 'multi', 'Adidas', 12, 97.99, 'Adidas didnt mess around too much with this update, and were glad. The Glide 6 won Editors choice at Runners World in 2014 because of its superlative feel and great ride. A soft, durable foam midsole gives underfoot support and a supple feel to tired legs.');
	

INSERT IGNORE INTO product_images 
	(file_name, alt_text)
VALUES
	('adidas-supernova.jpg', 'ADIDAS SUPERNOVA GLIDE BOOST 7');
	
INSERT IGNORE INTO product_to_images 
	(pid, file_name)
VALUES
	(16, 'adidas-supernova.jpg');
	
INSERT IGNORE INTO product_to_attribute
	(pid, attribute_slug, value)
VALUES
	(16, 'color', 'punainen'),
	(16, 'gender', 'naisten');
	
INSERT IGNORE INTO product_versions
	(pid, attribute_slug, value, image, price, quantity_in_stock)
VALUES	
	(16, 'size', '7 UK', NULL, NULL, 5),
	(16, 'size', '8 UK', NULL, NULL, 5),
	(16, 'size', '9 UK', NULL, NULL, 5),
	(16, 'size', '10 UK', NULL, NULL, 5),
	(16, 'size', '11 UK', NULL, NULL, 5);


INSERT IGNORE INTO product_to_category 
	(pid, category_slug)
VALUES
	(16, 'juoksukengat');	
	
	
/* INSERT OFFERS */

INSERT IGNORE INTO product_offers 
	(pid, type, value, valid_from, valid_to )
VALUES
	(15, 'replace', 44.99, '2000-01-01 23:59:59', '9999-12-31 23:59:59'),
	(16, 'percent_off', 0.2, '2000-01-01 23:59:59', '9999-12-31 23:59:59');

  
  