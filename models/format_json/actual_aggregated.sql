{{
  config(
    materialized='view'
  )
}}

with weather_rn as (
  select  date_trunc('day', to_timestamp(actual_time)) as actual_date,
          weather_main,
          weather_description,
          row_number() over(partition by actual_date
              order by count(weather_main) desc) as rn 
  from {{ref('actual_exploded')}}
  group by 1, 2, 3
),

temp_avg as (
  select 
          date_trunc('day', to_timestamp(actual_time)) as actual_date,
          round(avg(actual_temp_max), 2) as actual_max, 
          round(avg(actual_temp_min), 2) as actual_min
  from {{ref('actual_exploded')}}
  group by 1 )

select  t.actual_date, t.actual_max, t.actual_min, 
        w.weather_description, w.weather_main
from temp_avg t
left join weather_rn w
on t.actual_date = w.actual_date
where rn = 1
order by actual_date