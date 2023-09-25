INSERT INTO company.ship_mode(ship_name)
SELECT DISTINCT ship_mode
FROM orders;

-- подгрузка новых данных в уже заполненную таблицу
INSERT INTO company.ship_mode(ship_name)
SELECT DISTINCT ship_mode
FROM orders
WHERE ship_mode not in (SELECT ship_mode
                       FROM company.ship_mode);

INSERT INTO company.product(product_name, category, subcategory)
SELECT DISTINCT product_name, category, subcategory
FROM orders;

-- подгрузка новых данных в уже заполненную таблицу
INSERT INTO company.product(product_name, category, subcategory)
SELECT DISTINCT o.product_name, o.category, o.subcategory
FROM company.product  AS cp
LEFT JOIN orders AS o
ON o.product_name = cp.product_name 
AND o.category = cp.category
AND o.subcategory = cp.subcategory
WHERE cp.product_name IS NULL AND cp.category IS NULL AND cp.subcategory IS NULL;

                       
INSERT INTO company.customer(customer_id_original, customer_name, segment)                     
SELECT DISTINCT customer_id, customer_name, segment
FROM orders;

-- подгрузка новых данных в уже заполненную таблицу
INSERT INTO company.customer(customer_id_original, customer_name, segment)
SELECT DISTINCT o.customer_id, o.customer_name, o.segment
FROM company.customer  AS cc
LEFT JOIN orders AS o
ON o.customer_id = cc.customer_id_original
AND o.customer_name = cc.customer_name
AND o.segment = cc.segment
WHERE cc.customer_id_original IS NULL AND cc.customer_name IS NULL;

                   
INSERT INTO company.address_data(country, state, city, postal_code)                    
SELECT DISTINCT country, state, city, postal_code
FROM orders;

-- подгрузка новых данных в уже заполненную таблицу
INSERT INTO company.address_data(country, state, city, postal_code)
SELECT DISTINCT o.country, o.state, o.city, o.postal_code
FROM company.address_data  AS ca
LEFT JOIN orders AS o
ON o.country = ca.country
AND o.state = ca.state
AND o.city = ca.city
AND o.postal_code = ca.postal_code
WHERE ca.country IS NULL
AND ca.state IS NULL
AND ca.city IS NULL
AND ca.postal_code IS NULL;

                       
INSERT INTO company.region(region, person)                     
SELECT DISTINCT region, person
FROM people;

INSERT INTO company.region(region, person)
SELECT DISTINCT o.region, o.person
FROM company.region  AS cr
LEFT JOIN people AS o
ON o.region = cr.region
AND o.person = cr.person
WHERE o.region IS NULL
AND o.person IS NULL;

INSERT INTO company.returned(returned)
SELECT DISTINCT returned
FROM returns;

INSERT INTO company.returned(returned)
SELECT DISTINCT r.returned
FROM returns  AS r
WHERE r.returned not in (SELECT DISTINCT returned
                         FROM company.returned);

SELECT DISTINCT o.order_id, 
       r.returned,
       o.sales,
       o.profit,
       o.discount,
       o.order_date,
       o.ship_date,
       cr.region_region_id AS region_id, 
       ca.address_data_id AS address_data_id,
       cc.customer_id AS customer_id,
       cs.ship_mode_id AS ship_mode_id,
       cp.product_id AS product_id, 
       crt.returned_id AS returned_id
       
FROM orders AS o
LEFT JOIN returns r ON o.order_id = r.order_id
LEFT JOIN people p ON o.region = p.region
LEFT JOIN company.region cr ON o.region = cr.region AND p.person = cr.person
LEFT JOIN company.address_data ca ON o.country = ca.country AND o.state = ca.state AND o.city = ca.city AND o.postal_code = ca.postal_code
LEFT JOIN company.customer cc ON o.customer_id = cc.customer_id_original
LEFT JOIN company.ship_mode cs ON o.ship_mode = cs.ship_name
LEFT JOIN company.product AS cp ON o.product_name = cp.product_name AND o.category = cp.category AND o.subcategory = cp.subcategory
LEFT JOIN company.returned AS crt ON r.returned = crt.returned;

INSERT INTO company.sales(order_id, 
                          sales, 
                          profit, 
                          discount, 
                          order_date, 
                          ship_date, 
                          region_id, 
                          address_data_id,
                          customer_id,
                          ship_mode_id,
                          product_id,
                          returned_id)
SELECT DISTINCT o.order_id, 
       o.sales,
       o.profit,
       o.discount,
       o.order_date,
       o.ship_date,
       cr.region_region_id AS region_id, 
       ca.address_data_id AS address_data_id,
       cc.customer_id AS customer_id,
       cs.ship_mode_id AS ship_mode_id,
       cp.product_id AS product_id, 
       crt.returned_id AS returned_id
       
FROM orders AS o
LEFT JOIN returns r ON o.order_id = r.order_id
LEFT JOIN people p ON o.region = p.region
LEFT JOIN company.region cr ON o.region = cr.region AND p.person = cr.person
LEFT JOIN company.address_data ca ON o.country = ca.country AND o.state = ca.state AND o.city = ca.city AND o.postal_code = ca.postal_code
LEFT JOIN company.customer cc ON o.customer_id = cc.customer_id_original
LEFT JOIN company.ship_mode cs ON o.ship_mode = cs.ship_name
LEFT JOIN company.product AS cp ON o.product_name = cp.product_name AND o.category = cp.category AND o.subcategory = cp.subcategory
LEFT JOIN company.returned AS crt ON r.returned = crt.returned;

SELECT *
FROM company.sales