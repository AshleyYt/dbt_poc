
{{
  generate_flatten_json(
    model_name = ref('temp_v'),
    json_column = 'v'
  )
}}
where city_name = 'Mao'