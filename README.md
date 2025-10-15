# dbt_project

<h1 align="center">📦 jaffle_shop on Databricks + dbt</h1>

<p align="center">
  Learning project to practice <b>data modeling</b>, <b>ELT with dbt</b>, and <b>analytics engineering</b> on <b>Databricks</b>.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/dbt-SQL%20models-ea5252?logo=dbt&logoColor=white" />
  <img src="https://img.shields.io/badge/Databricks-Lakehouse-ff3621?logo=databricks&logoColor=white" />
  <img src="https://img.shields.io/badge/Orchestration-CLI-blue" />
</p>

---

## 🚀 What is this?

This repo contains a simplified **analytics pipeline** using **dbt Core** on **Databricks**.  
It implements a classic **jaffle_shop** dataset with:

- **Staging models** that clean & standardize raw tables (Stripe payments, customers, orders).
- **Marts** models for **finance**: a curated **fact table** and a **dimension** ready for BI.

It’s designed to be **practical** for learning and to serve as a starter for real projects.

---

## 🗺️ Project structure

models/
- marts/
  - finance/
    - fct_orders.sql
  - marketing/
    - dim_customers.sql
- staging/
  - stripe/
    - stg_stripe_payments.sql
  - jaffle_shop/
    - stg_jaffle_shop_customers.sql
    - stg_jaffle_shop_orders.sql


### Naming

- `stg_*` = **staging**
  - Source-aligned models that **clean, cast, rename, and de-duplicate** raw data.
  - Keep logic minimal; usually **one table per source object**.
  - Goal: produce consistent, analytics-ready inputs for downstream models.

- `dim_*` = **dimensions**
  - Descriptive attributes about **who / what / where** (e.g., customers, products, locations).
  - More stable entities used to **join** and **filter** facts.
  - Typically contain a **surrogate key** and business keys; one row per entity.

- `fct_*` = **facts** (*fact tables*)
  - **Events/transactions** at a clearly defined **grain** (lowest level of detail).
  - Contain **numeric measures** (e.g., amount, fees, revenue) and **foreign keys** to dimensions.
  - Usually include **time columns** for filtering/partitioning.
    
---

## 🧰 Tech stack

- **Databricks** (Unity Catalog recommended)
- **dbt Core** (SQL + Jinja)
- Optional: **Power BI** / any BI on top of marts

---

Execute dbt test to run all generic and singular tests in your project.
Execute dbt test --select {name} to run only expecific tests in your project.
Execute dbt test --select test_type:generic to run only generic tests in your project.
Execute dbt test --select test_type:singular to run only singular tests in your project.