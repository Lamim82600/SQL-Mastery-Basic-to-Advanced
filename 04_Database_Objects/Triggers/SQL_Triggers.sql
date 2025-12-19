-- SQL_Triggers.sql
-- Guide to MySQL Triggers: BEFORE/AFTER INSERT/UPDATE/DELETE

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

CREATE TABLE audit_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    table_name VARCHAR(50),
    action VARCHAR(50),
    record_id INT,
    old_value VARCHAR(200),
    new_value VARCHAR(200),
    log_time DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Sample data
INSERT INTO products (product_name, category, price, stock_quantity) VALUES
('Laptop Pro', 'Electronics', 999.99, 50),
('Smartphone X', 'Electronics', 699.99, 100),
('Coffee Maker', 'Appliances', 49.99, 30);

-- 1. BEFORE INSERT: Calculate total_amount
DELIMITER //
CREATE TRIGGER calc_total_before_insert
BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
    DECLARE p_price DECIMAL(10,2);
    SELECT price INTO p_price FROM products WHERE product_id = NEW.product_id;
    SET NEW.total_amount = p_price * NEW.quantity;
END //
DELIMITER ;

-- 2. BEFORE INSERT: Validate stock
DELIMITER //
CREATE TRIGGER check_stock_before_insert
BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
    IF (SELECT stock_quantity FROM products WHERE product_id = NEW.product_id) < NEW.quantity THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient stock';
    END IF;
END //
DELIMITER ;

-- 3. AFTER INSERT: Reduce stock + log
DELIMITER //
CREATE TRIGGER reduce_stock_after_insert
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    UPDATE products SET stock_quantity = stock_quantity - NEW.quantity
    WHERE product_id = NEW.product_id;
    
    INSERT INTO audit_log (table_name, action, record_id, new_value)
    VALUES ('orders', 'INSERT', NEW.order_id, CONCAT('Qty: ', NEW.quantity, ', Total: ', NEW.total_amount));
END //
DELIMITER ;

-- 4. AFTER UPDATE: Log price change
DELIMITER //
CREATE TRIGGER log_price_update
AFTER UPDATE ON products
FOR EACH ROW
BEGIN
    IF OLD.price <> NEW.price THEN
        INSERT INTO audit_log (table_name, action, record_id, old_value, new_value)
        VALUES ('products', 'PRICE_UPDATE', NEW.product_id, OLD.price, NEW.price);
    END IF;
END //
DELIMITER ;

-- 5. AFTER DELETE: Log deletion
DELIMITER //
CREATE TRIGGER log_order_delete
AFTER DELETE ON orders
FOR EACH ROW
BEGIN
    INSERT INTO audit_log (table_name, action, record_id, old_value)
    VALUES ('orders', 'DELETE', OLD.order_id, CONCAT('Qty: ', OLD.quantity));
END //
DELIMITER ;

-- Test
INSERT INTO orders (product_id, quantity) VALUES (1, 5);  -- Triggers fire
UPDATE products SET price = 1099.99 WHERE product_id = 1;
DELETE FROM orders WHERE order_id = 1;

SELECT * FROM audit_log;
SELECT * FROM products;

-- Drop triggers
DROP TRIGGER calc_total_before_insert;
DROP TRIGGER check_stock_before_insert;
DROP TRIGGER reduce_stock_after_insert;
DROP TRIGGER log_price_update;
DROP TRIGGER log_order_delete;

-- Cleanup
DROP DATABASE IF EXISTS retail_db;