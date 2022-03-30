{% snapshot large_volume_customer_snapshot %}

{{
    config(
      target_database='dev',
      target_schema='snapshots',
      unique_key='c_custkey',

      strategy='check',
      check_cols=['customer_name', 'total_quantity']
    )
}}

select * from {{ ref('large_volume_customer') }}
    limit 10

{% endsnapshot %}
