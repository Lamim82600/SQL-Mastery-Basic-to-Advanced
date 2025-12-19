-- SQL_Set_Operations.sql
-- Guide to UNION, UNION ALL, INTERSECT, EXCEPT (with MySQL workarounds)

CREATE DATABASE IF NOT EXISTS retail_db;
USE retail_db;

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50)
);

CREATE TABLE archived_products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50)
);

-- Sample data
INSERT INTO products (product_name, category) VALUES
('Laptop Pro', 'Electronics'),
('Smartphone X', 'Electronics'),
('Coffee Maker', 'Appliances'),
('Wireless Headphones', 'Electronics');

INSERT INTO archived_products (product_name, category) VALUES
('Coffee Maker', 'Appliances'),
('Wireless Headphones', 'Electronics'),
('Old Radio', 'Electronics'),
('Broken Blender', 'Appliances');

-- 1. UNION (distinct rows)
SELECT product_name, category FROM products
UNION
SELECT product_name, category FROM archived_products
ORDER BY category, product_name;

-- 2. UNION ALL (all rows, with duplicates)
SELECT product_name, category FROM products
UNION ALL
SELECT product_name, category FROM archived_products
ORDER BY category, product_name;

-- 3. INTERSECT (common rows) - MySQL workaround
SELECT DISTINCT p.product_name, p.category
FROM products p
INNER JOIN archived_products a 
    ON p.product_name = a.product_name 
    AND p.category = a.category;

-- Alternative with EXISTS
SELECT product_name, category
FROM products p
WHERE EXISTS (
    SELECT 1 FROM archived_products a
    WHERE a.product_name = p.product_name
      AND a.category = p.category
);

-- 4. EXCEPT (rows in first but not second) - MySQL workaround
SELECT p.product_name, p.category
FROM products p
LEFT JOIN archived_products a 
    ON p.product_name = a.product_name 
    AND p.category = a.category
WHERE a.product_id IS NULL;

-- Reverse EXCEPT (in archived but not products)
SELECT a.product_name, a.category
FROM archived_products a
LEFT JOIN products p 
    ON a.product_name = p.product_name 
    AND a.category = p.category
WHERE p.product_id IS NULL;

-- 5. Multiple set operations
(SELECT category FROM products)
UNION
(SELECT category FROM archived_products)
ORDER BY category;

-- Exercises
-- Exercise 1: All unique product names
SELECT product_name FROM products
UNION
SELECT product_name FROM archived_products;

-- Exercise 2: Common categories
SELECT category FROM products
WHERE category IN (SELECT category FROM archived_products);

-- Exercise 3: Products only in active (not archived)
SELECT product_name
FROM products p
LEFT JOIN archived_products a ON p.product_name = a.product_name
WHERE a.product_id IS NULL;

-- Combined: Full inventory view with source
SELECT product_name, category, 'Active' AS source FROM products
UNION ALL
SELECT product_name, category, 'Archived' AS source FROM archived_products
ORDER BY category, product_name;

-- Cleanup
DROP DATABASE IF EXISTS retail_db;