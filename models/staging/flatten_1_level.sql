{{
    config(
        materialized='view'
    )
}}

select * from {{ ref('temp_v')}} wa,
lateral flatten(input => wa.v) f