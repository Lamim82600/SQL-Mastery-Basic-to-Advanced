-- Create Database
CREATE DATABASE retail_db;
USE retail_db;

-- Create Table: products
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10, 2)
);

-- Create Table: orders
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    product_id INT,
    order_date DATE,
    quantity INT,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert Sample Data into products
INSERT INTO products (product_id, product_name, category, price) VALUES
(1, 'Laptop Pro', 'Electronics', 999.99),
(2, 'Smartphone X', 'Electronics', 699.99),
(3, 'Coffee Maker', 'Appliances', 49.99),
(4, 'Wireless Headphones', 'Electronics', 89.99),
(5, 'Blender', 'Appliances', 39.99);

-- Insert Sample Data into orders
INSERT INTO orders (order_id, product_id, order_date, quantity) VALUES
(101, 1, '2023-07-01', 2),
(102, 2, '2023-07-05', 1),
(103, 3, '2023-07-10', 3),
(104, 1, '2023-07-15', 1),
(105, 4, '2023-07-20', 5);

-- Aggregations Operations: Detailed Examples and Exercises

-- 1. COUNT
-- Purpose: Counts the number of rows (or non-NULL values in a column).
-- Syntax: SELECT COUNT(column) FROM table;
SELECT COUNT(*) AS total_products FROM products;
-- Output: 5 (total products).

-- Example: Count orders per product
SELECT p.product_name, COUNT(o.order_id) AS order_count
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_name;
-- Output: Laptop Pro (2), Smartphone X (1), Coffee Maker (1), Wireless Headphones (1), Blender (0).

-- Exercise 1: Count the number of orders placed in July 2023.
-- Solution:
-- SELECT COUNT(*) AS july_orders
-- FROM orders
-- WHERE order_date LIKE '2023-07%';

-- 2. SUM
-- Purpose: Calculates the sum of a numeric column.
-- Syntax: SELECT SUM(column) FROM table;
SELECT SUM(quantity) AS total_quantity_ordered
FROM orders;
-- Output: 12 (total items ordered).

-- Example: Sum of order values
SELECT p.product_name, SUM(o.quantity * p.price) AS total_value
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_name;
-- Output: Laptop Pro (2999.97), Smartphone X (699.99), Coffee Maker (149.97), Wireless Headphones (449.95).

-- Exercise 2: Calculate the total quantity ordered for Electronics products.
-- Solution:
-- SELECT SUM(o.quantity) AS electronics_quantity
-- FROM orders o
-- JOIN products p ON o.product_id = p.product_id
-- WHERE p.category = 'Electronics';

-- 3. AVG
-- Purpose: Calculates the average of a numeric column.
-- Syntax: SELECT AVG(column) FROM table;
SELECT AVG(price) AS average_price
FROM products;
-- Output: 367.99 (average product price).

-- Example: Average order quantity per product
SELECT p.product_name, AVG(o.quantity) AS avg_quantity
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_name;
-- Output: Laptop Pro (1.5), Smartphone X (1), Coffee Maker (3), Wireless Headphones (5).

-- Exercise 3: Calculate the average price of Appliances products.
-- Solution:
-- SELECT AVG(price) AS avg_appliances_price
-- FROM products
-- WHERE category = 'Appliances';

-- 4. MAX
-- Purpose: Returns the maximum value in a column.
-- Syntax: SELECT MAX(column) FROM table;
SELECT MAX(price) AS max_price
FROM products;
-- Output: 999.99 (highest price).

-- Example: Latest order date per product
SELECT p.product_name, MAX(o.order_date) AS latest_order
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_name;
-- Output: Laptop Pro (2023-07-15), Smartphone X (2023-07-05), etc.

-- Exercise 4: Find the maximum quantity in a single order.
-- Solution:
-- SELECT MAX(quantity) AS max_quantity
-- FROM orders;

-- 5. MIN
-- Purpose: Returns the minimum value in a column.
-- Syntax: SELECT MIN(column) FROM table;
SELECT MIN(price) AS min_price
FROM products;
-- Output: 39.99 (lowest price).

-- Example: Earliest order date
SELECT MIN(order_date) AS first_order
FROM orders;
-- Output: 2023-07-01.

-- Exercise 5: Find the minimum price among Electronics products.
-- Solution:
-- SELECT MIN(price) AS min_electronics_price
-- FROM products
-- WHERE category = 'Electronics';

-- 6. GROUP BY
-- Purpose: Groups rows with the same values into summary rows for aggregate functions.
-- Syntax: SELECT column, AGGREGATE(column) FROM table GROUP BY column;
SELECT category, COUNT(*) AS product_count
FROM products
GROUP BY category;
-- Output: Electronics (3), Appliances (2).

-- Example: Total quantity ordered by category
SELECT p.category, SUM(o.quantity) AS total_quantity
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id
GROUP BY p.category;
-- Output: Electronics (9), Appliances (3).

-- Exercise 6: Group orders by product_id and calculate the total quantity ordered.
-- Solution:
-- SELECT product_id, SUM(quantity) AS total_quantity
-- FROM orders
-- GROUP BY product_id;

-- 7. HAVING Clause
-- Purpose: Filters grouped results (like WHERE for aggregates).
-- Syntax: SELECT column, AGGREGATE(column) FROM table GROUP BY column HAVING condition;
SELECT p.product_name, SUM(o.quantity) AS total_quantity
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_name
HAVING SUM(o.quantity) > 2;
-- Output: Coffee Maker (3), Wireless Headphones (5).

-- Exercise 7: Group products by category and show categories with average price > 100.
-- Solution:
-- SELECT category, AVG(price) AS avg_price
-- FROM products
-- GROUP BY category
-- HAVING AVG(price) > 100;

-- Combined Exercise
-- Exercise 8: Group orders by product, calculate COUNT, SUM, AVG, MAX, and MIN of quantity, and filter for products with total quantity > 1 using HAVING.
-- Solution:
-- SELECT p.product_name, 
--        COUNT(o.order_id) AS order_count, 
--        SUM(o.quantity) AS total_quantity, 
--        AVG(o.quantity) AS avg_quantity, 
--        MAX(o.quantity) AS max_quantity, 
--        MIN(o.quantity) AS min_quantity
-- FROM products p
-- JOIN orders o ON p.product_id = o.product_id
-- GROUP BY p.product_name
-- HAVING SUM(o.quantity) > 1;