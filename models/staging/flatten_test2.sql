select distinct
    f.key as column_name
from {{ source("weather", "weather_14_total") }} wa,
lateral flatten(input => wa.v) f