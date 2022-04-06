
{{
  generate_flatten_json(
    model_name = source("weather", "weather_14_total"),
    json_column = 'v'
  )
}}
where city_name = '{{ loop_city()[0] }}'