
{{
  config(
    alias= loop_city()[1],
  )
}}

with
forecast as
   ( select * from {{ref('forecast_daily')}} ),

actual as
   ( select * from {{ref('actual_daily')}} ),

prediction_report as (

    select  actual.actual_date as report_date,
            forecast.city,
            forecast.country,
            forecast.forecast_temp,
            actual.actual_temp,
            forecast.weather_description as forecast_weather_description,
            forecast.weather_main as forecast_weather_category,
            actual.weather_description as actual_weather_description,
            actual.weather_main as actual_weather_category
    from actual
    left join forecast on  
    to_date(actual.actual_date) = to_date(forecast.forecast_date)
    order by 1 desc
)

select * from prediction_report
