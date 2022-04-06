{% snapshot forecast_error_snapshot %}

{{
    config(
        target_schema='weather',
        strategy='check',
        unique_key = "city||'-'||country",
        check_cols = 'all'    )
}}

select 
        city||'-'||country as id,
        city, 
        country,
        report_date_start,
        report_date_end,
        record_base,
        mean_absolute_deviation
from {{ ref('forecast_error_report') }}

{% endsnapshot %}