-- SQL_Data_Types.sql
-- Comprehensive guide to MySQL Data Types with examples

CREATE DATABASE IF NOT EXISTS datatype_demo;
USE datatype_demo;

-- 1. Numeric Types
CREATE TABLE numeric_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    
    -- Integer types
    tiny_val TINYINT,          -- -128 to 127
    small_val SMALLINT,        -- -32768 to 32767
    med_val MEDIUMINT,         -- -8388608 to 8388607
    int_val INT,               -- -2^31 to 2^31-1
    big_val BIGINT,            -- -2^63 to 2^63-1
    
    -- Fixed-point
    dec_val DECIMAL(10,2),     -- Exact: 10 digits, 2 after decimal
    
    -- Floating-point
    float_val FLOAT,           -- Approx ~7 decimal digits
    double_val DOUBLE          -- Approx ~15 decimal digits
);

INSERT INTO numeric_types 
(tiny_val, small_val, med_val, int_val, big_val, dec_val, float_val, double_val)
VALUES (127, 32767, 8388607, 2147483647, 9223372036854775807, 99999999.99, 3.14159, 3.141592653589793);

-- 2. String Types
CREATE TABLE string_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    
    char_val CHAR(10),         -- Fixed length, padded with spaces
    varchar_val VARCHAR(255),  -- Variable length, up to 255 chars
    
    tinytext_val TINYTEXT,     -- Max 255 chars
    text_val TEXT,             -- Max 65,535 chars
    mediumtext_val MEDIUMTEXT, -- Max ~16MB
    longtext_val LONGTEXT,     -- Max ~4GB
    
    binary_val BINARY(10),     -- Fixed binary
    varbinary_val VARBINARY(255)
);

INSERT INTO string_types (char_val, varchar_val, text_val)
VALUES ('Hello', 'Hello World', 'This is a longer text example for demonstration.');

-- 3. Date & Time Types
CREATE TABLE datetime_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    
    date_val DATE,             -- 'YYYY-MM-DD'
    time_val TIME,             -- 'HH:MM:SS'
    datetime_val DATETIME,     -- 'YYYY-MM-DD HH:MM:SS'
    timestamp_val TIMESTAMP,   -- Unix timestamp, auto-update possible
    year_val YEAR              -- 1901 to 2155
);

INSERT INTO datetime_types 
(date_val, time_val, datetime_val, timestamp_val, year_val)
VALUES 
('2025-12-19', '14:30:00', '2025-12-19 14:30:00', NOW(), 2025);

-- 4. Boolean
CREATE TABLE boolean_example (
    id INT PRIMARY KEY,
    is_active BOOLEAN          -- Stored as TINYINT(1): 0 = false, 1 = true
);

INSERT INTO boolean_example VALUES (1, TRUE), (2, FALSE);

-- 5. ENUM & SET
CREATE TABLE enum_set_example (
    id INT AUTO_INCREMENT PRIMARY KEY,
    
    status ENUM('active', 'inactive', 'pending'),  -- Restricted to list
    features SET('wifi', 'parking', 'pool', 'gym') -- Multiple selections
);

INSERT INTO enum_set_example (status, features)
VALUES ('active', 'wifi,parking,pool');

-- 6. JSON Type
CREATE TABLE json_example (
    id INT AUTO_INCREMENT PRIMARY KEY,
    metadata JSON
);

INSERT INTO json_example (metadata)
VALUES ('{"name": "Product A", "tags": ["new", "sale"], "price": 99.99}');

-- Query JSON
SELECT metadata->>"$.name" AS product_name FROM json_example;

-- Cleanup
DROP DATABASE datatype_demo;