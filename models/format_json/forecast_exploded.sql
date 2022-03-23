{{
  config(
    materialized='view'
  )
}}

select 
        wf.v:city.coord.lat as lat,
        wf.v:city.coord.lon as lon,
        wf.v:city.name as city,
        wf.v:city.country as country,
        wf.v:city.id as city_id,
        f.value:clouds as clouds,
        f.value:deg as deg,
        f.value:dt as dt,
        to_timestamp(f.value:dt) as timestamp_dt,
        f.value:humidity as humidity,
        f.value:pressure as pressure,
        f.value:rain as rain,
        f.value:speed as speed,
        f.value:temp.day as forcasted_temp_day,
        f.value:temp.eve as forcasted_temp_eve,
        f.value:temp.max as forcasted_temp_max,
        f.value:temp.min as forcasted_temp_min,
        f.value:temp.morn as forcasted_temp_morn,
        f.value:temp.night as forcasted_temp_night,
        f.value:uvi as uvi,
        f.value:weather[0].description as weather_description,
        f.value:weather[0].icon as weather_icon,
        f.value:weather[0].id as weather_id,
        f.value:weather[0].main as weather_main,
        wf.v:time as forecast_time,
        to_timestamp(wf.v:time) as forecast_dt
from snowflake_sample_data.weather.daily_14_total wf,
        lateral flatten(input => wf.v,  path => 'data') f
where wf.v:city.name = 'New York'