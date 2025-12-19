-- SQL_Subqueries.sql
-- Comprehensive guide to subqueries: scalar, multi-row, correlated, nested

CREATE DATABASE IF NOT EXISTS retail_db;
USE retail_db;

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT DEFAULT 0
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    order_date DATE,
    quantity INT NOT NULL,
    total_amount DECIMAL(10, 2) AS (quantity * (SELECT price FROM products p WHERE p.product_id = orders.product_id)) STORED,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Sample data
INSERT INTO products (product_name, category, price, stock_quantity) VALUES
('Laptop Pro', 'Electronics', 999.99, 50),
('Smartphone X', 'Electronics', 699.99, 100),
('Coffee Maker', 'Appliances', 49.99, 30),
('Wireless Headphones', 'Electronics', 89.99, 75),
('Blender', 'Appliances', 39.99, 20),
('Smart TV', 'Electronics', 499.99, 0);

INSERT INTO orders (product_id, order_date, quantity) VALUES
(1, '2025-01-10', 2),
(2, '2025-01-15', 1),
(3, '2025-02-01', 3),
(1, '2025-02-20', 1),
(4, '2025-03-05', 5),
(2, '2025-03-10', 2);

-- 1. Scalar subquery
SELECT product_name, price
FROM products
WHERE price = (SELECT MAX(price) FROM products);

-- 2. Multi-row: IN
SELECT product_name
FROM products
WHERE product_id IN (SELECT product_id FROM orders WHERE quantity > 2);

-- 3. Multi-row: ANY / ALL
SELECT product_name, price
FROM products
WHERE price > ANY (SELECT price FROM products WHERE category = 'Appliances');

SELECT product_name, price
FROM products
WHERE price > ALL (SELECT price FROM products WHERE category = 'Appliances');

-- 4. Correlated subquery
SELECT product_name, stock_quantity
FROM products p
WHERE EXISTS (
    SELECT 1 FROM orders o
    WHERE o.product_id = p.product_id
);

-- Above average in category
SELECT product_name, price, category
FROM products p1
WHERE price > (
    SELECT AVG(price)
    FROM products p2
    WHERE p2.category = p1.category
);

-- 5. Nested subqueries
SELECT product_name, total_amount
FROM products p
JOIN orders o ON p.product_id = o.product_id
WHERE o.total_amount > (
    SELECT AVG(total_amount) FROM orders
);

-- Cheapest in top category by sales
SELECT product_name, price
FROM products
WHERE category = (
    SELECT category
    FROM products p
    JOIN orders o ON p.product_id = o.product_id
    GROUP BY category
    ORDER BY SUM(o.quantity) DESC
    LIMIT 1
)
ORDER BY price ASC
LIMIT 1;

-- Exercises
-- Exercise 1: Products ordered more than average quantity
SELECT product_name
FROM products
WHERE product_id IN (
    SELECT product_id
    FROM orders
    WHERE quantity > (SELECT AVG(quantity) FROM orders)
);

-- Exercise 2: Products never ordered
SELECT product_name
FROM products p
WHERE NOT EXISTS (
    SELECT 1 FROM orders o WHERE o.product_id = p.product_id
);

-- Exercise 3: Category with highest average price
SELECT category, AVG(price) AS avg_price
FROM products
GROUP BY category
HAVING avg_price = (
    SELECT MAX(avg_price)
    FROM (SELECT AVG(price) AS avg_price FROM products GROUP BY category) AS sub
);

-- Combined: High-value ordered products above category avg price
SELECT p.product_name, p.price, o.total_amount
FROM products p
JOIN orders o ON p.product_id = o.product_id
WHERE o.total_amount > 500
  AND p.price > (SELECT AVG(price) FROM products p2 WHERE p2.category = p.category);

-- Cleanup
DROP DATABASE IF EXISTS retail_db;