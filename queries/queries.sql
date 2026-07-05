-- Clean sales_date column
ALTER TABLE retail_sales_project.sales_data
ADD COLUMN sales_date_clean DATE;
UPDATE retail_sales_project.sales_data
SET sales_date_clean = STR_TO_DATE(sales_date, '%d/%m/%Y');

-- Question 1: What is the total revenue, total quantity and total transactions?
SELECT SUM(total_amount) AS total_revenue, SUM(quantity) AS total_quantity, COUNT(transaction_id) AS transaction_count
FROM sales_data;

-- Question 2: For each product category, what is the total revenue and number of transactions?
SELECT product_category, SUM(total_amount) AS revenue, COUNT(transaction_id) AS transactions
FROM sales_data
GROUP BY product_category;

-- Question 3: What is the average transaction value?
SELECT ROUND(SUM(total_amount)/COUNT(*), 2) AS average_transaction_value
FROM sales_data;

-- Question 4: For each month, what is the total revenue and how many transactions occurred?
SELECT DATE_FORMAT(sales_date_clean, '%Y-%m') AS sales_month, SUM(total_amount) AS revenue_per_month, COUNT(transaction_id) AS transactions_per_month
FROM sales_data
GROUP BY sales_month
ORDER BY sales_month;

-- Question 5: Which product categories generate the highest total revenue?
SELECT product_category, SUM(total_amount) AS total_revenue
FROM sales_data
GROUP BY product_category
ORDER BY total_revenue DESC
LIMIT 1;

-- Question 6: Who are the top 5 customer by total spending and what percentage of revenue do they contribute?
SELECT customer_id, SUM(total_amount) AS total_amount, ROUND(SUM(total_amount)*100/(SELECT SUM(total_amount) FROM sales_data),2) AS percentage_of_revenue
FROM sales_data
WHERE total_amount >= ALL(SELECT total_amount FROM sales_data)
GROUP BY customer_id
LIMIT 5;

-- Question 7: How does total revenue and number of transactions differ by customer gender?
SELECT gender, SUM(total_amount) AS total_revenue, COUNT(transaction_id) AS transaction_count
FROM sales_data
GROUP BY gender
ORDER BY total_revenue DESC;

-- Question 8: What is the average age of customers who purchase each product category?
SELECT product_category, ROUND(AVG(age), 2) AS average_age
FROM sales_data
GROUP BY product_category;

-- Question 9: What is the the total revenue, number of transactions and revenue per transaction for each age band?
SELECT "10 to 19" AS age_band, SUM(total_amount) AS total_revenue, COUNT(*) AS transaction_count, ROUND(SUM(total_amount)/COUNT(*),2) AS revenue_per_transaction
FROM sales_data
WHERE age BETWEEN 10 AND 19
UNION ALL
SELECT "20 to 29" AS age_band, SUM(total_amount) AS total_revenue, COUNT(*) AS transaction_count, ROUND(SUM(total_amount)/COUNT(*),2) AS revenue_per_transaction
FROM sales_data
WHERE age BETWEEN 20 AND 29
UNION ALL
SELECT "30 to 39" AS age_band, SUM(total_amount) AS total_revenue, COUNT(*) AS transaction_count, ROUND(SUM(total_amount)/COUNT(*),2) AS revenue_per_transaction
FROM sales_data
WHERE age BETWEEN 30 AND 39
UNION ALL
SELECT "40 to 49" AS age_band, SUM(total_amount) AS total_revenue, COUNT(*) AS transaction_count, ROUND(SUM(total_amount)/COUNT(*),2) AS revenue_per_transaction
FROM sales_data
WHERE age BETWEEN 40 AND 49
UNION ALL
SELECT "50 to 59" AS age_band, SUM(total_amount) AS total_revenue, COUNT(*) AS transaction_count, ROUND(SUM(total_amount)/COUNT(*),2) AS revenue_per_transaction
FROM sales_data
WHERE age BETWEEN 50 AND 59
UNION ALL
SELECT "60 to 69" AS age_band, SUM(total_amount) AS total_revenue, COUNT(*) AS transaction_count, ROUND(SUM(total_amount)/COUNT(*),2) AS revenue_per_transaction
FROM sales_data
WHERE age BETWEEN 60 AND 69;

