-- {{ config(alias='{{get_city()}}_weather_report') }}

with
forecast as
   ( select * from {{ref('forecast_aggregated')}} ),

actual as
   ( select * from {{ref('actual_aggregated')}} ),

prediction_report as (

    select  actual.actual_date as report_date,
            forecast.city,
            forecast.country,
            forecast.forecast_max,
            forecast.forecast_min,
            actual.actual_max,
            actual.actual_min,
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

