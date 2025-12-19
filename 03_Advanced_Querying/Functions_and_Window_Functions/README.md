# SQL Functions and Window Functions

## Overview
SQL functions process data: scalar (row-level), window (over partitions).

The script `SQL_Functions_and_Window_Functions.sql` covers scalar (string, numeric, date) and window functions in MySQL.

## Scalar Functions

### String
- UPPER, LOWER, CONCAT, SUBSTRING.

### Numeric
- ROUND, ABS, CEIL, FLOOR.

### Date
- YEAR, MONTH, DATE_FORMAT, CURDATE.

### Conditional
- GREATEST, LEAST, COALESCE.

## Window Functions

### Ranking
- ROW_NUMBER(), RANK(), DENSE_RANK().

### Aggregates
- SUM(), AVG(), COUNT() OVER partitions.

### Navigation
- LAG(), LEAD(), FIRST_VALUE(), LAST_VALUE().

### Distribution
- NTILE(), PERCENT_RANK().

## Real-World Use Cases
- **Analytics**: Running totals, rankings.
- **Reports**: Moving averages, top-N per group.
- **Dashboards**: Percent of total.
- **Data Prep**: Lag for changes.

## Best Practices
- Use OVER (PARTITION BY ... ORDER BY ...).
- Frame clauses for running totals.
- Index partition/order columns.

## Practice
Run script for examples, rankings, running totals, lag/lead, and exercises.

Powerful for advanced analytics without subqueries.