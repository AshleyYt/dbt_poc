{{
  config(
    materialized='view'
  )
}}




select distinct
    f.key as column_name
from snowflake_sample_data.weather.weather_14_total,
lateral flatten(input => v) f
limit 10