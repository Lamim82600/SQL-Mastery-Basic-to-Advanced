# SQL Transaction Control Language

## Overview
TCL manages transactions: groups statements as atomic units (all succeed or none).

The script `SQL_Transaction_Control_Language.sql` covers START, COMMIT, ROLLBACK, SAVEPOINT, isolation in MySQL.

## Key Commands

### START TRANSACTION
- Begins transaction.

### COMMIT
- Saves changes permanently.

### ROLLBACK
- Undoes changes.

### SAVEPOINT
- Partial rollback points.

### SET TRANSACTION
- Isolation level, read-only/write.

## Real-World Use Cases
- **Banking**: Transfer money atomically.
- **E-commerce**: Order + stock update.
- **Data Integrity**: Multi-table changes.
- **Error Recovery**: Rollback on failure.

## Best Practices
- Short transactions.
- Explicit COMMIT/ROLLBACK.
- Use SAVEPOINT for complex.
- Appropriate isolation.

## Practice
Run script for basic/advanced transactions, savepoints, isolation, and exercises.

Ensures data consistency and reliability.