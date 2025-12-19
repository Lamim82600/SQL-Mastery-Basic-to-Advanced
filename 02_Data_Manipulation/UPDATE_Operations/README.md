# SQL UPDATE Operations

## Overview
UPDATE modifies existing rows in a table. Core DML for data changes.

The script `SQL_UPDATE_Operations.sql` covers simple to advanced updates in MySQL.

## Key Techniques

### Basic UPDATE
- `UPDATE table SET column = value WHERE condition;`

### Multiple Columns
- Comma-separated assignments.

### Expressions
- `SET stock = stock + 10`, `price = price * 1.1`.

### Conditional: CASE
- Different values per row condition.

### Safe Updates
- LIMIT for large tables.
- Transactions for rollback.

### ON DUPLICATE KEY (in INSERT, but related)

## Real-World Use Cases
- **Corrections**: Fix prices/stock.
- **Business Logic**: Apply discounts, status changes.
- **Bulk Updates**: Yearly price hikes.
- **Soft Deletes**: Set active = false.

## Best Practices
- Always use WHERE.
- Test with SELECT first.
- Use transactions.
- Limit for safety.

## Practice
Run the script for examples, CASE, expressions, and exercises.

Essential for maintaining accurate data.