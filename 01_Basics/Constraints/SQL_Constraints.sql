-- SQL_Constraints.sql
-- Comprehensive guide to MySQL Constraints with examples and exercises

CREATE DATABASE IF NOT EXISTS constraints_demo;
USE constraints_demo;

-- Supporting tables
CREATE TABLE departments (
    dept_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT DEFAULT 0
);

-- 1. PRIMARY KEY
-- Ensures unique, non-NULL identifier
-- Already on product_id (AUTO_INCREMENT + PRIMARY KEY)

INSERT INTO products (product_name, price, stock_quantity)
VALUES ('Laptop Pro', 999.99, 50);

-- Adding composite PRIMARY KEY example
CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    PRIMARY KEY (order_id, product_id)  -- Composite PK
);

-- 2. FOREIGN KEY
-- Enforces referential integrity
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    quantity INT,
    CONSTRAINT fk_product
        FOREIGN KEY (product_id) REFERENCES products(product_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Test FK
INSERT INTO orders (product_id, quantity) VALUES (1, 3);  -- Success
-- INSERT INTO orders (product_id, quantity) VALUES (999, 1);  -- Fails

-- 3. UNIQUE
-- Ensures uniqueness (allows NULL by default)
ALTER TABLE products ADD COLUMN sku VARCHAR(50);
ALTER TABLE products ADD UNIQUE (sku);

ALTER TABLE products ADD UNIQUE uk_product_name (product_name);  -- Named constraint

-- 4. NOT NULL
ALTER TABLE products MODIFY stock_quantity INT NOT NULL DEFAULT 0;

-- 5. CHECK
-- Validates data against condition
ALTER TABLE products ADD CONSTRAINT chk_price CHECK (price > 0);
ALTER TABLE products ADD CONSTRAINT chk_stock CHECK (stock_quantity >= 0);

ALTER TABLE orders ADD CONSTRAINT chk_quantity CHECK (quantity > 0);

-- 6. DEFAULT
ALTER TABLE orders ADD COLUMN status VARCHAR(20) DEFAULT 'Pending';
ALTER TABLE orders ADD COLUMN order_date DATE DEFAULT (CURRENT_DATE);

-- Full table with multiple constraints
CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    salary DECIMAL(12, 2) NOT NULL CHECK (salary >= 0),
    dept_id INT DEFAULT NULL,
    hire_date DATE DEFAULT (CURRENT_DATE),
    is_active BOOLEAN DEFAULT TRUE,
    
    CONSTRAINT fk_dept
        FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
        ON DELETE SET NULL
);

-- Insert sample data
INSERT INTO departments (dept_name) VALUES ('Engineering'), ('Sales');

INSERT INTO employees (emp_name, email, salary, dept_id)
VALUES ('Alice Smith', 'alice@company.com', 75000.00, 1);

-- Exercises
-- Exercise 1: Add UNIQUE constraint on email in orders if customer emails are stored
-- ALTER TABLE orders ADD COLUMN customer_email VARCHAR(100) UNIQUE;

-- Exercise 2: Add CHECK constraint to ensure salary <= 500000
-- ALTER TABLE employees ADD CONSTRAINT chk_max_salary CHECK (salary <= 500000);

-- Exercise 3: Create table 'suppliers' with supplier_id (PK), name (NOT NULL), rating (1-5 via CHECK)
CREATE TABLE suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    rating TINYINT CHECK (rating BETWEEN 1 AND 5),
    credit_limit DECIMAL(12,2) DEFAULT 10000.00
);

-- Cleanup
DROP DATABASE IF EXISTS constraints_demo;