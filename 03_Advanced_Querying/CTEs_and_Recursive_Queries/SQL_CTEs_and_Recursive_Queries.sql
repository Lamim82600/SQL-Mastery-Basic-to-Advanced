-- SQL_CTEs_and_Recursive_Queries.sql
-- Comprehensive guide to Common Table Expressions (CTEs) and Recursive Queries

CREATE DATABASE IF NOT EXISTS cte_demo;
USE cte_demo;

-- Sample table: employees (for hierarchy)
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    manager_id INT,  -- NULL for top manager
    salary DECIMAL(10,2),
    FOREIGN KEY (manager_id) REFERENCES employees(emp_id)
);

-- Insert hierarchical data
INSERT INTO employees (emp_id, name, manager_id, salary) VALUES
(1, 'CEO', NULL, 200000.00),
(2, 'VP Sales', 1, 150000.00),
(3, 'VP Engineering', 1, 150000.00),
(4, 'Sales Manager', 2, 100000.00),
(5, 'Engineer Lead', 3, 120000.00),
(6, 'Sales Rep', 4, 80000.00),
(7, 'Senior Engineer', 5, 90000.00),
(8, 'Junior Engineer', 5, 60000.00);

-- Sample table: sales (for non-recursive CTE)
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product VARCHAR(50),
    amount DECIMAL(10,2),
    sale_date DATE
);

INSERT INTO sales (sale_id, product, amount, sale_date) VALUES
(1, 'Laptop', 999.99, '2025-01-10'),
(2, 'Phone', 699.99, '2025-01-15'),
(3, 'Laptop', 999.99, '2025-02-01'),
(4, 'Tablet', 299.99, '2025-02-10'),
(5, 'Laptop', 999.99, '2025-03-05');

-- 1. Simple (Non-Recursive) CTE
WITH high_salary AS (
    SELECT name, salary
    FROM employees
    WHERE salary > 100000
)
SELECT * FROM high_salary;

-- Multiple CTEs
WITH
    leads AS (SELECT * FROM employees WHERE manager_id IN (2,3)),
    top_earners AS (SELECT * FROM employees WHERE salary > 120000)
SELECT * FROM leads
UNION
SELECT * FROM top_earners;

-- 2. CTE for aggregation
WITH monthly_sales AS (
    SELECT 
        MONTH(sale_date) AS month,
        SUM(amount) AS total
    FROM sales
    GROUP BY MONTH(sale_date)
)
SELECT * FROM monthly_sales ORDER BY total DESC;

-- 3. Recursive CTE: Employee hierarchy (downward)
WITH RECURSIVE org_chart AS (
    -- Anchor: Top manager
    SELECT emp_id, name, manager_id, 0 AS level
    FROM employees
    WHERE manager_id IS NULL
    
    UNION ALL
    
    -- Recursive: Subordinates
    SELECT e.emp_id, e.name, e.manager_id, oc.level + 1
    FROM employees e
    JOIN org_chart oc ON e.manager_id = oc.emp_id
)
SELECT 
    REPEAT('  ', level) || name AS hierarchy,
    level
FROM org_chart
ORDER BY level, name;

-- 4. Recursive CTE: Upward hierarchy (to CEO)
WITH RECURSIVE reports_to AS (
    -- Anchor: Specific employee
    SELECT emp_id, name, manager_id, name AS path
    FROM employees
    WHERE emp_id = 8  -- Junior Engineer
    
    UNION ALL
    
    -- Recursive: Manager
    SELECT e.emp_id, e.name, e.manager_id, CONCAT(rt.path, ' -> ', e.name)
    FROM employees e
    JOIN reports_to rt ON e.emp_id = rt.manager_id
)
SELECT name, path FROM reports_to;

-- 5. Recursive: Generate numbers (1 to 10)
WITH RECURSIVE numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM numbers WHERE n < 10
)
SELECT * FROM numbers;

-- Exercises
-- Exercise 1: CTE for average salary per level
WITH RECURSIVE org AS (
    SELECT emp_id, name, manager_id, salary, 0 AS level
    FROM employees WHERE manager_id IS NULL
    UNION ALL
    SELECT e.emp_id, e.name, e.manager_id, e.salary, org.level + 1
    FROM employees e JOIN org ON e.manager_id = org.emp_id
)
SELECT level, AVG(salary) AS avg_salary
FROM org
GROUP BY level;

-- Exercise 2: Recursive to find all subordinates of VP Engineering (emp_id=3)
WITH RECURSIVE subs AS (
    SELECT emp_id, name
    FROM employees WHERE emp_id = 3
    UNION ALL
    SELECT e.emp_id, e.name
    FROM employees e JOIN subs s ON e.manager_id = s.emp_id
)
SELECT name FROM subs;

-- Cleanup
DROP DATABASE IF EXISTS cte_demo;