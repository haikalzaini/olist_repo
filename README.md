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

### Limitations
- Tidak ada kolom quantity
- Revenue hanya berdasarkan total dari Price bukan Price * Quantity dikarenakan kolom tidak tersedia
