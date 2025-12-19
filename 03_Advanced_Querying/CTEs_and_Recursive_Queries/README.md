# SQL CTEs and Recursive Queries

## Overview
Common Table Expressions (CTEs) are temporary named result sets. Recursive CTEs handle hierarchical/traversing data.

The script `SQL_CTEs_and_Recursive_Queries.sql` covers non-recursive and recursive CTEs in MySQL.

## Key Concepts

### Non-Recursive CTE
- WITH clause for readable/subquery factoring.
- Multiple CTEs chained.

### Recursive CTE
- Anchor + recursive part.
- UNION ALL combines.
- Use: Hierarchies (employees), trees, graphs.

### Termination
- Max recursion depth or condition.

## Real-World Use Cases
- **Org Charts**: Manager-subordinate traversal.
- **Bill of Materials**: Part explosions.
- **Path Finding**: Network graphs.
- **Date Series**: Generate sequences.

## Best Practices
- Limit recursion depth.
- Index joining columns.
- Use for clarity over subqueries.

## Practice
Run script for hierarchy, numbers generation, aggregation CTEs, and exercises.

Powerful for complex, readable queries.