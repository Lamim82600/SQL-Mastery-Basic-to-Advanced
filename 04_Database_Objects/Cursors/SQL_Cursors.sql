-- SQL_Cursors.sql
-- Guide to MySQL Cursors in Stored Procedures

CREATE DATABASE IF NOT EXISTS retail_db;
USE retail_db;

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0
);

CREATE TABLE update_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    old_stock INT,
    new_stock INT,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Sample data
INSERT INTO products (product_name, category, price, stock_quantity) VALUES
('Laptop Pro', 'Electronics', 999.99, 45),
('Smartphone X', 'Electronics', 699.99, 80),
('Coffee Maker', 'Appliances', 49.99, 15),
('Wireless Headphones', 'Electronics', 89.99, 30),
('Blender', 'Appliances', 39.99, 10);

-- 1. Basic Cursor: Restock low-stock items
DELIMITER //
CREATE PROCEDURE RestockLowItems()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_id INT;
    DECLARE v_name VARCHAR(100);
    DECLARE v_stock INT;

    DECLARE cur CURSOR FOR
        SELECT product_id, product_name, stock_quantity
        FROM products
        WHERE stock_quantity < 40;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO v_id, v_name, v_stock;
        IF done THEN
            LEAVE read_loop;
        END IF;

        INSERT INTO update_log (product_id, old_stock, new_stock)
        VALUES (v_id, v_stock, v_stock + 50);

        UPDATE products
        SET stock_quantity = stock_quantity + 50
        WHERE product_id = v_id;
    END LOOP;

    CLOSE cur;
END //
DELIMITER ;

-- Test
CALL RestockLowItems();
SELECT * FROM update_log;
SELECT product_name, stock_quantity FROM products WHERE stock_quantity > 40;

-- 2. Cursor with conditional update
DELIMITER //
CREATE PROCEDURE ApplyDiscount()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_id INT;
    DECLARE v_price DECIMAL(10,2);

    DECLARE price_cur CURSOR FOR
        SELECT product_id, price FROM products WHERE category = 'Electronics';

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN price_cur;

    discount_loop: LOOP
        FETCH price_cur INTO v_id, v_price;
        IF done THEN
            LEAVE discount_loop;
        END IF;

        IF v_price > 500 THEN
            UPDATE products SET price = price * 0.9 WHERE product_id = v_id;
        END IF;
    END LOOP;

    CLOSE price_cur;
END //
DELIMITER ;

-- Test
CALL ApplyDiscount();
SELECT product_name, price FROM products WHERE category = 'Electronics';

-- Exercises
-- Exercise 1: Cursor to log high-price products (>500)
DELIMITER //
CREATE PROCEDURE LogPremiumProducts()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_id INT;
    DECLARE v_name VARCHAR(100);
    DECLARE v_price DECIMAL(10,2);

    DECLARE prem_cur CURSOR FOR
        SELECT product_id, product_name, price FROM products WHERE price > 500;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN prem_cur;

    log_loop: LOOP
        FETCH prem_cur INTO v_id, v_name, v_price;
        IF done THEN LEAVE log_loop; END IF;

        INSERT INTO update_log (product_id, old_stock, new_stock)
        VALUES (v_id, v_price, NULL);  -- Reuse log table creatively
    END LOOP;

    CLOSE prem_cur;
END //
DELIMITER ;

-- Cleanup
DROP PROCEDURE IF EXISTS RestockLowItems;
DROP PROCEDURE IF EXISTS ApplyDiscount;
DROP PROCEDURE IF EXISTS LogPremiumProducts;
DROP TABLE update_log;
DROP TABLE products;
DROP DATABASE retail_db;