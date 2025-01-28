{{
config(
    materialized='view'
    )
}}
    
SELECT 
    dp.product_line
    , AVG(fct.quantity_ordered) AS avg_quantity 
    , AVG(fct.quantity_ordered*fct.product_price) AS avg_price
    , EXTRACT(MONTH FROM fct.order_date) AS month
    , EXTRACT(YEAR FROM fct.order_date) AS year 
FROM {{var("star_schema")}}.fact_orders AS fct
JOIN {{var("star_schema")}}.dim_products AS dp ON dp.product_key = fct.product_key
GROUP BY dp.product_line
    , EXTRACT(MONTH FROM fct.order_date)
    , EXTRACT(YEAR FROM fct.order_date)
ORDER BY
    dp.product_line ASC    
    , month ASC
    , year ASC