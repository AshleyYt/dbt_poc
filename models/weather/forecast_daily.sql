with aggr_forecast as (
  select  date_trunc('day', timestamp_dt) as forecast_date,
          weather_main,
          weather_description,
          city, country,
          round(avg(forcasted_temp_day), 2) as forecast_temp,
          row_number() over(partition by forecast_date
              order by count(weather_main) desc) as rn 
  from {{ref('forecast_staging')}}
  {{ dbt_utils.group_by(5) }}
)

select forecast_date, weather_main, weather_description
from aggr_forecast
where rn = 1
order by 1