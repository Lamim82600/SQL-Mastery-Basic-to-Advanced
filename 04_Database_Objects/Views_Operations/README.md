# SQL Views Operations

## Overview
Views are virtual tables based on SELECT queries, providing simplified/absecured data access.

The script `SQL_Views_Operations.sql` covers CREATE, ALTER, DROP, updatable, and joined views in MySQL.

## Key Operations

### CREATE VIEW
- Defines stored query.
- Simple or complex (joins, aggregates).

### ALTER VIEW
- Modifies definition.

### DROP VIEW
- Removes view.

### Updatable Views
- Simple views allow INSERT/UPDATE/DELETE.

### WITH CHECK OPTION
- Enforces WHERE on updates.

## Real-World Use Cases
- **Security**: Hide sensitive columns.
- **Simplification**: Pre-join complex tables.
- **Reports**: Aggregated views.
- **Legacy**: Backward compatibility.

## Best Practices
- Avoid heavy computations.
- Use for abstraction.
- Index underlying tables.

## Practice
Run script for simple/joined/aggregated views, updates, and exercises.

Great for data abstraction and security.