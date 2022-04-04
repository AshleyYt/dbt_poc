
select 
        wa.v:city.coord.lat as lat,
        wa.v:city.coord.lon as lon,
        wa.v:city.name as city,
        wa.v:city.country as country,
        wa.v:city.id as city_id,
        wa.v:city.findname as findname,
        wa.v:city.langs as langs,
        wa.v:city.zoom as zoom,
        wa.v:clouds.all as clouds,
        wa.v:main.humidity as humidity,
        wa.v:main.pressure as pressure,
        wa.v:main.temp as actual_temp,
        wa.v:main.temp_max as actual_temp_max,
        wa.v:main.temp_min as actual_temp_min,
        wa.v:time as actual_time,
        wa.v:weather[0].description as weather_description,
        wa.v:weather[0].icon as weather_icon,
        wa.v:weather[0].id as weather_id,
        wa.v:weather[0].main as weather_main,
        wa.v:wind.deg as deg,
        wa.v:wind.speed as speed
from {{ source('weather', 'weather_14_total') }} wa
where wa.v:city.name = 'New York'