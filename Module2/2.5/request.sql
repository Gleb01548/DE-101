SELECT SUM(sales) 
FROM company.sales;

SELECT SUM(profit) 
FROM company.sales;

SELECT SUM(profit) / SUM(sales) 
FROM company.sales;

SELECT SUM(profit) / count(*) 
FROM company.sales;

SELECT SUM(sales) / COUNT(DISTINCT customer_id)
FROM company.sales;

-- Avg. Discount
SELECT AVG(discount)
FROM company.sales;

-- Monthly Sales by Segment
SELECT DATE_TRUNC('month', order_date)::date, segment, sum(sales)
FROM company.sales as s
left join company.customer as cc on s.customer_id = cc.customer_id
GROUP BY DATE_TRUNC('month', order_date)::date, segment
ORDER BY DATE_TRUNC('month', order_date)::date, segment;

-- Monthly Sales by Product Category
SELECT DATE_TRUNC('month', order_date)::date, category, sum(sales)
FROM company.sales as s
left join company.product as cp on s.product_id = cp.product_id
GROUP BY DATE_TRUNC('month', order_date)::date, category
ORDER BY DATE_TRUNC('month', order_date)::date, category;

-- Sales by Product Category over time (Продажи по категориям)
SELECT category, sum(sales), count(sales)
FROM company.sales as s
left join company.product as cp on s.product_id = cp.product_id
GROUP BY category
ORDER BY sum(sales), count(sales);

-- Customer Analysis

-- Sales and Profit by Customer
SELECT s.customer_id, customer_name, SUM(Sales) as sum_sales, SUM(profit) as sum_profit
FROM company.sales as s
left join company.customer as cc on s.customer_id = cc.customer_id
GROUP BY s.customer_id, customer_name;

-- Customer Ranking
SELECT *, RANK() OVER(ORDER BY sum_sales DESC)
FROM (
    SELECT s.customer_id, customer_name, SUM(Sales) as sum_sales
    FROM company.sales as s
    left join company.customer as cc on s.customer_id = cc.customer_id
    GROUP BY s.customer_id, customer_name
)  as table_1;

-- Sales per region
SELECT state, SUM(sales), COUNT(sales)
FROM company.sales as s
left join company.address_data as cad on s.address_data_id = cad.address_data_id
GROUP BY state;