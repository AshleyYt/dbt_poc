with
forecast as
(select ow.v:time         as prediction_dt,
        ow.v:city.name    as city,
        ow.v:city.country as country,
        cast(f.value:dt   as timestamp) as forecast_dt,
        f.value:temp.max  as forecast_max_k,
        f.value:temp.min  as forecast_min_k,
        f.value           as forecast
 from snowflake_sample_data.weather.daily_16_total ow, lateral flatten(input => v, path => 'data') f),

actual as
(select v:main.temp_max as temp_max_k,
        v:main.temp_min as temp_min_k,
        cast(v:time as timestamp)     as time_dt,
        v:city.name     as city,
        v:city.country  as country
 from snowflake_sample_data.weather.weather_14_total)

select cast(forecast.prediction_dt as timestamp) prediction_dt,
       forecast.forecast_dt,
       forecast.forecast_max_k,
       forecast.forecast_min_k,
       actual.temp_max_k,
       actual.temp_min_k
from actual
left join forecast on actual.city = forecast.city and
                      actual.country = forecast.country and
                      date_trunc(day, actual.time_dt) = date_trunc(day, forecast.forecast_dt)
where actual.city = 'New York'
and   actual.country = 'US'
order by forecast_dt desc, prediction_dt desc
limit 10