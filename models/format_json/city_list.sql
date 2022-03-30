select distinct wa.v:city.name as city
from {{ source('weather', 'weather_14_total')}} wa