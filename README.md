# Enterprise Data Analytics & RFM Modeling

## 📌 Project Overview
This repository contains the Exploratory Data Analysis (EDA) and Advanced Analytics layer built on top of a Medallion Architecture Data Warehouse. The goal of this project was to transition from raw Star Schema data into actionable business intelligence, focusing on customer segmentation, product performance, and chronological sales trends.

## 🛠️ Technology Stack
* **Language:** T-SQL (Transact-SQL)
* **Core Concepts:** Exploratory Data Analysis (EDA), RFM Analysis, Cohort Segmentation, Pareto Analysis, Time-Series Forecasting, Window Functions, CTEs.

---

## 📊 Analytical Pillars

### 1. Exploratory Data Analysis (EDA)
* **Baseline Metrics:** Established absolute quantitative boundaries for global revenue, order volume, and categorical cardinality.
* **Pareto Analysis:** Sliced financial measures across dimensional attributes to identify top-performing regions and product category profitability.

### 2. Ranking & Comparative Analysis
* **Performance Ranking:** Utilized `ROW_NUMBER()` and `TOP N` filtering to segment the customer base and identify flagship items vs. loss-leaders.
* **YoY Benchmarking:** Architected CTEs and the `LAG()` function to calculate Year-over-Year (YoY) growth and conditionally flag product performance against historical averages.

### 3. Time-Series & Cumulative Tracking
* **Chronological Trends:** Leveraged `DATETRUNC` to accurately group transactional data, tracking macro-level seasonality and revenue fluctuations month-over-month.
* **Cumulative Metrics:** Engineered nested subqueries and `SUM() OVER()` Window Functions to calculate the running total of revenue and moving average of pricing.

### 4. Market Share & Proportional Analysis
* **Fractional Contribution:** Bypassed integer division constraints by casting to floats and utilizing unpartitioned Window Functions to dynamically calculate the percentage contribution of each category to the global revenue stream.

---

## 🏆 The Executive Summary View
The culmination of this project is the `gold.report_customers` Master View. This script consolidates all analytical logic into a single, BI-ready data asset.

**Key Features of the Customer Report:**
* **Dynamic RFM Segmentation:** Automatically buckets customers into 'VIP', 'Regular', and 'New' tiers based on engagement lifespan and total spending.
* **Defensive Calculations:** Pre-calculates Average Order Value (AOV) and Average Monthly Spend using strict divide-by-zero protections.
* **Evergreen Time Intelligence:** Utilizes `GETDATE()` to dynamically calculate customer Age and Recency (months since last order), ensuring the report never requires manual date updates.
