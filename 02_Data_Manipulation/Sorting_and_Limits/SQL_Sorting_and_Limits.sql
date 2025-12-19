-- SQL_Sorting_and_Limits.sql
-- Comprehensive guide to ORDER BY, LIMIT, and OFFSET with examples and exercises

CREATE DATABASE IF NOT EXISTS retail_db;
USE retail_db;

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    launch_date DATE
);

-- Sample data
INSERT INTO products (product_name, category, price, stock_quantity, launch_date) VALUES
('Laptop Pro', 'Electronics', 999.99, 50, '2023-01-15'),
('Smartphone X', 'Electronics', 699.99, 100, '2023-03-10'),
('Coffee Maker', 'Appliances', 49.99, 30, '2022-11-20'),
('Wireless Headphones', 'Electronics', 89.99, 75, '2023-06-05'),
('Blender', 'Appliances', 39.99, 20, '2022-09-12'),
('Smart TV', 'Electronics', 499.99, 0, '2023-02-25'),
('Microwave Oven', 'Appliances', 79.99, 40, '2022-12-01'),
('Gaming Console', 'Electronics', 399.99, 60, '2023-04-15');

-- 1. ORDER BY (single column)
SELECT product_name, price 
FROM products 
ORDER BY price DESC;  -- Highest to lowest

SELECT product_name, launch_date 
FROM products 
ORDER BY launch_date ASC;  -- Oldest first

-- 2. ORDER BY (multiple columns)
SELECT product_name, category, price 
FROM products 
ORDER BY category ASC, price DESC;  -- Group by category, then highest price first

-- 3. ORDER BY with expressions
SELECT product_name, price, stock_quantity, (price * stock_quantity) AS total_value
FROM products 
ORDER BY total_value DESC;

-- 4. ORDER BY with column position
SELECT product_name, category, price 
FROM products 
ORDER BY 3 DESC, 1 ASC;  -- By price DESC, then name ASC

-- 5. LIMIT
SELECT product_name, price 
FROM products 
ORDER BY price DESC 
LIMIT 5;  -- Top 5 most expensive

-- 6. LIMIT with OFFSET (pagination)
SELECT product_name, price 
FROM products 
ORDER BY price DESC 
LIMIT 5 OFFSET 0;   -- Page 1 (rows 1-5)

SELECT product_name, price 
FROM products 
ORDER BY price DESC 
LIMIT 5 OFFSET 5;   -- Page 2 (rows 6-10)

-- 7. Fetch specific ranks (e.g., 2nd highest)
SELECT product_name, price 
FROM products 
ORDER BY price DESC 
LIMIT 1 OFFSET 1;  -- 2nd most expensive

-- Exercises
-- Exercise 1: Top 3 products by stock_quantity (highest first)
SELECT product_name, stock_quantity 
FROM products 
ORDER BY stock_quantity DESC 
LIMIT 3;

-- Exercise 2: Cheapest 2 Appliances products
SELECT product_name, price 
FROM products 
WHERE category = 'Appliances' 
ORDER BY price ASC 
LIMIT 2;

-- Exercise 3: Products launched in 2023, newest first, show 4
SELECT product_name, launch_date 
FROM products 
WHERE YEAR(launch_date) = 2023 
ORDER BY launch_date DESC 
LIMIT 4;

-- Exercise 4: Pagination - 3rd page (3 items per page) by product_id
SELECT product_id, product_name 
FROM products 
ORDER BY product_id 
LIMIT 3 OFFSET 6;

-- Combined Exercise: Top 3 Electronics by total inventory value
SELECT 
    product_name, 
    price, 
    stock_quantity, 
    (price * stock_quantity) AS inventory_value
FROM products 
WHERE category = 'Electronics'
ORDER BY inventory_value DESC
LIMIT 3;

-- Cleanup
DROP DATABASE IF EXISTS retail_db;