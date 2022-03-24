{% macro flatten_json(model_name, json_column) %}

{% set get_column_name %}
select distinct
    f.key as column_name
from {{model_name}},
lateral flatten(input => {{json_column}}) f
limit 10
{% endset %}

{% set res = run_query(get_column_name) %}

{% if execute %}
{# Return the first column #}
{% set res_list = res.columns[0].values() %}
{% else %}
{% set res_list = [] %}
{% endif %}

{{ return(res_list) }}

{% endmacro %}