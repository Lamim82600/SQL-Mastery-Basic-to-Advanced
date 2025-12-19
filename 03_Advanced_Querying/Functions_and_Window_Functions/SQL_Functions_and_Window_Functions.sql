-- SQL_Functions_and_Window_Functions.sql
-- Guide to Scalar Functions and Window Functions

CREATE DATABASE IF NOT EXISTS functions_demo;
USE functions_demo;

CREATE TABLE sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    salesperson VARCHAR(50),
    region VARCHAR(50),
    amount DECIMAL(10,2),
    sale_date DATE
);

INSERT INTO sales (salesperson, region, amount, sale_date) VALUES
('Alice', 'North', 1200.00, '2025-01-05'),
('Bob', 'South', 800.00, '2025-01-10'),
('Alice', 'North', 1500.00, '2025-02-15'),
('Charlie', 'East', 2000.00, '2025-02-20'),
('Bob', 'South', 1100.00, '2025-03-01'),
('Alice', 'North', 900.00, '2025-03-10'),
('Charlie', 'East', 1800.00, '2025-04-05');

-- 1. Scalar Functions
-- String
SELECT salesperson, UPPER(salesperson) AS upper_name, CONCAT(salesperson, ' - ', region) AS info
FROM sales;

-- Numeric
SELECT amount, ROUND(amount, 0) AS rounded, ABS(-amount) AS abs_val
FROM sales;

-- Date
SELECT sale_date, YEAR(sale_date) AS year, MONTH(sale_date) AS month, DATE_FORMAT(sale_date, '%M %Y') AS formatted
FROM sales;

-- Conditional: GREATEST, LEAST
SELECT amount, GREATEST(amount, 1000) AS at_least_1000
FROM sales;

-- 2. Window Functions
-- ROW_NUMBER()
SELECT 
    salesperson,
    amount,
    ROW_NUMBER() OVER (PARTITION BY salesperson ORDER BY amount DESC) AS rank_in_person
FROM sales;

-- RANK() & DENSE_RANK()
SELECT 
    region,
    amount,
    RANK() OVER (PARTITION BY region ORDER BY amount DESC) AS rank,
    DENSE_RANK() OVER (PARTITION BY region ORDER BY amount DESC) AS dense_rank
FROM sales
ORDER BY region, amount DESC;

-- SUM() OVER
SELECT 
    salesperson,
    sale_date,
    amount,
    SUM(amount) OVER (PARTITION BY salesperson) AS total_per_person,
    SUM(amount) OVER () AS grand_total
FROM sales;

-- AVG() and running total
SELECT 
    sale_date,
    amount,
    AVG(amount) OVER (PARTITION BY MONTH(sale_date)) AS monthly_avg,
    SUM(amount) OVER (ORDER BY sale_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM sales
ORDER BY sale_date;

-- LAG() / LEAD()
SELECT 
    salesperson,
    sale_date,
    amount,
    LAG(amount, 1) OVER (PARTITION BY salesperson ORDER BY sale_date) AS prev_sale,
    LEAD(amount, 1) OVER (PARTITION BY salesperson ORDER BY sale_date) AS next_sale
FROM sales
ORDER BY salesperson, sale_date;

-- NTILE()
SELECT 
    amount,
    NTILE(4) OVER (ORDER BY amount) AS quartile
FROM sales;

-- Exercises
-- Exercise 1: Rank sales by amount overall
SELECT 
    salesperson, amount,
    RANK() OVER (ORDER BY amount DESC) AS overall_rank
FROM sales;

-- Exercise 2: Percentage of total sales per person
SELECT 
    salesperson,
    amount,
    ROUND(100 * amount / SUM(amount) OVER (), 2) AS percent_of_total
FROM sales;

-- Combined: Full analytics
SELECT 
    salesperson,
    region,
    sale_date,
    amount,
    ROW_NUMBER() OVER (PARTITION BY salesperson ORDER BY amount DESC) AS top_sale_rank,
    SUM(amount) OVER (PARTITION BY region) AS region_total
FROM sales
ORDER BY region, amount DESC;

-- Cleanup
DROP DATABASE IF EXISTS functions_demo;