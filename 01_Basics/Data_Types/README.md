# SQL Data Types

## Overview
SQL data types define the kind of data a column can hold, affecting storage, performance, and valid operations.

The script `SQL_Data_Types.sql` explores major MySQL data types with creation examples, insertions, and queries.

## Categories & Common Types

### Numeric
- **INT/INTEGER**: Whole numbers (-2^31 to 2^31-1).
- **TINYINT/SMALLINT/MEDIUMINT/BIGINT**: Varying ranges.
- **DECIMAL(p,s)**: Exact fixed-point (e.g., prices).
- **FLOAT/DOUBLE**: Approximate floating-point.

### String
- **CHAR(n)**: Fixed-length.
- **VARCHAR(n)**: Variable-length (up to 65535).
- **TEXT variants**: TINYTEXT, TEXT, MEDIUMTEXT, LONGTEXT for large text.
- **BINARY/VARBINARY**: Binary data.

### Date & Time
- **DATE**: 'YYYY-MM-DD'.
- **TIME**: 'HH:MM:SS'.
- **DATETIME/TIMESTAMP**: Date + time.
- **YEAR**: 4-digit year.

### Other
- **BOOLEAN**: Stored as TINYINT(1).
- **ENUM**: Restricted list values.
- **SET**: Multiple values from list.
- **JSON**: Structured JSON storage.

## Choosing Types
- Use exact (DECIMAL) for money.
- VARCHAR for variable text.
- TIMESTAMP for auto-updates.
- Smaller types save space/improve speed.

## Real-World Use Cases
- **E-commerce**: DECIMAL for prices, VARCHAR for names, JSON for product attributes.
- **Analytics**: DATETIME for timestamps, INT for counts.
- **Users**: VARCHAR(255) for emails, ENUM for roles.

## Practice
Run `SQL_Data_Types.sql` to see types in action, insertions, and querying (e.g., JSON extraction).

Proper data types ensure efficiency, accuracy, and prevent errors.