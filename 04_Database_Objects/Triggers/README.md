# SQL Triggers

## Overview
Triggers are automated procedures that execute on DML events (INSERT, UPDATE, DELETE) on a table.

The script `SQL_Triggers.sql` covers BEFORE/AFTER triggers, OLD/NEW references in MySQL.

## Key Features

### BEFORE Triggers
- Run before event.
- Modify NEW values or validate (SIGNAL).

### AFTER Triggers
- Run after event.
- Logging, cascading updates.

### OLD / NEW
- OLD: Pre-change row.
- NEW: Post-change row.

### Events
- INSERT, UPDATE, DELETE.
- Per row (FOR EACH ROW).

## Real-World Use Cases
- **Audit**: Log changes.
- **Integrity**: Enforce rules beyond constraints.
- **Sync**: Update related tables.
- **Stock**: Auto-reduce on order.

## Best Practices
- Keep simple/fast.
- Avoid recursive triggers.
- Use for cross-table logic.
- Test thoroughly.

## Practice
Run script for validation, logging, stock management, and exercises.

Powerful for automatic data enforcement.