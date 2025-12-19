-- SQL_SELECT_Operations.sql
-- Comprehensive guide to basic SELECT queries with examples and exercises

CREATE DATABASE IF NOT EXISTS retail_db;
USE retail_db;

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    launch_date DATE,
    description TEXT
);

-- Sample data
INSERT INTO products (product_name, category, price, stock_quantity, launch_date, description) VALUES
('Laptop Pro', 'Electronics', 999.99, 50, '2023-01-15', 'High-performance laptop'),
('Smartphone X', 'Electronics', 699.99, 100, '2023-03-10', 'Latest model smartphone'),
('Coffee Maker', 'Appliances', 49.99, 30, '2022-11-20', 'Automatic coffee machine'),
('Wireless Headphones', 'Electronics', 89.99, 75, '2023-06-05', NULL),
('Blender', 'Appliances', 39.99, 20, '2022-09-12', 'Multi-speed blender'),
('Smart TV', 'Electronics', 499.99, 0, '2023-02-25', '4K Ultra HD TV'),
('Microwave Oven', 'Appliances', 79.99, 40, '2022-12-01', 'Compact microwave');

-- 1. Basic SELECT
SELECT * FROM products;  -- All columns and rows

SELECT product_name, price, category FROM products;

-- 2. DISTINCT
SELECT DISTINCT category FROM products;  -- Electronics, Appliances

-- 3. WHERE Clause
SELECT product_name, price 
FROM products 
WHERE price > 500;  -- Laptop Pro, Smartphone X

-- 4. Operators: AND, OR, NOT
SELECT product_name, stock_quantity 
FROM products 
WHERE category = 'Electronics' AND stock_quantity > 50;  -- Smartphone X, Wireless Headphones

SELECT product_name 
FROM products 
WHERE stock_quantity = 0 OR price < 50;  -- Smart TV, Coffee Maker, Blender

SELECT product_name 
FROM products 
WHERE NOT category = 'Appliances';  -- All Electronics

-- 5. LIKE & Wildcards
SELECT product_name 
FROM products 
WHERE product_name LIKE 'Smart%';  -- Smartphone X, Smart TV

SELECT product_name 
FROM products 
WHERE product_name LIKE '%e%';  -- Contains 'e'

SELECT product_name 
FROM products 
WHERE product_name LIKE '_l%';  -- Second char 'l': Blender

-- 6. IN
SELECT product_name, price 
FROM products 
WHERE price IN (49.99, 89.99, 999.99);  -- Coffee Maker, Wireless Headphones, Laptop Pro

-- 7. BETWEEN
SELECT product_name, launch_date 
FROM products 
WHERE launch_date BETWEEN '2023-01-01' AND '2023-06-30';  -- Laptop Pro, Smartphone X, Wireless Headphones

-- 8. IS NULL / IS NOT NULL
SELECT product_name, description 
FROM products 
WHERE description IS NULL;  -- Wireless Headphones

SELECT product_name 
FROM products 
WHERE description IS NOT NULL;

-- 9. Column Aliases
SELECT 
    product_name AS name,
    price * 1.10 AS price_with_tax
FROM products;

-- 10. ORDER BY
SELECT product_name, price 
FROM products 
ORDER BY price DESC;  -- Highest to lowest

SELECT product_name, category, price 
FROM products 
ORDER BY category ASC, price DESC;

-- Exercises
-- Exercise 1: Select all products launched in 2023
SELECT product_name, launch_date 
FROM products 
WHERE YEAR(launch_date) = 2023;

-- Exercise 2: Find products with 'machine' in name or description
SELECT product_name, description 
FROM products 
WHERE product_name LIKE '%machine%' OR description LIKE '%machine%';

-- Exercise 3: Select distinct prices > 100 ordered ascending
SELECT DISTINCT price 
FROM products 
WHERE price > 100 
ORDER BY price ASC;

-- Combined Exercise
SELECT 
    category,
    COUNT(*) AS product_count,
    ROUND(AVG(price), 2) AS avg_price
FROM products 
WHERE stock_quantity > 0
GROUP BY category
HAVING avg_price > 50
ORDER BY avg_price DESC;

-- Cleanup
DROP DATABASE IF EXISTS retail_db;