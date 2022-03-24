select 
    i.i_category, i.i_brand, cc.cc_name, dd.d_year, dd.d_moy,
    sum(cs.cs_sales_price) as sum_sales,
    avg(sum(cs.cs_sales_price)) over
        (partition by i.i_category, i.i_brand, cc.cc_name, dd.d_year)
    as avg_monthly_sales,
    rank() over (partition by i.i_category, i.i_brand, cc.cc_name
        order by dd.d_year, dd.d_moy) rn
from SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.item i
left join SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.catalog_sales cs
left join SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.date_dim dd
left join SNOWFLAKE_SAMPLE_DATA.TPCDS_SF10TCL.call_center cc
on  cs.cs_item_sk = i.i_item_sk and 
    cs.cs_sold_date_sk = dd.d_date_sk and
    cc.cc_call_center_sk= cs.cs_call_center_sk
where dd.d_year = 2000
group by 1, 2, 3, 4, 5