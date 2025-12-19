# SQL SELECT Operations

## Overview
SELECT retrieves data from tables. Core of querying.

The script `SQL_SELECT_Operations.sql` covers basic to advanced selection techniques in MySQL.

## Key Features

### Basic SELECT
- `SELECT columns FROM table;`
- `*` for all columns.

### Filtering
- WHERE with operators (=, >, <, LIKE, IN, BETWEEN, IS NULL).
- Logical: AND, OR, NOT.

### Pattern Matching
- LIKE with % (any), _ (single).
- IN for lists.

### Aliases
- AS for column/table renaming.

### ORDER BY
- Sort results ASC/DESC.

## Real-World Use Cases
- **Reporting**: Filter sales by date/region.
- **Search**: LIKE for partial matches.
- **Dashboards**: Select specific metrics.
- **APIs**: Retrieve user/profile data.

## Best Practices
- Select only needed columns.
- Use indexes on WHERE columns.
- Combine with JOINs later.

## Practice
Run the script for examples, filtering, sorting, and exercises.

Foundation for all data retrieval.