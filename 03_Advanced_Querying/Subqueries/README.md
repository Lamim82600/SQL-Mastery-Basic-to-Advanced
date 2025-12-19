# SQL Subqueries

## Overview
Subqueries are nested SELECT queries within another query, returning values for comparison or row sets.

The script `SQL_Subqueries.sql` covers scalar, multi-row, correlated, and nested subqueries in MySQL.

## Key Types

### Scalar
- Returns single value.
- Used in WHERE, SELECT.

### Multi-Row
- Returns multiple rows.
- With IN, ANY, ALL.

### Correlated
- References outer query.
- Executes per row.

### Nested
- Subquery within subquery.

## Real-World Use Cases
- **Filtering**: Products above average price.
- **Reporting**: Orders exceeding average.
- **Existence**: Customers with orders (EXISTS).
- **Derived**: Top per group.

## Best Practices
- Use JOINs when possible (performance).
- Correlated for row-specific.
- EXISTS over IN for checks.

## Practice
Run script for examples, correlated averages, nested, NOT EXISTS, and exercises.

Powerful for complex filtering without joins.