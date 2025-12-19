# SQL Indexing

## Overview
Indexes accelerate query performance by allowing fast data lookup, like a book index.

The script `SQL_Indexing.sql` covers B-Tree, Hash, FULLTEXT, SPATIAL indexes in MySQL.

## Key Index Types

### B-Tree (Default)
- Balanced tree for equality/range queries.
- Single/composite columns.

### Hash
- Exact matches, MEMORY engine only.

### FULLTEXT
- Text search on CHAR/TEXT.

### SPATIAL
- Geographic data (POINT, etc.).

## Real-World Use Cases
- **Search**: WHERE filters.
- **Joins**: Faster linking.
- **Sorting**: ORDER BY speed.
- **Analytics**: Aggregates on large tables.

## Best Practices
- Index frequent WHERE/JOIN/ORDER columns.
- Avoid over-indexing (slows writes).
- Use EXPLAIN to check usage.
- Composite: Left-most prefix.

## Practice
Run script for creation, types, EXPLAIN, and exercises.

Critical for scalable performance.