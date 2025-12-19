-- SQL_Stored_Procedures.sql
-- Guide to MySQL Stored Procedures

CREATE DATABASE IF NOT EXISTS retail_db;
USE retail_db;

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    order_date DATE DEFAULT (CURRENT_DATE),
    quantity INT,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Sample data
INSERT INTO products (product_name, category, price, stock_quantity) VALUES
('Laptop Pro', 'Electronics', 999.99, 50),
('Smartphone X', 'Electronics', 699.99, 100),
('Coffee Maker', 'Appliances', 49.99, 30),
('Wireless Headphones', 'Electronics', 89.99, 75),
('Blender', 'Appliances', 39.99, 20);

-- 1. No parameters
DELIMITER //
CREATE PROCEDURE GetAllProducts()
BEGIN
    SELECT * FROM products;
END //
DELIMITER ;

CALL GetAllProducts();

-- 2. IN parameters
DELIMITER //
CREATE PROCEDURE GetProductsByCategory(IN cat VARCHAR(50))
BEGIN
    SELECT * FROM products WHERE category = cat;
END //
DELIMITER ;

CALL GetProductsByCategory('Electronics');

-- 3. OUT parameters
DELIMITER //
CREATE PROCEDURE GetStockCount(OUT total INT)
BEGIN
    SELECT COUNT(*) INTO total FROM products WHERE stock_quantity > 0;
END //
DELIMITER ;

CALL GetStockCount(@cnt);
SELECT @cnt AS available_products;

-- 4. IN + OUT + logic
DELIMITER //
CREATE PROCEDURE PlaceOrder(
    IN p_id INT,
    IN qty INT,
    OUT total DECIMAL(10,2),
    OUT new_stock INT
)
BEGIN
    DECLARE p_price DECIMAL(10,2);
    
    SELECT price INTO p_price FROM products WHERE product_id = p_id;
    
    SET total = p_price * qty;
    
    INSERT INTO orders (product_id, quantity, total_amount)
    VALUES (p_id, qty, total);
    
    UPDATE products 
    SET stock_quantity = stock_quantity - qty
    WHERE product_id = p_id;
    
    SELECT stock_quantity INTO new_stock 
    FROM products WHERE product_id = p_id;
END //
DELIMITER ;

CALL PlaceOrder(1, 3, @order_total, @remaining);
SELECT @order_total AS total_amount, @remaining AS remaining_stock;

-- 5. INOUT parameter
DELIMITER //
CREATE PROCEDURE ApplyDiscount(INOUT amount DECIMAL(10,2), IN pct DECIMAL(5,2))
BEGIN
    SET amount = amount * (1 - pct / 100);
END //
DELIMITER ;

SET @price = 999.99;
CALL ApplyDiscount(@price, 10.00);
SELECT @price AS discounted_price;

-- Exercises
-- Exercise 1: Procedure to get low stock (<30)
DELIMITER //
CREATE PROCEDURE GetLowStock()
BEGIN
    SELECT product_name, stock_quantity 
    FROM products 
    WHERE stock_quantity < 30;
END //
DELIMITER ;

CALL GetLowStock();

-- Drop procedures
DROP PROCEDURE IF EXISTS GetAllProducts;
DROP PROCEDURE IF EXISTS GetProductsByCategory;
DROP PROCEDURE IF EXISTS GetStockCount;
DROP PROCEDURE IF EXISTS PlaceOrder;
DROP PROCEDURE IF EXISTS ApplyDiscount;
DROP PROCEDURE IF EXISTS GetLowStock;

-- Cleanup
DROP DATABASE IF EXISTS retail_db;