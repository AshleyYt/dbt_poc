{{
    config(
        materialized='ephemeral'
    )
}}

select distinct wa.v:city.name as city,
count(wa.v:city.name) as frequency

from {{ source('weather', 'weather_14_total')}} wa
where wa.v:city.country='US'
group by 1
order by 2 desc
limit 20