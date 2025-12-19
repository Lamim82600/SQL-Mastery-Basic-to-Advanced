# SQL Partitioning

## Overview
Partitioning divides large tables into smaller, manageable pieces while transparent to queries.

The script `SQL_Partitioning.sql` covers RANGE, LIST, HASH partitioning in MySQL.

## Key Types

### RANGE
- By value ranges (e.g., date/year).
- Pruning: Query skips irrelevant partitions.

### LIST
- Discrete values (e.g., regions).

### HASH
- Even distribution (e.g., by ID).
- Balanced load.

## Management
- ADD/DROP/REORGANIZE partitions.

## Real-World Use Cases
- **Time-Series**: Sales by year/month.
- **Large Logs**: Purge old data fast.
- **Sharding Prep**: Horizontal scaling.
- **Performance**: Faster queries/deletes.

## Best Practices
- Partition key in WHERE.
- Avoid too many partitions.
- InnoDB supported.

## Practice
Run script for types, inserts, management, and queries.

Boosts performance on big tables.