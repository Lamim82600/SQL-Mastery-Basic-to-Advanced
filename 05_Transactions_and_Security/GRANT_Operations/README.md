# SQL GRANT Operations

## Overview
GRANT assigns privileges to users/roles for database objects. Controls security and access.

The script `SQL_GRANT_Operations.sql` covers privilege granting, roles, and best practices in MySQL.

## Key Features

### Basic GRANT
- `GRANT privilege ON object TO user;`
- Privileges: SELECT, INSERT, UPDATE, etc.

### Column/Level
- Specific columns, database-wide.

### ALL PRIVILEGES
- Full access.

### Roles
- Group privileges.
- CREATE ROLE, GRANT TO role, GRANT role TO user.

### WITH GRANT OPTION
- Allow user to grant further.

## Real-World Use Cases
- **Roles**: Sales (SELECT), Admin (ALL).
- **Least Privilege**: Read-only analysts.
- **Apps**: Dedicated users.
- **Auditing**: Controlled access.

## Best Practices
- Principle of least privilege.
- Use roles for management.
- FLUSH PRIVILEGES after changes.
- SHOW GRANTS to verify.

## Practice
Run script for users, roles, column privileges, and exercises.

Fundamental for database security.