-- SELECT Queries

-- 1) List all boycotted brands
SELECT name, country_of_origin
FROM Brand
WHERE is_boycott = 1  
ORDER BY name;

-- 2) Count products per brand (boycotted only)
SELECT b.name, COUNT(p.product_id) AS product_count
FROM Brand b
JOIN Product p ON b.brand_id = p.brand_id  
WHERE b.is_boycott = 1
GROUP BY b.name
ORDER BY product_count DESC;

-- 3) Find all boycott reasons for a specific brand
SELECT br.title, br.details, br.source_url
FROM BoycottReasons br
JOIN Brand b ON br.brand_id = b.brand_id
WHERE b.name = 'Coca-Cola';

-- 4) Count boycott reasons per brand
SELECT b.name, COUNT(br.reason_id) AS reason_count
FROM Brand b
JOIN BoycottReasons br ON b.brand_id = br.brand_id
WHERE b.is_boycott = 1
GROUP BY b.name
ORDER BY reason_count DESC;

-- 5) List all non-boycotted brands with their products
SELECT b.name AS brand_name, p.name AS product_name, c.name AS category
FROM Brand b
JOIN Product p ON b.brand_id = p.brand_id
JOIN Category c ON p.category_id = c.category_id
WHERE b.is_boycott = 0
ORDER BY brand_name, product_name;

-- 6) List products with the most alternatives available
SELECT p.name AS product_name, b.name AS brand_name, 
       COUNT(af.alternative_id) AS alternative_count
FROM Product p
JOIN Brand b ON p.brand_id = b.brand_id
JOIN AlternativeFor af ON p.product_id = af.product_id
WHERE b.is_boycott = 1
GROUP BY p.name, b.name
ORDER BY alternative_count DESC;

-- 7) Find the most common countries of origin for alternative products
SELECT country_of_origin, COUNT(*) AS alternative_count
FROM AlternativeProduct
GROUP BY country_of_origin
ORDER BY alternative_count DESC;

-- 8) List all boycott reasons containing the word "settlement"
SELECT b.name AS brand_name, br.title, br.details
FROM BoycottReasons br
JOIN Brand b ON br.brand_id = b.brand_id
WHERE br.details LIKE '%settlement%' OR br.title LIKE '%settlement%';

-- UNION Query
SELECT name AS Name FROM Product
UNION
SELECT name AS Name FROM Brand;

-- INTERSECTION Query
SELECT product_id FROM Product
INTERSECT
SELECT product_id FROM AlternativeFor;

-- INTERSECTION with condition
SELECT product_id FROM Product
WHERE brand_id IN (SELECT brand_id FROM Brand WHERE is_boycott = 1)
INTERSECT
SELECT product_id FROM AlternativeFor;

-- AVG Function
SELECT AVG(price) AS AvgPrice FROM AlternativeProduct;

-- INSERT operations
INSERT INTO Category (name, description) 
VALUES ('Organic Foods', 'Natural and organic food products');

INSERT INTO Brand (name, is_boycott, country_of_origin, logo_url)
VALUES ('Zamzam', 0, 'Saudi Arabia', 'https://www.zamzam.com/logo.png');

INSERT INTO BoycottReasons (title, details, source_url, brand_id)
VALUES ('Test Reason', 'This is a test boycott reason', 'https://example.com', 1);

INSERT INTO Product (name, brand_id, product_image, category_id)
VALUES ('Zamzam Cola', 16, 'https://www.zamzam.com/cola.png', 1);

INSERT INTO AlternativeProduct (name, country_of_origin, logo_url, price)
VALUES ('Zamzam Alternative', 'Saudi Arabia', 'https://www.zamzam.com/alt.png', 2.99);

-- UPDATE operations
UPDATE Category 
SET description = 'Natural, organic, and chemical-free food products'
WHERE name = 'Organic Foods';

UPDATE Brand
SET is_boycott = 1
WHERE name = 'Zamzam';

UPDATE BoycottReasons
SET details = 'Updated test boycott reason details'
WHERE reason_id = 31;

UPDATE Product
SET product_image = 'https://www.zamzam.com/new-cola.png'
WHERE name = 'Zamzam Cola';

UPDATE AlternativeProduct
SET price = 3.50
WHERE name = 'Zamzam Alternative';

-- DELETE operations
DELETE FROM AlternativeFor 
WHERE alternative_id = (SELECT alternative_id FROM AlternativeProduct WHERE name = 'Albaik');

DELETE FROM AlternativeProduct 
WHERE name = 'Zamzam Alternative';

DELETE FROM Product 
WHERE name = 'Zamzam Cola';
