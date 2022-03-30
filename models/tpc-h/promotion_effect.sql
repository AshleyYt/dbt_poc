

select
    100.00 * sum(case 
        when p_type like 'PROMO%'
        then l_extendedprice*(1-l_discount) else 0
        end) / sum(l_extendedprice * (1 - l_discount)) as promo_revenue
from
{{ source('tpch_sf1','lineitem')}},
{{ source('tpch_sf1','part')}}
where
    l_partkey = p_partkey
    and l_shipdate >= {{var('promotion_month')}}
    and l_shipdate <  dateadd(month, 1, {{var('promotion_month')}})
limit 10