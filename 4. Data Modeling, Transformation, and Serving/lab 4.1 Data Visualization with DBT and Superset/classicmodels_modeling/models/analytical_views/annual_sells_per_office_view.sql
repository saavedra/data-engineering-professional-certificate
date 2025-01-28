{{
config(
    materialized='view'
    )
}}

SELECT 
    DISTINCT fct.office_key
    , dof.city 
    , dof.state 
    , dof.country
    , dof.territory
    , SUM(fct.quantity_ordered) AS total_quantity 
    , sum(fct.quantity_ordered*fct.product_price) as total_price
    , EXTRACT(YEAR FROM fct.order_date) as year
FROM {{var("star_schema")}}.fact_orders AS fct
JOIN {{var("star_schema")}}.dim_offices AS dof ON dof.office_key=fct.office_key
GROUP BY fct.office_key
    , dof.city
    , dof.state
    , dof.country
    , dof.territory
    , EXTRACT(YEAR FROM fct.order_date)
ORDER BY fct.office_key ASC, year ASC