SELECT 
    {{ dbt_utils.generate_surrogate_key(['orders.orderNumber', 'orderdetails.orderLineNumber']) }} as fact_order_key,
    {{ dbt_utils.generate_surrogate_key(['orders.customerNumber']) }} as customer_key, 
    {{ dbt_utils.generate_surrogate_key(['employees.employeeNumber']) }} as employee_key,
    {{ dbt_utils.generate_surrogate_key(['offices.officeCode']) }} as office_key,
    {{ dbt_utils.generate_surrogate_key(['productCode']) }} as product_key, 
    orders.orderDate as order_date,
    orders.requiredDate as order_required_date, 
    orders.shippedDate as order_shipped_date,
    orderdetails.quantityOrdered as quantity_ordered, 
    orderdetails.priceEach as product_price
FROM {{var("source_schema")}}.orders
JOIN {{var("source_schema")}}.orderdetails ON orders.orderNumber = orderdetails.orderNumber
JOIN {{var("source_schema")}}.customers ON orders.customerNumber = customers.customerNumber
JOIN {{var("source_schema")}}.employees ON customers.salesRepEmployeeNumber = employees.employeeNumber
JOIN {{var("source_schema")}}.offices ON employees.officeCode = offices.officeCode