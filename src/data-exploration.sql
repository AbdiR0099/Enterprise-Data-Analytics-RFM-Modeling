/* Data Exploration */

-- Explore All Objects In Database
SELECT * FROM INFORMATION_SCHEMA.TABLES

-- Explore All Columns In Database
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers'