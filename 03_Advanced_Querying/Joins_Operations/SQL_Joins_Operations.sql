-- SQL_Joins_Operations.sql
-- Comprehensive guide to SQL Joins with examples and exercises

CREATE DATABASE IF NOT EXISTS retail_db;
USE retail_db;

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    customer_id INT,
    order_date DATE,
    quantity INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100),
    region VARCHAR(50)
);

CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);

-- Sample data
INSERT INTO products (product_name, category, price) VALUES
('Laptop Pro', 'Electronics', 999.99),
('Smartphone X', 'Electronics', 699.99),
('Coffee Maker', 'Appliances', 49.99),
('Wireless Headphones', 'Electronics', 89.99),
('Blender', 'Appliances', 39.99);

INSERT INTO customers (customer_name, region) VALUES
('Alice Corp', 'North'),
('Bob Inc', 'South'),
('Charlie Ltd', 'East');

INSERT INTO orders (product_id, customer_id, order_date, quantity) VALUES
(1, 1, '2025-01-10', 2),
(2, 2, '2025-01-15', 1),
(3, 3, '2025-02-01', 3),
(1, 2, '2025-02-20', 1),
(4, 1, '2025-03-05', 5);

INSERT INTO employees (employee_name, manager_id) VALUES
('CEO', NULL),
('VP Sales', 1),
('VP Engineering', 1),
('Sales Rep', 2),
('Engineer', 3);

-- 1. INNER JOIN
SELECT p.product_name, o.order_id, o.quantity
FROM products p
INNER JOIN orders o ON p.product_id = o.product_id;

-- 2. LEFT JOIN
SELECT p.product_name, o.order_id, COALESCE(o.quantity, 0) AS quantity
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id;

-- 3. RIGHT JOIN
SELECT p.product_name, o.order_id
FROM products p
RIGHT JOIN orders o ON p.product_id = o.product_id;

-- 4. FULL OUTER JOIN (MySQL simulation)
SELECT p.product_name, o.order_id
FROM products p LEFT JOIN orders o ON p.product_id = o.product_id
UNION
SELECT p.product_name, o.order_id
FROM products p RIGHT JOIN orders o ON p.product_id = o.product_id
WHERE p.product_id IS NULL;

-- 5. Multiple Joins
SELECT 
    c.customer_name,
    p.product_name,
    o.quantity,
    o.order_date
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN products p ON o.product_id = p.product_id;

-- 6. Self-Join
SELECT 
    e.employee_name AS employee,
    COALESCE(m.employee_name, 'Top') AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id;

-- 7. CROSS JOIN
SELECT p.product_name, c.region
FROM products p
CROSS JOIN customers c
LIMIT 10;

-- Exercises
-- Exercise 1: All products with total quantity sold
SELECT 
    p.product_name,
    COALESCE(SUM(o.quantity), 0) AS total_sold
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_name;

-- Exercise 2: Customers and their orders (include customers with no orders)
SELECT 
    c.customer_name,
    o.order_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

-- Exercise 3: Employee hierarchy with levels (use self-join in CTE if needed)
-- Simple self-join above covers it

-- Combined: Sales report
SELECT 
    p.category,
    SUM(o.quantity) AS units_sold,
    SUM(o.quantity * p.price) AS revenue
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id
GROUP BY p.category;

-- Cleanup
DROP DATABASE IF EXISTS retail_db;