-- SQL_Transaction_Control_Language.sql
-- Guide to MySQL Transactions: START, COMMIT, ROLLBACK, SAVEPOINT

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
    quantity INT,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Sample data
INSERT INTO products (product_name, category, price, stock_quantity) VALUES
('Laptop Pro', 'Electronics', 999.99, 50),
('Smartphone X', 'Electronics', 699.99, 100),
('Coffee Maker', 'Appliances', 49.99, 30);

-- Disable autocommit
SET AUTOCOMMIT = 0;

-- 1. Basic transaction
START TRANSACTION;
INSERT INTO products (product_name, category, price, stock_quantity)
VALUES ('Headphones', 'Electronics', 89.99, 75);
UPDATE products SET stock_quantity = stock_quantity - 10 WHERE product_id = 1;
COMMIT;

-- 2. ROLLBACK
START TRANSACTION;
UPDATE products SET price = price * 1.1 WHERE category = 'Electronics';
SELECT * FROM products;  -- Shows increased prices
ROLLBACK;
SELECT * FROM products;  -- Prices restored

-- 3. SAVEPOINT
START TRANSACTION;
INSERT INTO orders (product_id, quantity) VALUES (1, 5);
SAVEPOINT after_order;
UPDATE products SET stock_quantity = stock_quantity - 5 WHERE product_id = 1;
ROLLBACK TO SAVEPOINT after_order;
COMMIT;  -- Keeps order, undoes stock update

-- 4. Isolation levels
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION;
SELECT stock_quantity FROM products WHERE product_id = 1;
-- Another session updates stock...
SELECT stock_quantity FROM products WHERE product_id = 1;  -- Same value
COMMIT;

-- 5. Read-only
SET TRANSACTION READ ONLY;
START TRANSACTION;
SELECT * FROM products;  -- OK
-- UPDATE products ...;  -- Error
COMMIT;

-- Exercises
-- Exercise 1: Transfer stock between products
START TRANSACTION;
UPDATE products SET stock_quantity = stock_quantity - 10 WHERE product_id = 1;
UPDATE products SET stock_quantity = stock_quantity + 10 WHERE product_id = 2;
COMMIT;

-- Re-enable autocommit
SET AUTOCOMMIT = 1;

-- Cleanup
DROP DATABASE IF EXISTS retail_db;