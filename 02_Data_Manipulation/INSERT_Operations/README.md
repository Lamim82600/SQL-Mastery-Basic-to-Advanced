# SQL INSERT Operations

## Overview
INSERT adds new rows to a table. Essential DML for populating data.

The script `SQL_INSERT_Operations.sql` covers basic to advanced patterns in MySQL.

## Key Techniques

### Single Row INSERT
- `INSERT INTO table (cols) VALUES (values);`
- Column list optional if all columns.

### Multiple Row INSERT
- Single statement for many rows.
- Efficient, atomic.

### INSERT ... SELECT
- Copy data from query.
- Useful for archiving/reporting.

### INSERT IGNORE
- Skips errors (e.g., duplicates).

### ON DUPLICATE KEY UPDATE
- Upsert: insert or update on conflict.

## Real-World Use Cases
- **Data Entry**: Bulk user/product imports.
- **ETL**: Load transformed data.
- **Migrations**: Copy between tables.
- **Archiving**: Move old records.

## Best Practices
- Specify columns.
- Use transactions for batches.
- Handle duplicates gracefully.

## Practice
Run the script for examples, upserts, and exercises.

Master INSERT for efficient data loading.