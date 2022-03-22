{{
  config(
    materialized='view'
  )
}}

select distinct(to_date(forecast_dt)), count(*)
from {{ref('forecast_ny')}}
group by 1 order by 1