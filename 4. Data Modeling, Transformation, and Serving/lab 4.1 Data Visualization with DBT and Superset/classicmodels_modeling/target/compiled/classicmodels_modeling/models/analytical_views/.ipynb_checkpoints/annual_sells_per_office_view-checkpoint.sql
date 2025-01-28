

SELECT 
    DISTINCT fct.office_key
    , dof.city 
    , dof.state 
    , dof.country
    , dof.territory
    , SUM(fct.quantity_ordered) AS total_quantity 
    , sum(fct.quantity_ordered*fct.product_price) as total_price
    , EXTRACT(YEAR FROM fct.order_date) as year
FROM classicmodels_star_schema.fact_orders AS fct
JOIN classicmodels_star_schema.dim_offices AS dof ON dof.office_key=fct.office_key
GROUP BY fct.office_key
    , dof.city
    , dof.state
    , dof.country
    , dof.territory
    , EXTRACT(YEAR FROM fct.order_date)
ORDER BY fct.office_key ASC, year ASC