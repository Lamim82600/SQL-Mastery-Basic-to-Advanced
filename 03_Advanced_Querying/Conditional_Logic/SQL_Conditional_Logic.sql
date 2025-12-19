-- SQL_Conditional_Logic.sql
-- Comprehensive guide to conditional logic in SQL (CASE, COALESCE, NULLIF, IF)

CREATE DATABASE IF NOT EXISTS retail_db;
USE retail_db;

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    discount_percentage DECIMAL(5, 2),
    description TEXT
);

-- Sample data
INSERT INTO products (product_name, category, price, stock_quantity, discount_percentage, description) VALUES
('Laptop Pro', 'Electronics', 999.99, 50, 10.00, 'High-performance laptop'),
('Smartphone X', 'Electronics', 699.99, 100, NULL, 'Latest model smartphone'),
('Coffee Maker', 'Appliances', 49.99, 0, 5.00, 'Automatic coffee machine'),
('Wireless Headphones', 'Electronics', 89.99, 75, 0.00, NULL),
('Blender', 'Appliances', 39.99, 20, 5.00, 'Multi-speed blender'),
('Smart TV', 'Electronics', 499.99, 10, NULL, '4K Ultra HD TV'),
('Microwave Oven', 'Appliances', 79.99, 40, 0.00, 'Compact microwave');

-- 1. Searched CASE
SELECT 
    product_name,
    price,
    CASE
        WHEN price >= 500 THEN 'Premium'
        WHEN price >= 100 THEN 'Mid-Range'
        ELSE 'Budget'
    END AS price_tier
FROM products;

-- 2. Simple CASE
SELECT 
    product_name,
    category,
    CASE category
        WHEN 'Electronics' THEN 'Gadget'
        WHEN 'Appliances' THEN 'Home'
        ELSE 'Other'
    END AS category_group
FROM products;

-- 3. CASE with calculations
SELECT 
    product_name,
    price,
    discount_percentage,
    price * (1 - COALESCE(discount_percentage, 0)/100) AS final_price,
    CASE
        WHEN discount_percentage > 5 THEN 'Heavy Discount'
        WHEN discount_percentage > 0 THEN 'Standard Discount'
        ELSE 'No Discount'
    END AS discount_status
FROM products;

-- 4. COALESCE
SELECT 
    product_name,
    COALESCE(description, 'No description available') AS display_description,
    COALESCE(discount_percentage, 0.00) AS safe_discount
FROM products;

-- 5. NULLIF
SELECT 
    product_name,
    discount_percentage,
    NULLIF(discount_percentage, 0.00) AS active_discount  -- 0 becomes NULL
FROM products;

-- Avoid division by zero
SELECT 
    product_name,
    price / NULLIF(discount_percentage, 0) AS price_per_percent
FROM products;

-- 6. IF (MySQL specific)
SELECT 
    product_name,
    stock_quantity,
    IF(stock_quantity > 0, 'Available', 'Out of Stock') AS availability
FROM products;

-- 7. Nested conditional logic
SELECT 
    product_name,
    stock_quantity,
    CASE
        WHEN stock_quantity = 0 THEN 'Out of Stock'
        WHEN stock_quantity <= 20 THEN 'Low Stock - Reorder'
        WHEN stock_quantity <= 50 THEN 'Medium Stock'
        ELSE 'High Stock'
    END AS stock_alert
FROM products;

-- Exercises
-- Exercise 1: Label stock: High (>70), Medium (21-70), Low (<=20), None (0)
SELECT 
    product_name, 
    stock_quantity,
    CASE
        WHEN stock_quantity = 0 THEN 'None'
        WHEN stock_quantity <= 20 THEN 'Low'
        WHEN stock_quantity <= 70 THEN 'Medium'
        ELSE 'High'
    END AS stock_level
FROM products;

-- Exercise 2: Show final price with discount (use COALESCE), round to 2 decimals
SELECT 
    product_name,
    price,
    ROUND(price * (1 - COALESCE(discount_percentage, 0)/100), 2) AS sale_price
FROM products;

-- Exercise 3: Use NULLIF to hide zero stock as NULL
SELECT 
    product_name,
    NULLIF(stock_quantity, 0) AS available_qty
FROM products;

-- Combined Exercise
SELECT 
    product_name,
    price,
    stock_quantity,
    COALESCE(description, 'No description') AS desc,
    CASE 
        WHEN stock_quantity = 0 THEN 'Sold Out'
        ELSE CONCAT(stock_quantity, ' in stock')
    END AS status,
    IF(discount_percentage > 0, 'On Sale', 'Regular Price') AS promo
FROM products
ORDER BY price DESC;

-- Cleanup
DROP DATABASE IF EXISTS retail_db;