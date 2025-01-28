SELECT 
    md5(cast(coalesce(cast(customerNumber as TEXT), '') as TEXT)) as customer_key, 
    customerName as customer_name,   
    contactLastName as customer_last_name, 
    contactFirstName as customer_first_name, 
    phone as phone, 
    addressLine1 as address_line_1, 
    addressLine2 as address_line_2, 
    postalCode as postal_code, 
    city as city, 
    state as state, 
    country as country,
    creditLimit as creditLimit
FROM classicmodels.customers