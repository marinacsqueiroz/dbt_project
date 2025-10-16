{% macro create_stripe_payments_table(
    catalog='workspace',
    schema_name='stripe',
    s3_base_path='s3://dbt-tutorial-public'
) %}

  {% set fq_schema = catalog ~ '.' ~ schema_name %}

  {% call statement('create_payments', fetch_result=False) %}

    USE CATALOG {{ catalog }};
    CREATE SCHEMA IF NOT EXISTS {{ fq_schema }};

    CREATE TABLE IF NOT EXISTS {{ fq_schema }}.payment
    (
      id            INT,
      orderid       INT,
      paymentmethod STRING,
      status        STRING,
      amount        INT,
      created       DATE,
      _batched_at   TIMESTAMP
    );

    COPY INTO {{ fq_schema }}.payment
    FROM (
      SELECT
        CAST(ID AS INT)            AS id,
        CAST(ORDERID AS INT)       AS orderid,
        PAYMENTMETHOD              AS paymentmethod,
        STATUS                     AS status,
        CAST(AMOUNT AS INT)        AS amount,
        TO_DATE(CREATED)           AS created,
        current_timestamp          AS _batched_at
      FROM '{{ s3_base_path }}/stripe_payments.csv'
    )
    FILEFORMAT = CSV
    FORMAT_OPTIONS ('header' = 'true', 'delimiter' = ',')
    COPY_OPTIONS  ('force'   = 'true');

  {% endcall %}

  {% call statement('count_payment', fetch_result=True) %}
    SELECT count(*) AS row_count FROM {{ fq_schema }}.payment
  {% endcall %}

  {% set res = load_result('count_payment') %}
  {% do log('✅ stripe.payment OK — rows=' ~ res['data'][0][0], info=True) %}

{% endmacro %}
