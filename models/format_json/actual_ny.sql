{{
  config(
    materialized='view'
  )
}}

select 
        wa.v:time as dt,
        to_timestamp(wa.v:time) as actual_dt,
        wa.v:city.name as city,
        wa.v:city.country as country,
        wa.v:city.id as city_id,
        wa.v:main.temp_max as actual_temp_max,
        wa.v:main.temp_min as actual_temp_min,
        wa.v:weather[0].description as weather_description,
        wa.v:weather[0].main as weather_main
from snowflake_sample_data.weather.weather_14_total wa
where wa.v:city.name = 'New York'