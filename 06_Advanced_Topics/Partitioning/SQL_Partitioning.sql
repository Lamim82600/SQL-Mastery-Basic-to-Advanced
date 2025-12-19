-- SQL_Partitioning.sql
-- Guide to MySQL Table Partitioning

CREATE DATABASE IF NOT EXISTS partition_demo;
USE partition_demo;

-- 1. RANGE Partitioning (by date)
CREATE TABLE sales_range (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    sale_date DATE,
    amount DECIMAL(10,2)
) PARTITION BY RANGE (YEAR(sale_date)) (
    PARTITION p0 VALUES LESS THAN (2023),
    PARTITION p1 VALUES LESS THAN (2024),
    PARTITION p2 VALUES LESS THAN (2025),
    PARTITION p3 VALUES LESS THAN MAXVALUE
);

-- Insert data
INSERT INTO sales_range (product_id, sale_date, amount) VALUES
(1, '2022-12-01', 999.99),
(2, '2023-06-15', 699.99),
(4, '2024-01-10', 89.99),
(3, '2025-03-20', 49.99);

-- Query specific partition
SELECT * FROM sales_range PARTITION (p2);

-- 2. LIST Partitioning
CREATE TABLE sales_list (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    region VARCHAR(50),
    amount DECIMAL(10,2)
) PARTITION BY LIST COLUMNS(region) (
    PARTITION p_north VALUES IN ('North', 'Northeast'),
    PARTITION p_south VALUES IN ('South', 'Southeast'),
    PARTITION p_west VALUES IN ('West', 'Northwest'),
    PARTITION p_other VALUES IN (NULL)
);

INSERT INTO sales_list (region, amount) VALUES
('North', 1200.00),
('South', 800.00),
('West', 1500.00),
(NULL, 500.00);

-- 3. HASH Partitioning
CREATE TABLE sales_hash (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10,2)
) PARTITION BY HASH(customer_id) PARTITIONS 4;

INSERT INTO sales_hash (customer_id, amount) VALUES
(101, 999.99),
(102, 699.99),
(103, 499.99),
(104, 299.99);

-- 4. Manage partitions
-- Add partition (RANGE)
ALTER TABLE sales_range ADD PARTITION (PARTITION p4 VALUES LESS THAN (2026));

-- Drop partition
ALTER TABLE sales_range DROP PARTITION p0;

-- Reorganize (split)
ALTER TABLE sales_range REORGANIZE PARTITION p3 INTO (
    PARTITION p3 VALUES LESS THAN (2026),
    PARTITION p_max VALUES LESS THAN MAXVALUE
);

-- Check partitions
SELECT * FROM INFORMATION_SCHEMA.PARTITIONS 
WHERE TABLE_NAME IN ('sales_range', 'sales_list', 'sales_hash');

-- Benefits: Faster queries/deletes on partitions, easier maintenance.

-- Cleanup
DROP TABLE sales_range, sales_list, sales_hash;
DROP DATABASE partition_demo;