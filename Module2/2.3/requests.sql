-- Overview (обзор ключевых метрик)

-- Total Sales
SELECT SUM(sales) 
FROM orders;

-- Total Profit
SELECT SUM(profit) 
FROM orders;

-- Profit Ratio
SELECT SUM(profit) / SUM(sales) 
FROM orders;

-- Profit per Order
SELECT SUM(profit) / count(*) 
FROM orders;

-- Sales per Customer
SELECT SUM(sales) / COUNT(DISTINCT customer_id)
FROM orders;

-- Avg. Discount
SELECT AVG(discount)
FROM orders;

-- Monthly Sales by Segment
SELECT DATE_TRUNC('month', order_date)::date, segment, sum(sales)
FROM orders
GROUP BY DATE_TRUNC('month', order_date)::date, segment
ORDER BY DATE_TRUNC('month', order_date)::date, segment

-- Monthly Sales by Product Category
SELECT DATE_TRUNC('month', order_date)::date, category, sum(sales), count(sales)
FROM orders
GROUP BY DATE_TRUNC('month', order_date)::date, category
ORDER BY DATE_TRUNC('month', order_date)::date, category

-- Product Dashboard (Продуктовые метрики)

-- Sales by Product Category over time (Продажи по категориям)
SELECT category, sum(sales), count(sales)
FROM orders
GROUP BY category
ORDER BY sum(sales), count(sales)

-- Customer Analysis

-- Sales and Profit by Customer
SELECT customer_id, customer_name, SUM(Sales) as sum_sales, SUM(profit) as sum_profit
FROM orders
GROUP BY customer_id, customer_name

-- Customer Ranking
SELECT *, RANK() OVER(ORDER BY sum_sales DESC)
FROM (
	SELECT customer_id, customer_name, sum(sales) as sum_sales
	FROM orders
	GROUP BY customer_id, customer_name
)  as table_1

-- Sales per region
SELECT state, SUM(sales), COUNT(sales)
FROM orders
GROUP BY state
