with
forecast as
   ( select * from {{ref('forecast_ny')}} ),

actual as
   ( select * from {{ref('actual_ny')}} ),

prediction_report as (

    select  forecast.forecast_dt as date,
            forecast.city,
            forecast.country,
            forecast.forcasted_temp_max,
            forecast.forcasted_temp_min,
            actual.actual_temp_max,
            actual.actual_temp_min,
            forecast.weather_description as forecast_weather_description,
            forecast.weather_main as forecast_weather_category,
            actual.weather_description as actual_weather_description,
            actual.weather_main as actual_weather_category
    from actual
    left join forecast on actual.city = forecast.city and
                        actual.country = forecast.country and
                        dateactual.actual_dt = forecast.forecast_dt
    order by forecast_dt desc
)

select * from prediction_report limit 10

