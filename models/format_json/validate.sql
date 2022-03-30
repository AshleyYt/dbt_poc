{{
  config(
    materialized='view'
  )
}}





select * 
from {{source('weather', 'weather_14_total')}}
limit 10