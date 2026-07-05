# Retail Sales SQL Analysis

## Project overview

This project analyses a retail sales dataset using SQL to uncover revenue trends, customer behaviour, and product performance. The goal is to demonstrate practical SQL skills relevant to data analyst and data science roles.

## Dataset

- Source: Kaggle Retail Sales Dataset (transaction‑level data).
- Example fields: Transaction ID, Date, Customer ID, Gender, Age, Product Category, Quantity, Price per Unit, Total Amount.

## Tools and skills

**Tools**

- MySQL
- MySQL Workbench
- Git and GitHub

**SQL skills demonstrated**

- SELECT, WHERE, ORDER BY
- Aggregations and GROUP BY
- Date functions (YEAR, MONTH, DAYOFWEEK)
- CASE expressions for bucketing (e.g. age bands, value bands)
- Window functions (RANK, ROW_NUMBER) for “top per group” logic

---

## Business questions

### 1. Revenue analysis

1. What is the total revenue, total quantity and total transactions?
2. For each product category, what is the total revenue and number of transactions?
3. What is the overall average transaction value (total amount per transaction)?
4. For each month, what is the total revenue and how many transactions occurred?
5. Which 3 product categories generate the highest total revenue?

### 2. Customer and demographic insights

6. Who are the top 5 customer by total spending and what percentage of revenue do they contribute?
7. How does total revenue and number of transactions differ by customer gender?
8. What is the average age of customers who purchase each product category?
9. If age bands are defined (e.g. `<25`, `25–34`, `35–44`, `45+`), what is the the total revenue, number of transactions and revenue per transaction for each age band?

### 3. Time‑based patterns

10. Which day of the week and which month have the highest and lowest total revenue?
11. Which months show above‑average revenue and which show below‑average revenue compared to the overall mean?
12. How many transactions have total amount above a chosen threshold (e.g. > 500), and what percentage of transactions and percentage of total revenue do they represent?

### 4. Advanced SQL insights

13. For each product category, who is the top customer by total spend (using window functions)?
14. For each year, which month has the highest average transaction value or total revenue (using window functions)?
15. How can all customers be ranked by total spend, showing their rank, total amount, and number of transactions?
16. For each product category, what is the average quantity per transaction, and which categories tend to have larger baskets?
    
---

## Repository structure

```text
retail-sales-sql-analysis/
├── README.md              # Project overview and business questions
├── schema.sql             # Table creation scripts
├── queries.sql            # SQL queries answering the questions
├── data/
│   └── retail_sales.csv   # Raw Kaggle dataset
└── results/
    └── *.csv / screenshots # Optional saved outputs
```

---

## How to run this project

1. **Create the database**

   - Use MySQL Workbench to create a schema (e.g. `retail_sales_project`).

2. **Import the data**

   - Use the Table Data Import Wizard in MySQL Workbench to import `data/retail_sales.csv` into a table (e.g. `sales_data`).

3. **Create the schema**

   - Run the commands in `schema.sql` if you want to recreate or standardise the table structure.

4. **Run the analysis**

   - Open `queries.sql` in MySQL Workbench.
   - Execute each query block to answer the corresponding business question.
   - Optionally export result sets to CSV and store them in `results/`.

---

## Next steps

- Add indexes or additional tables (e.g. product or customer dimensions) to extend the analysis.
- Build a Power BI or other BI dashboard on top of the SQL outputs for visual insights.
- Use this project as a portfolio example for data analyst / data science applications.
