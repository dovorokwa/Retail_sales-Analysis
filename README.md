# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Sales Analysis Project 
**Database**: `p1_retail_db`

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `sales_analysis project`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE sales_analysis_project;

CREATE TABLE sales_analysis_tb
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

select * from sales_analysis_tb
select count(*) from sales_analysis_tb
select count(distinct customer_id) as total_sales from sales_analysis_tb
select count(distinct category) as category from sales_analysis_tb
-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

select *from sales_analysis_tb
where sale_date = '2022-11-05'
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
SELECT
*
from sales_analysis_tb
WHERE category = 'Clothing'
  AND sale_date BETWEEN '2022-11-01' AND '2022-11-30'
  and quantity>=4


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select category, sum(total_sale) as total_sale
from sales_analysis_tb
group By category
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select category, round(avg(age),2) as average_age
from sales_analysis_tb
where
category='Beauty'
group by category


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select *from sales_analysis_tb
where total_sale>1000
**Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select category, gender, count(transactions_id)as number_of_transactions
from sales_analysis_tb
group by category,gender


**Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT*FROM(
SELECT
    EXTRACT(YEAR FROM sale_date) AS sale_year,
    EXTRACT(MONTH FROM sale_date) AS sale_month,
    AVG(total_sale) AS average_total_sale,
	RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(TOTAL_SALE) DESC )
FROM sales_analysis_tb
GROUP BY 1,2
) AS RANGINGS
WHERE RANK = 1
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT CUSTOMER_ID, SUM(TOTAL_SALE) AS TOTAL_SALE
FROM SALES_ANALYSIS_TB
GROUP BY CUSTOMER_ID
ORDER BY TOTAL_SALE DESC
LIMIT(5)
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT  
CATEGORY,
COUNT(DISTINCT CUSTOMER_ID) AS UNIQUE_VALUES
FROM SALES_ANALYSIS_TB
GROUP BY 1
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
WITH HOURLY_SALE AS(
SELECT*,
CASE
WHEN EXTRACT(HOUR FROM SALE_TIME)<12 THEN 'MORNING'
WHEN EXTRACT(HOUR FROM SALE_TIME) BETWEEN 12 AND 17 THEN 'AFTERNOON' 
ELSE 'EVENING'
END AS SHIFT
FROM SALES_ANALYSIS_TB
)
SELECT
SHIFT, 
COUNT(*) AS TOTAL_ORDERS
FROM HOURLY_SALE
GROUP BY SHIFT

--end of the project

```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

## Author - Daniel Dovorokwa

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. 
