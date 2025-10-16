{% macro init_databricks(catalog='workspace') %}

  {% call statement('init_databricks', fetch_result=False) %}

    -- garanta que estamos no catálogo certo (Unity Catalog)
    USE CATALOG {{ catalog }};

    -- crie os schemas dentro do catálogo
    CREATE SCHEMA IF NOT EXISTS {{ catalog }}.teste;
    CREATE SCHEMA IF NOT EXISTS {{ catalog }}.stripe;

  {% endcall %}

  {% do log('✅ Schemas criados em catalog=' ~ catalog, info=True) %}
{% endmacro %}
