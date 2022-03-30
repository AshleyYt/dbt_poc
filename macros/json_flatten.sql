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
    {% set res_list = res.columns[0].values() %}
{% else %}
    {% set res_list = [] %}
{% endif %}

select v,
{% for column_name in res_list %}
    {{json_column}}:{{column_name}} as {{column_name}}{% if not loop.last %},{% endif %}
{% endfor %}

from {{ model_name }}

{% endmacro %}