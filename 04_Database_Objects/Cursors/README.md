# SQL Cursors

## Overview
Cursors enable row-by-row processing of query results in stored procedures. Useful for procedural logic.

The script `SQL_Cursors.sql` covers declaration, open/fetch/close, handlers in MySQL procedures.

## Key Steps
- DECLARE cursor FOR SELECT.
- DECLARE CONTINUE HANDLER FOR NOT FOUND.
- OPEN, FETCH INTO variables.
- LOOP until done.
- CLOSE cursor.

## Real-World Use Cases
- Complex updates (e.g., restock based on rules).
- Logging changes row-by-row.
- Data migration with transformations.
- When set-based operations insufficient.

## Best Practices
- Avoid if possible (set-based faster).
- Use READ ONLY, FORWARD ONLY.
- Handle NOT FOUND.
- Limit scope.

## Practice
Run script for restock, discount procedures, logging, and exercises.

Use sparingly for performance.