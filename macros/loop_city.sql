{% macro loop_city() %}

{% set get_city_list %}

select city, alias
from staging.city_alias

{% endset %}

{% set city_list = run_query(get_city_list) %}
{% if execute %}
    {% set city_name = city_list.columns[0].values() %}
    {% set city_alias = city_list.columns[1].values() %}
{% else %}
    {% set city_name = [] %}
    {% set city_alias = [] %}
{% endif %}

{% for i in range(city_name|length) %}
    {{ return([city_name[i], city_alias[i]] )}}
{% endfor %}


{% endmacro %}