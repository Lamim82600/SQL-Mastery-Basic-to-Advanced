# SQL DELETE Operations

## Overview
DELETE removes rows from a table based on conditions. It's DML, logged, and respects constraints/triggers.

The script `SQL_DELETE_Operations.sql` covers basic to advanced usage with safety features.

## Key Concepts

### Basic DELETE
- `DELETE FROM table WHERE condition;`
- Removes matching rows.

### DELETE with JOIN/Subquery
- Delete via related tables or subqueries.

### Safety Features
- `LIMIT`: Restrict rows (MySQL).
- Cascading via FOREIGN KEY `ON DELETE CASCADE`.

### DELETE vs TRUNCATE
- DELETE: Row-by-row, trigger-fired, WHERE possible.
- TRUNCATE: Faster, all rows, resets AUTO_INCREMENT.

## Real-World Use Cases
- **Cleanup**: Remove outdated/invalid records.
- **GDPR**: Delete user data on request.
- **Orders**: Soft delete (flag) or hard with cascade.
- **Archives**: Delete after moving to history.

## Best Practices
- Always use WHERE (avoid deleting all).
- Backup/test in transactions.
- Use LIMIT for large deletes.
- Prefer soft deletes in production.

## Practice
Run the script for examples, cascading, subqueries, and exercises.

Master DELETE for safe data management.