{{
    config(
        materialized = 'incremental',
        unique_key = "city||'-'||country",
    )
}}

select  city, 
        country,
        to_date(min(report_date)) as report_date_start,
        to_date(max(report_date)) as report_date_end,
        count(report_date) as record_base,
        round(avg(abs(forecast_temp - actual_temp)), 2) as mean_absolute_deviation
from {{ ref('weather_report') }}
group by 1, 2

