
  
    

  create  table "postgres"."classicmodels_star_schema"."dim_products__dbt_tmp"
  
  
    as
  
  (
    SELECT 
    md5(cast(coalesce(cast(productCode as TEXT), '') as TEXT)) as product_key, 
    productName as product_name, 
    products.productLine as product_line, 
    productScale as product_scale, 
    productVendor as product_vendor,
    productDescription as product_description, 
    textDescription as product_line_description
FROM classicmodels.products
JOIN classicmodels.productlines ON products.productLine=productlines.productLine
  );
  