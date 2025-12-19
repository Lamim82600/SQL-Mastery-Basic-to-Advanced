# SQL Tables Operations

## Overview
This topic covers Data Definition Language (DDL) operations for creating, modifying, and deleting tables in MySQL.

The script `SQL_Tables_Operations.sql` provides comprehensive examples of table management, including safe creation, alterations, and cleanup.

## Key Operations

### CREATE TABLE
- Defines table structure with columns, types, constraints.
- Supports PRIMARY KEY, FOREIGN KEY, defaults.
- Variants: `CREATE TABLE ... LIKE`, `AS SELECT`.

### ALTER TABLE
- Modifies existing tables.
- ADD/MODIFY/DROP columns.
- RENAME table/column, add constraints.

### DROP TABLE
- Permanently deletes table and data.
- Use `IF EXISTS` for safety.

### TRUNCATE TABLE
- Removes all rows, keeps structure.
- Faster than DELETE, resets AUTO_INCREMENT.

### RENAME TABLE
- Changes table name.

## Real-World Use Cases
- **Schema Evolution**: ALTER to add features (e.g., new columns).
- **Data Migration**: CREATE AS SELECT for reports.
- **Cleanup**: TRUNCATE for resetting test data.
- **Refactoring**: RENAME during migrations.

## Best Practices
- Use `IF NOT EXISTS` / `IF EXISTS`.
- Backup before DROP/ALTER in production.
- Combine with constraints for integrity.

## Practice
Run the script to see operations step-by-step, including foreign keys and safe drops.

Essential for database design and maintenance.