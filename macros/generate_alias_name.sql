{% macro generate_alias_name(custom_alias_name=none, node=none) -%}

    {%- if custom_alias_name is none -%}

        {{ node.name }}

    {%- else -%}

        {{ custom_alias_name | trim }}_{{ node.name }}


    {%- endif -%}

{%- endmacro %}
