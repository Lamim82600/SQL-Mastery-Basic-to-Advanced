-- SQL_REVOKE_Operations.sql
-- Guide to MySQL REVOKE privileges and roles

CREATE DATABASE IF NOT EXISTS retail_db;
USE retail_db;

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    quantity INT,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Users
CREATE USER IF NOT EXISTS 'sales'@'localhost' IDENTIFIED BY 'pass';
CREATE USER IF NOT EXISTS 'manager'@'localhost' IDENTIFIED BY 'pass';
CREATE USER IF NOT EXISTS 'inventory'@'localhost' IDENTIFIED BY 'pass';

-- Initial GRANTs
GRANT SELECT, INSERT ON retail_db.products TO 'sales'@'localhost';
GRANT ALL PRIVILEGES ON retail_db.* TO 'manager'@'localhost';
GRANT SELECT, UPDATE ON retail_db.orders TO 'inventory'@'localhost';

-- Roles
CREATE ROLE 'sales_role';
GRANT SELECT ON retail_db.* TO 'sales_role';
GRANT 'sales_role' TO 'sales'@'localhost';

CREATE ROLE 'inventory_role';
GRANT UPDATE ON retail_db.orders TO 'inventory_role';
GRANT 'inventory_role' TO 'inventory'@'localhost';

-- 1. REVOKE specific privileges
REVOKE INSERT ON retail_db.products FROM 'sales'@'localhost';

REVOKE UPDATE ON retail_db.orders FROM 'inventory'@'localhost';

-- 2. REVOKE ALL
REVOKE ALL PRIVILEGES ON retail_db.* FROM 'manager'@'localhost';

-- 3. REVOKE roles
REVOKE 'sales_role' FROM 'sales'@'localhost';

REVOKE 'inventory_role' FROM 'inventory'@'localhost';

-- 4. REVOKE GRANT OPTION
REVOKE GRANT OPTION FOR SELECT ON retail_db.* FROM 'manager'@'localhost';

-- Verify
SHOW GRANTS FOR 'sales'@'localhost';
SHOW GRANTS FOR 'inventory'@'localhost';

FLUSH PRIVILEGES;

-- Exercises
-- Exercise 1: Revoke SELECT on products from sales
REVOKE SELECT ON retail_db.products FROM 'sales'@'localhost';

-- Exercise 2: Drop roles
DROP ROLE 'sales_role', 'inventory_role';

-- Cleanup
-- DROP USER 'sales'@'localhost', 'manager'@'localhost', 'inventory'@'localhost';
-- DROP DATABASE retail_db;