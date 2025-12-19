# SQL Constraints

## Overview
SQL constraints are essential rules applied to table columns to enforce data integrity, consistency, and validity at the database level. They prevent invalid data entry and maintain referential relationships.

The accompanying script `SQL_Constraints.sql` demonstrates creation, usage, and testing of major constraints in MySQL, with examples, exercises, and error scenarios.

## Key Constraints

### PRIMARY KEY
- Uniquely identifies each row.
- Cannot contain NULL values.
- Automatically indexed.
- Use: Surrogate keys like `product_id`.

### FOREIGN KEY
- Maintains referential integrity.
- Links child table to parent primary key.
- Options: `ON DELETE CASCADE`, `SET NULL`.
- Use: Order-product relationships.

### UNIQUE
- Ensures column values are unique.
- Allows one NULL (MySQL treats NULLs as distinct).
- Use: Email, SKU codes.

### NOT NULL
- Disallows NULL values.
- Forces data presence.
- Use: Required fields like names, prices.

### CHECK
- Enforces custom conditions (e.g., `price > 0`).
- Use: Business rules like non-negative stock.

### DEFAULT
- Provides fallback value if none specified.
- Use: Default status, timestamps.

## Benefits
- Data quality without application logic.
- Centralized enforcement.
- Automatic validation on INSERT/UPDATE.

## Real-World Applications
- **E-commerce**: FOREIGN KEY for valid orders; CHECK for positive quantities.
- **Finance**: CHECK for positive balances; UNIQUE transaction IDs.
- **User Systems**: UNIQUE email; NOT NULL password hash.
- **Inventory**: DEFAULT stock = 0; CHECK stock >= 0.

## Practice Tips
1. Run `SQL_Constraints.sql`.
2. Observe constraint violations (errors).
3. Complete exercises for hands-on mastery.

Constraints form the foundation of reliable database design.