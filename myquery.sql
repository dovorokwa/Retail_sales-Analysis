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
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select category, gender, count(transactions_id)as number_of_transactions
from sales_analysis_tb
group by category,gender
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
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
