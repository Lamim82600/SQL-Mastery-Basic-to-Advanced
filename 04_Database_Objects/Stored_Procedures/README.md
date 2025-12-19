# SQL Stored Procedures

## Overview
Stored procedures are precompiled, reusable SQL code blocks stored in the database for complex logic.

The script `SQL_Stored_Procedures.sql` covers creation, parameters, calling, and management in MySQL.

## Key Features

### Creation
- DELIMITER for multi-statement.
- BEGIN...END block.

### Parameters
- IN: Input.
- OUT: Output.
- INOUT: Both.

### Logic
- Variables, IF/CASE, loops.
- CALL to execute.

### Benefits
- Performance (precompiled).
- Security (controlled access).
- Reusability.

## Real-World Use Cases
- **Business Logic**: Order processing, calculations.
- **Batch Jobs**: Nightly updates.
- **Reports**: Parameterized queries.
- **Data Validation**: Complex rules.

## Best Practices
- Use parameters.
- Error handling (DECLARE HANDLER).
- Comment code.
- Grant EXECUTE privilege.

## Practice
Run script for no-param, IN/OUT/INOUT, logic examples, and exercises.

Essential for modular, secure database operations.