-- Question 10: Which day of the week and which month have the highest and lowest total revenue?
SELECT CASE WHEN WEEKDAY(sales_date_clean) = 0 THEN 'Mon' 
			WHEN WEEKDAY(sales_date_clean) = 1 THEN 'Tue'
            WHEN WEEKDAY(sales_date_clean) = 2 THEN 'Wed'
            WHEN WEEKDAY(sales_date_clean) = 3 THEN 'Thu'
            WHEN WEEKDAY(sales_date_clean) = 4 THEN 'Fri'
            WHEN WEEKDAY(sales_date_clean) = 5 THEN 'Sat'
            WHEN WEEKDAY(sales_date_clean) = 6 THEN 'Sun' END AS day_of_week, SUM(total_amount) AS total_revenue
FROM sales_data
GROUP BY day_of_week
ORDER BY total_revenue DESC
LIMIT 1; 

SELECT CASE WHEN WEEKDAY(sales_date_clean) = 0 THEN 'Mon' 
			WHEN WEEKDAY(sales_date_clean) = 1 THEN 'Tue'
            WHEN WEEKDAY(sales_date_clean) = 2 THEN 'Wed'
            WHEN WEEKDAY(sales_date_clean) = 3 THEN 'Thu'
            WHEN WEEKDAY(sales_date_clean) = 4 THEN 'Fri'
            WHEN WEEKDAY(sales_date_clean) = 5 THEN 'Sat'
            WHEN WEEKDAY(sales_date_clean) = 6 THEN 'Sun' END AS day_of_week, SUM(total_amount) AS total_revenue
FROM sales_data
GROUP BY day_of_week
ORDER BY total_revenue
LIMIT 1;

SELECT MONTHNAME(sales_date_clean) AS sale_month, SUM(total_amount) AS total_revenue
FROM sales_data
GROUP BY sale_month
ORDER BY  total_revenue DESC
LIMIT 1;

SELECT MONTHNAME(sales_date_clean) AS sale_month, SUM(total_amount) AS total_revenue
FROM sales_data
GROUP BY sale_month
ORDER BY  total_revenue 
LIMIT 1;

-- Question 11: Which months show above-average revenue and which show below-average revenue compared to the overall mean?
SELECT MONTH(sales_date_clean) AS sale_month,
		CASE WHEN AVG(total_amount) > (SELECT AVG(total_amount) FROM sales_data) THEN "above average" WHEN AVG(total_amount) < (SELECT AVG(total_amount) FROM sales_data) THEN "below average" END AS 'above_or_below_average'
FROM sales_data
GROUP BY sale_month
ORDER BY sale_month;

-- Question 12: How many transactions have total amount above a chosen threshold (e.g. > 500), and what percentage of transactions and percentage of total revenue do they represent?
SELECT COUNT(transaction_id) AS transaction_count, ROUND(COUNT(transaction_id)*100/(SELECT COUNT(*) FROM sales_data), 2) AS percentage_of_transaction, ROUND(SUM(total_amount)*100/(SELECT SUM(total_amount) FROM sales_data), 2) AS percentage_of_revenue
FROM sales_data
WHERE total_amount > 500;

-- Question 13: For each product category, who is the top customer by total spend (using window functions)?
SELECT product_category, customer_id, total_amount
FROM (SELECT *, ROW_NUMBER() OVER(PARTITION BY product_category ORDER BY total_amount DESC) AS rn FROM sales_data) AS rn_table
WHERE rn = 1;

-- Question 14: For each year, which month has the highest average transaction value or total revenue (using window functions)?
WITH month_stats AS (SELECT YEAR(sales_date_clean) AS sale_year, MONTH(sales_date_clean) AS sale_month, SUM(total_amount) AS total_revenue FROM sales_data GROUP BY sale_year, sale_month)
SELECT sale_year, sale_month, total_revenue
FROM (SELECT sale_year, sale_month, total_revenue, ROW_NUMBER() OVER(PARTITION BY sale_year ORDER BY total_revenue DESC) AS rn
	  FROM month_stats) AS rn_table
WHERE rn = 1
ORDER BY sale_year;

-- Question 15: How can all customers be ranked by total spend, showing their rank, total amount, and number of transactions?
WITH customer_stats AS (SELECT customer_id, SUM(total_amount) AS total_spend, COUNT(transaction_id) AS transaction_count FROM sales_data GROUP BY customer_id)
SELECT customer_id, total_spend, RANK() OVER(ORDER BY total_spend DESC) AS rnk, transaction_count
FROM customer_stats;

-- Question 16: For each product category, what is the average quantity per transaction, and which categories tend to have larger baskets?
WITH product_stats AS (SELECT product_category, AVG(quantity) AS average_quantity FROM sales_data GROUP BY product_category)
SELECT product_category, average_quantity, RANK() OVER(ORDER BY average_quantity DESC) AS rnk
FROM product_stats;