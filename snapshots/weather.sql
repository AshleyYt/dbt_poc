{% snapshot weather_snapshot %}

{{
    config(
      target_database='dev',
      target_schema='snapshots',
      unique_key='v',

      strategy='timestamp',
      updated_at='updated_at'
    )
}}

select * from {{ source('weather', 'weather_14_total') }}
    limit 10


{% endsnapshot %}