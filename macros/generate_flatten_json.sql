{% macro generate_flatten_json(model_name, json_column) %}

{% set get_json_path %}

{# apply flatten json recursively to  #}
with low_level_flatten as (
select f.key as json_key, f.path as json_path, 
f.value as json_value
from {{ model_name }}, 
lateral flatten(input => {{ json_column }},
                recursive => true ) f
limit 20
)

select distinct json_path
from low_level_flatten
where not contains(json_value, '{')
and json_key != json_value

{% endset %}

{% set res = run_query(get_json_path) %}
{% if execute %}
    {% set res_list = res.columns[0].values() %}
{% else %}
    {% set res_list = [] %}
{% endif %}

select 
{% for json_path in res_list %}
    {{ json_column }}:{{ json_path }} as {{ json_path | replace(".", "_") | replace("[", "_") | replace("]", "") | replace("'", "") }}{% if not loop.last %},{% endif %}
{% endfor %}

from {{ model_name }}

{% endmacro %}