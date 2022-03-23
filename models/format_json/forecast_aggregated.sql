{{
  config(
    materialized='view'
  )
}}

with aggr_forecast as (
  select  date_trunc('day', timestamp_dt) as forecast_date,
          weather_main,
          weather_description,
          city, country,
          round(avg(forcasted_temp_max), 2) as forecast_max, 
          round(avg(forcasted_temp_min), 2) as forecast_min,
          row_number() over(partition by forecast_date
              order by count(weather_main) desc) as rn 
  from {{ref('forecast_exploded')}}
  group by 1, 2, 3, 4, 5
)

select * from aggr_forecast
where rn = 1
order by 1