CREATE DATABASE pizzaDB;
USE  pizzaDB;

SELECT * FROM pizza_sales;

-- Total Revenue
SELECT SUM(total_price) AS Total_Revenue
FROM pizza_sales;

-- Total Order
SELECT COUNT(DISTINCT order_id) AS Total_Order
FROM pizza_sales;

-- Avg Order value
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Average_Order
FROM pizza_sales;

-- Total pizza sold
SELECT SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales;

-- Avg pizza per order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id)  AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Average_pizza
FROM pizza_sales;

SELECT order_date 
FROM pizza_sales 
WHERE order_date IS NULL 
LIMIT 10;

-- 1)	Daily Trend for total orders
SELECT 
  DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) AS order_day,
  COUNT(DISTINCT order_id) AS total_order
FROM pizza_sales
WHERE order_date IS NOT NULL
GROUP BY DAYOFWEEK(STR_TO_DATE(order_date, '%d-%m-%Y')), DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y'))
ORDER BY DAYOFWEEK(STR_TO_DATE(order_date, '%d-%m-%Y'));

-- 2)	Monthly Trend for total orders
SELECT 
  MONTHNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) AS order_month,
  COUNT(DISTINCT order_id) AS total_order
FROM pizza_sales
WHERE order_date IS NOT NULL
GROUP BY MONTH(STR_TO_DATE(order_date, '%d-%m-%Y')), MONTHNAME(STR_TO_DATE(order_date, '%d-%m-%Y'))
ORDER BY MONTH(STR_TO_DATE(order_date, '%d-%m-%Y'));

-- 3)Percentage of sales by pizza category
SELECT pizza_category, SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales ) AS Pizza_PCT_by_cat
FROM pizza_sales
GROUP BY pizza_category;

-- 4)Percentage of sales by pizza size
SELECT pizza_size, SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales ) AS Pizza_PCT_by_size
FROM pizza_sales
GROUP BY pizza_size;

-- 5)Total pizza sold by pizza category
SELECT pizza_category, SUM(quantity) AS Total_pizza_sold
FROM pizza_sales
GROUP BY pizza_category;

-- 1) Top 5 best Seller by revenue
SELECT pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(total_price) DESC
LIMIT 5;

-- 2)	Top 5 best Seller by quantity
SELECT pizza_name, SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(quantity) DESC
LIMIT 5;

-- 3)	Top 5 best Seller by order
SELECT pizza_name, COUNT(order_id) AS Total_Order
FROM pizza_sales
GROUP BY pizza_name
ORDER BY COUNT(order_id) DESC
LIMIT 5;

-- 4) Bottom 5 best Seller by revenue
SELECT pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(total_price) ASC
LIMIT 5;

-- 5) Bottom 5 best Seller by quantity
SELECT pizza_name, SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(quantity) ASC
LIMIT 5;

-- 6) Bottom 5 best Seller by order
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Order
FROM pizza_sales
GROUP BY pizza_name
ORDER BY COUNT(order_id) ASC
LIMIT 5;


