# SQL Conditional Logic

## Overview
Conditional logic in SQL enables dynamic query results using CASE, COALESCE, NULLIF, and IF.

The script `SQL_Conditional_Logic.sql` covers searched/simple CASE, handling NULLs, and MySQL IF.

## Key Functions

### CASE
- Searched: WHEN condition THEN result.
- Simple: CASE value WHEN ... THEN.
- Use: Categorize data, calculations.

### COALESCE
- Returns first non-NULL value.
- Use: Default values.

### NULLIF
- Returns NULL if expressions equal.
- Use: Avoid division by zero.

### IF (MySQL)
- IF(condition, true, false).

## Real-World Use Cases
- **Reporting**: Tier prices (budget/mid/premium).
- **Data Cleaning**: Replace NULLs.
- **Business Rules**: Stock alerts, discounts.
- **Dashboards**: Status labels.

## Best Practices
- Use CASE in SELECT for readability.
- Combine with aggregates.
- Nest for complex logic.

## Practice
Run script for examples, nested CASE, JSON/IF, and exercises.

Powerful for flexible, readable queries.