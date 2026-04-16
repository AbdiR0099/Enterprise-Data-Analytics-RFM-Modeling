/* Measures Exploration */

-- Find the total Sales
SELECT SUM(sales_amount) AS total_sales FROM gold.fact_sales
-- Find how many items are sold
SELECT SUM(quantity) AS total_quantity FROM gold.fact_sales
-- Find the average selling price
SELECT AVG(price) AS avg_price FROM gold.fact_sales
-- Find the total number of orders
SELECT COUNT(order_number) AS total_orders FROM gold.fact_sales
SELECT COUNT(DISTINCT order_number) AS total_orders_distinct FROM gold.fact_sales
-- Find the total number of products
SELECT COUNT(product_key) AS total_products FROM gold.dim_products
SELECT COUNT(DISTINCT product_key) AS total_products_distinct FROM gold.dim_products
-- Find the total number of customers
SELECT COUNT(customer_key) AS total_customers FROM gold.dim_customers
-- Find the total number of customers that have placed an order
SELECT COUNT(DISTINCT customer_key) AS total_customers FROM gold.fact_sales

-- Generate a report that shows all key metrics of the business
SELECT 'Total Sales' AS measure_name,  SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity' as measure_name, SUM(quantity) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Average Price' as measure_name, AVG(price) as measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Nr. Orders' as measure_name, COUNT(DISTINCT order_number) as measure_value FROM gold.fact_sales
UNION ALL 
SELECT 'Total Nr. Products' as measure_name, COUNT(DISTINCT product_key) AS measure_value FROM gold.dim_products
UNION ALL
SELECT 'Total Nr. Customers' AS measure_name, COUNT(customer_key) AS measure_value FROM gold.dim_customers