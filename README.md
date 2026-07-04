# Retail Sales SQL Analysis

## Project overview
This project analyses a retail sales dataset using SQL to uncover revenue trends, customer behaviour, and product performance. The goal is to demonstrate practical SQL skills relevant to data analyst and data science roles.

## Dataset
Source: Kaggle Retail Sales Dataset (transaction‑level data).

Example fields: Transaction ID, Date, Customer ID, Gender, Age, Product Category, Quantity, Price per Unit, Total Amount.

## Tools and skills
- MySQL / SQL
- MySQL Workbench
- Git + GitHub

SQL features demonstrated:
- SELECT, WHERE, ORDER BY
- Aggregations and GROUP BY
- Date functions (year, month, day of week)
- CASE expressions
- Window functions (RANK/ROW_NUMBER) for advanced analysis

## Business questions
Revenue analysis
1. What is the total revenue and total quantity sold across all transactions?
2. For each product category, what is the total revenue and number of transactions?
3. What is the overall average transaction value (total amount per transaction)?
4. For each month, what is the total revenue and how many transactions occurred?
5. Which 3 product categories generate the highest total revenue?

Customer and demographic insights
6. Which 5 customers have the highest total spend, and what is their total amount and transaction count?
7. How does total revenue and number of transactions differ by customer gender?
8. What is the average age of customers who purchase each product category?
9. If age bands are defined (e.g. <25, 25–34, 35–44, 45+), what is the total revenue and number of transactions for each age band?
10. How many customers made more than one transaction, and what percentage of total revenue comes from repeat customers versus one‑time customers?

Time‑based patterns
11. Which day of the week and which month have the highest total revenue?
12. Which months show above‑average revenue and which show below‑average revenue compared to the overall mean?
13. How many transactions have total amount above a chosen threshold (e.g. > £500), and what percentage of total revenue do they represent?

Advanced SQL insights
14. For each product category, who is the top customer by total spend (using window functions)?
15. For each year, which month has the highest average transaction value or total revenue (using window functions)?
16. How can all customers be ranked by total spend, showing their rank, total amount, and number of transactions?
17. For each product category, what is the average quantity per transaction, and which categories tend to have larger baskets?
18. For each customer, what is the time difference between their first and last transaction, and which customers have the longest active period?

## Files in this project
- schema.sql – Table creation scripts for the retail sales database.
- queries.sql – SQL queries answering each business question, grouped and commented by section.
- data/ – Raw CSV file from Kaggle used for the analysis.
- results/ – Optional CSV exports or screenshots of key query outputs.
- README.md – Project overview, dataset description, business questions, and instructions.

## How to run the project
1. Import the dataset into MySQL using MySQL Workbench (Table Data Import Wizard) to create the sales_data table.
2. Run schema.sql if you want to recreate the database structure from scratch.
3. Open queries.sql in your SQL editor and run each query block to answer the corresponding business question.
4. Optionally export selected result sets to CSV for further analysis or visualisation.
