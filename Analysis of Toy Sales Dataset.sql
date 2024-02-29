-- Analysis of Toy Sales Dataset

-- 1) Retrieve all columns for all records in the dataset.

SELECT *
FROM sales_clean

-- 2) What are all the unique product_line present in the dataset?

SELECT DISTINCT product_line
FROM sales_clean

-- 3) What are all the unique status present in the dataset?

SELECT DISTINCT status
FROM sales_clean

-- 4) What are all the unique deal_size present in the dataset?

SELECT DISTINCT deal_size
FROM sales_clean

-- 5) Product_code and their corresponding Product_line

SELECT DISTINCT product_code, product_line
FROM sales_clean
ORDER BY product_line

-- 6) Number of Products (shipped) across product_line from higher to lower

SELECT product_line, COUNT(product_line) AS number_of_products
FROM sales_clean
WHERE status = 'Shipped'
GROUP BY product_line
ORDER BY number_of_products DESC

-- 7) Details of the products based on status

SELECT product_line,count(product_line) AS number_of_products,status
FROM sales_clean
GROUP BY product_line,status
ORDER BY number_of_products DESC,status

-- 8) Changing the datatype from string to date and changing the format

ALTER TABLE sales_clean
ADD COLUMN temp_order_date DATE

UPDATE sales_clean
SET temp_order_date = STR_TO_DATE(order_date, '%m-%d-%Y')
WHERE order_date LIKE '%-%';

UPDATE sales_clean
SET temp_order_date = STR_TO_DATE(order_date, '%m/%d/%Y')
WHERE order_date LIKE '%/%';

ALTER TABLE sales_clean
DROP COLUMN order_date;

ALTER TABLE sales_clean
CHANGE COLUMN temp_order_date order_date DATE;

-- 9) Total sales amount in $ across product_line

SELECT product_line, SUM(sales) AS total_sales_amount
FROM sales_clean
GROUP BY product_line
ORDER BY total_sales_amount DESC

-- 10) Total sales amount in $ across month wise

SELECT month_id, SUM(sales) AS total_sales_amount
FROM sales_clean
GROUP BY month_id
ORDER BY total_sales_amount DESC

-- 11) Total sales amount in $ across year wise

SELECT year_id, SUM(sales) AS total_sales_amount
FROM sales_clean
GROUP BY year_id
ORDER BY total_sales_amount DESC

-- 12) To find Top 5 Cities that has highest sales

SELECT city, SUM(sales) AS total_sales_amount
FROM sales_clean
GROUP BY city
ORDER BY total_sales_amount DESC
LIMIT 5

-- 13) To find Top 3 Countries that has highest sales

SELECT country, SUM(sales) AS total_sales_amount
FROM sales_clean
GROUP BY country
ORDER BY total_sales_amount DESC
limit 3

-- 14) To find top 10 customers

SELECT customer_name,SUM(sales) AS total_sales_amount
FROM sales_clean
GROUP BY customer_name
ORDER BY total_sales_amount DESC
LIMIT 10

-- 15) To find average price of the product line

SELECT product_line,ROUND(AVG(unit_price),2) AS avg_price
FROM sales_clean
GROUP BY product_line
ORDER BY avg_price DESC

-- 16) To find deal size of the customers

SELECT customer_name,deal_size
FROM sales_clean
ORDER BY deal_size

-- 17) To find Top 10 Product code that has highest sales

SELECT product_code, SUM(sales) AS total_sales_amount
FROM sales_clean
GROUP BY product_code
ORDER BY total_sales_amount DESC
LIMIT 10

-- 18) To find number of orders cancelled and its sales value

SELECT status,COUNT(order_number) as number_of_orders,sum(sales) as sale_value
FROM sales_clean
WHERE status = 'cancelled'

-- 19) To find the Details of the cancelled orders

SELECT order_number,customer_name,product_line,product_code,status
FROM sales_clean
WHERE status = 'cancelled'
order by order_number asc

-- 20) To find the Details of the orders in process

SELECT order_number,customer_name,product_line,product_code,status
FROM sales_clean
WHERE status = 'In Process'
order by order_number asc

-- 21) To find Top 5 Customer's that has high order quantities

SELECT customer_name,sum(quantity_ordered) AS total_quantity_ordered
FROM sales_clean
GROUP BY customer_name
ORDER BY total_quantity_ordered DESC
limit 5