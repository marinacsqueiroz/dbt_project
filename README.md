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
    - _stg_jaffle_shop.yml
    - _stg_jaffle_shop.yml
    - stg_jaffle_shop_customers.sql
    - stg_jaffle_shop_orders.sql
- tests/
  - assert_positive_total_for_payments.sql


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

## 🧪 Running dbt tests

You can validate all your data models and assumptions using built-in and custom dbt tests.

```bash
# Run all tests
dbt test

# Run a specific test by name
dbt test --select {name}

# Run only generic tests
dbt test --select test_type:generic

# Run only singular tests
dbt test --select test_type:singular
```

### 🧪 Tests in dbt

In **dbt**, tests are used to validate your data models and maintain data quality.  
There are **two main types of tests**:

- **Generic tests** 🧱  
  - Predefined and reusable tests written in **YAML**.  
  - Applied to columns to check for common data issues (e.g., duplicates, nulls, invalid values).  

- **Singular tests** 🎯  
  - Custom **SQL-based** tests that you define manually.  
  - Each test returns the records that fail the condition — used for specific, one-off data checks.

#### ✅ Built-in Generic Tests

dbt includes four built-in generic tests:

| Test | Purpose |
|------|----------|
| **unique** | Ensures every value in a column is unique. |
| **not_null** | Ensures no null values exist in a column. |
| **accepted_values** | Checks that column values match a predefined list. |
| **relationships** | Validates referential integrity — ensures a value in one model exists in another. |

--- 

## ⚙️ Building and Testing the Project

### 🧩 `dbt build`

The `dbt build` command is the **recommended all-in-one workflow** for local or CI/CD execution.  
It runs the following steps **in the correct dependency order**:

1. ✅ **Source freshness tests** — validates that your raw data sources are available and up-to-date.  
2. 🧱 **Model builds** — runs `dbt run` to build all models (staging, marts, etc.) according to your DAG.  
3. 🔍 **Model tests** — executes all generic and custom tests for each model after it’s built.  
4. 💚 **If all tests pass**, the build is considered successful, ensuring your data is both valid and reliable.

The dbt build command runs several dbt tasks in sequence, ensuring your project is built and tested in the right order:

```bash
dbt run
  Transforms and builds models in your warehouse.

dbt test
  Validates your data for quality issues.

dbt seed
  Loads CSV data into your warehouse tables.

dbt snapshot
  Tracks slowly changing dimensions (SCD) in your data.
```
---

## 🎓 Learn More

If you want to learn dbt fundamentals step by step — including how to build, test, and document models directly in VS Code — check out the official **dbt Learn** course:

👉 [**dbt Fundamentals (VS Code)**](https://learn.getdbt.com/courses/dbt-fundamentals-vs-code)

This free course from the dbt team covers:
- Setting up dbt Core locally  
- Building and testing models  
- Using Jinja and macros  
- Running dbt in VS Code  
- Best practices for analytics engineering  

💡 *Highly recommended for anyone starting with dbt or looking to solidify core concepts.*

---

---

## 📚 References & Learning Resources

Here are some useful resources to go deeper into **dbt**, data modeling, and analytics engineering:

- 📘 [**dbt Documentation**](https://docs.getdbt.com/) — The official reference for dbt Core, Jinja syntax, testing, and deployment best practices.  
- 🧠 [**dbt Learn Platform**](https://learn.getdbt.com/) — Free interactive courses to learn dbt hands-on.  
- 💻 [**dbt Fundamentals (VS Code)**](https://learn.getdbt.com/courses/dbt-fundamentals-vs-code) — Official dbt course to learn how to set up dbt locally, build models, run tests, and use VS Code effectively.  
- 🧩 [**dbt Hub**](https://hub.getdbt.com/) — The official registry of community-maintained dbt packages and macros (like `dbt_utils`, `dbt_expectations`, and more) ready to install and extend your project.  
