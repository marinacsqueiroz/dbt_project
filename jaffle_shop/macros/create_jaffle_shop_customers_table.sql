{% macro create_jaffle_shop_customers_table(
    catalog='workspace',
    schema_name='jaffle_shop',
    s3_base_path='s3://dbt-tutorial-public'
) %}

  {% set fq_schema = catalog ~ '.' ~ schema_name %}

  {% call statement('create_customers', fetch_result=False) %}

    USE CATALOG {{ catalog }};
    CREATE SCHEMA IF NOT EXISTS {{ fq_schema }};

    CREATE TABLE IF NOT EXISTS {{ fq_schema }}.customers
    (
      id          INT,
      first_name  STRING,
      last_name   STRING
    );

    COPY INTO {{ fq_schema }}.customers
    FROM (
      SELECT
        CAST(ID AS INT)      AS id,
        FIRST_NAME           AS first_name,
        LAST_NAME            AS last_name
      FROM '{{ s3_base_path }}/jaffle_shop_customers.csv'
    )
    FILEFORMAT = CSV
    FORMAT_OPTIONS ('header' = 'true', 'delimiter' = ',')
    COPY_OPTIONS ('force' = 'true');

  {% endcall %}

  {% do log('✅ customers table created and loaded successfully in ' ~ fq_schema, info=True) %}

{% endmacro %}
