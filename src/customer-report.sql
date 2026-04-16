/*
============================================
	Customer Report
============================================
		Purpose: 
				- The report consolidates key customer metrics and behaviors.

		Highlights:

				1. Gather essential fields as such names, ages and transactional data.
				2. Segments customers into segments (VIP, Regular, New) and age-groups.
				3. Aggregates customer level metrics:
					- total orders
					- total sales
					- total quantity purchased
					- total products
					- lifespan (in months)
				4. Calculates valuable KPIs:
					- recency (months sincelast order)
					- average order value
					- average monthly spend

*/

CREATE VIEW gold.report_customers AS
WITH base_query AS (
-- =====================================
-- 1) Base Query: Retrieve All Columns
-- =====================================
SELECT
	f.order_number,
	f.product_key,
	f.order_date,
	f.quantity,
	f.sales_amount,
	c.customer_key,
	c.customer_number,
	CONCAT(c.first_name,' ',c.last_name) AS customer_name,
	DATEDIFF(year,c.birthdate,GETDATE()) AS age
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
WHERE order_date IS NOT NULL
)
, customer_aggregations AS (
-- =====================================
-- 2) Customer Aggregations: Summarizes key metrics at customer level
-- =====================================
SELECT
	customer_key,
	customer_number,
	customer_name,
	age,
	COUNT(DISTINCT order_number) AS total_orders,
	SUM(quantity) AS total_quantity,
	SUM(sales_amount) AS total_sales,
	COUNT(DISTINCT product_key) AS total_products,
	MAX(order_date) AS last_order_date,
	DATEDIFF(month,MIN(order_date),MAX(order_date)) AS lifespan
FROM base_query
GROUP BY
		customer_key,
		customer_number,
		customer_name,
		age
)	

SELECT 
		customer_key,
		customer_number,
		customer_name,
		CASE
			WHEN age < 20 THEN 'Under 20'
			WHEN age BETWEEN 20 AND 40 THEN '20-40'
			ELSE 'Above 40'
		END AS age_group,
		total_orders,
		total_quantity,
		total_sales,
		-- Compute Average Order Value AVO
		CASE
			WHEN total_orders = 0 OR total_sales = 0 THEN 0
			ELSE (total_sales / total_orders) 
		END AS avg_order_value,
		-- Compute Average Monthly Spend
		CASE
			WHEN lifespan = 0 THEN total_sales
			ELSE (total_sales / lifespan) 
		END AS avg_monthly_spend,
		total_products,
		last_order_date,
		DATEDIFF(month,last_order_date,GETDATE()) AS recency,
		CASE
			WHEN lifespan > 12 AND total_sales > 5000 THEN 'VIP'
			WHEN lifespan > 12 AND total_sales <= 5000 THEN 'Regular'
			ELSE 'New'
		END AS customer_segment
FROM customer_aggregations