# SQL Set Operations

## Overview
Set operations combine results from multiple queries: UNION, INTERSECT, EXCEPT.

The script `SQL_Set_Operations.sql` covers UNION/ALL and MySQL workarounds for INTERSECT/EXCEPT.

## Key Operations

### UNION
- Combines rows, removes duplicates.

### UNION ALL
- Combines rows, keeps duplicates.

### INTERSECT (MySQL workaround)
- Common rows (INNER JOIN or EXISTS).

### EXCEPT (MySQL workaround)
- Rows in first not second (LEFT JOIN + NULL).

## Real-World Use Cases
- **Merging Lists**: Active + archived products.
- **Deduplication**: Unique emails from sources.
- **Comparisons**: New vs old inventory.
- **Reporting**: Combined metrics.

## Best Practices
- Matching columns (count/type).
- ORDER BY at end.
- Use UNION ALL for performance.

## Practice
Run script for examples, workarounds, source tagging, and exercises.

Useful for combining query results efficiently.