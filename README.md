Welcome to your new dbt project!

## Using the starter project

Try running the following commands:
- dbt run
- dbt test

## Overview
Project ini bertujuan untuk membangun data warehouse sederhana menggunakan **Snowflake** dan **dbt** berdasarkan dataset public Olist (Brazilian E-Commerce).

Fokus utama:
- Data ingestion (raw layer)
- Data transformation (staging & marts)
- Data modeling (star schema)
- Data quality testing menggunakan dbt

---

## Architecture

Layer yang digunakan:

1. Raw Layer
   - Data di-load langsung dari CSV
   - Semua kolom disimpan sebagai STRING
   - Tujuan: menjaga data tetap “as-is”

2. Staging Layer
   - Cleaning & casting data
   - Standardisasi nama kolom
   - Source untuk transformation berikutnya

3. Marts Layer
   - Fact & Dimension tables
   - Sudah siap untuk analytics

---

## Data Model

### Fact Table
- `fact_sales`
  - Grain: order_item level
  - Berisi:
    - order_id
    - order_item_id
    - customer_id
    - product_id
    - price
    - order_date

### Dimension Tables
- `dim_customers`
- `dim_products`
- `dim_date`

---

## Questions (Task 2)

Query yang disediakan:

1. Total revenue per day  
	select order_date, sum(price) total_revenue 
	from marts.fact_sales
	group by order_date
	order by order_date desc;
	
2. Top 5 products by revenue (last 30 days dari last transaksi)  
	with last_date as (
		select max(order_date) last_dt from marts.fact_sales
	)
	select fs.product_id, sum(fs.price) total_revenue 
	from marts.fact_sales fs, last_date ld
	where fs.order_date >= dateadd(day, -30, ld.last_dt)
	group by fs.product_id
	order by total_revenue desc
	limit 5;
3. Monthly active customers 
	SELECT
		DATE_TRUNC('MONTH', order_date) AS month,
		COUNT(DISTINCT customer_id) AS monthly_active_customers
	FROM marts.fact_sales
	GROUP BY DATE_TRUNC('MONTH', order_date)
	ORDER BY month DESC;
	
4. Average order value per customer  
	WITH order_level AS (
		SELECT
			order_id,
			customer_id,
			SUM(price) AS order_value
		FROM marts.fact_sales
		GROUP BY order_id, customer_id
	)
	SELECT
		customer_id,
		AVG(order_value) AS avg_order_value
	FROM order_level
	GROUP BY customer_id;
	
5. Data anomaly detection:
   - price <= 0
   - quantity <= 0 --> Tidak ada kolom quantity pada dataset
   - missing customer_id
   
	SELECT
		CASE 
			WHEN price <= 0 THEN 'Invalid_Price'
			WHEN customer_id IS NULL THEN 'Missing_Customer'
		END AS anomaly_type,
		COUNT(*) AS total_rows
	FROM marts.fact_sales
	WHERE price <= 0 OR customer_id IS NULL
	GROUP BY anomaly_type;