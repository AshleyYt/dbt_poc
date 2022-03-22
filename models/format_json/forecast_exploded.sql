{{
  config(
    materialized='view'
  )
}}

select 
        f.value:dt as dt,
        to_timestamp(f.value:dt) as forecast_dt,
        wf.v:city.name as city,
        wf.v:city.country as country,
        wf.v:city.id as city_id,
        f.value:temp.max as forcasted_temp_max,
        f.value:temp.min as forcasted_temp_min,
        f.value:weather[0].description as weather_description,
        f.value:weather[0].main as weather_main
from snowflake_sample_data.weather.daily_14_total wf,
        lateral flatten(input => wf.v,  path => 'data') f
where wf.v:city.name = 'New York'