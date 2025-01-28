SELECT 
    md5(cast(coalesce(cast(orders.orderNumber as TEXT), '') || '-' || coalesce(cast(orderdetails.orderLineNumber as TEXT), '') as TEXT)) as fact_order_key,
    md5(cast(coalesce(cast(orders.customerNumber as TEXT), '') as TEXT)) as customer_key, 
    md5(cast(coalesce(cast(employees.employeeNumber as TEXT), '') as TEXT)) as employee_key,
    md5(cast(coalesce(cast(offices.officeCode as TEXT), '') as TEXT)) as office_key,
    md5(cast(coalesce(cast(productCode as TEXT), '') as TEXT)) as product_key, 
    orders.orderDate as order_date,
    orders.requiredDate as order_required_date, 
    orders.shippedDate as order_shipped_date,
    orderdetails.quantityOrdered as quantity_ordered, 
    orderdetails.priceEach as product_price
FROM classicmodels.orders
JOIN classicmodels.orderdetails ON orders.orderNumber = orderdetails.orderNumber
JOIN classicmodels.customers ON orders.customerNumber = customers.customerNumber
JOIN classicmodels.employees ON customers.salesRepEmployeeNumber = employees.employeeNumber
JOIN classicmodels.offices ON employees.officeCode = offices.officeCode