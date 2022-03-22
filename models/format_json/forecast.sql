select ow.v:time         as prediction_dt,
        ow.v:city.name    as city,
        ow.v:city.country as country
 from snowflake_sample_data.weather.daily_14_total ow
 limit 10