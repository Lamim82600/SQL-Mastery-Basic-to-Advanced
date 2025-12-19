# SQL Sorting and Limits

## Overview
Sorting orders query results; LIMIT restricts rows returned. Essential for readable, efficient output.

The script `SQL_Sorting_and_Limits.sql` covers ORDER BY, LIMIT, OFFSET in MySQL.

## Key Features

### ORDER BY
- Sorts by columns ASC (default)/DESC.
- Multiple columns: category then price.
- Expressions: total_value = price * quantity.

### LIMIT
- Returns N rows.
- With ORDER BY: top/bottom results.

### OFFSET
- Skips rows (pagination).
- LIMIT n OFFSET m.

### Pagination
- LIMIT 10 OFFSET 0 (page 1), OFFSET 10 (page 2).

## Real-World Use Cases
- **Leaderboards**: Top 10 sales DESC.
- **Reports**: Recent orders DESC date.
- **APIs**: Paginated results.
- **Dashboards**: Highest/lowest metrics.

## Best Practices
- Always pair LIMIT with ORDER BY.
- Use indexes on sorted columns.
- Calculate OFFSET = (page-1) * limit.

## Practice
Run the script for sorting, top-N, pagination examples and exercises.

Critical for performance and usability.