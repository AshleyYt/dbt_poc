with weather_rn as (
  select  date_trunc('day', to_timestamp(actual_time)) as actual_date,
          weather_main,
          weather_description,
          row_number() over(partition by actual_date
              order by count(weather_main) desc) as rn 
  from {{ref('actual_staging')}}
  group by 1, 2, 3
),

temp_avg as (
  select 
          date_trunc('day', to_timestamp(actual_time)) as actual_date,
          round(avg(actual_temp), 2) as actual_temp
  from {{ref('actual_staging')}}
  group by 1 )

select  t.actual_date, t.actual_temp, 
        w.weather_description, w.weather_main
from temp_avg t
left join weather_rn w
on t.actual_date = w.actual_date
where rn = 1
order by actual_date