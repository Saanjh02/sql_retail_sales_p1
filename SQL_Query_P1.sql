--SQL RETAIL SALES ANALYSIS - P1
CREATE DATABASE sql_project_p2;

--1. DATABASE SETUP 
--Create TABLE
DROP TABLE IF EXISTS retail_sales
CREATE TABLE retail_sales
               (
                  transactions_id INT PRIMARY KEY,
                  sale_date	DATE,
			      sale_time	TIME,
                  customer_id INT,	
			      gender VARCHAR(15),	
			      age INT,	
			      category VARCHAR(15),	
			      quantity INT,	
			      price_per_unit FLOAT,	
			      cogs FLOAT,	
			      total_sale FLOAT
               );


--2.DATA EXPLORATION & CLEANING
--Record Count: Determine the total number of records in the dataset.
SELECT COUNT(*) FROM retail_sales;
--2000

--Customer Count: Find out how many unique customers are in the dataset.
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
--155

--Category Count: Identify all unique product categories in the dataset.
SELECT DISTINCT category FROM retail_sales;

--Null Value Check: Check for any null values in the dataset and delete records with missing data.
SELECT * FROM retail_sales

WHERE sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
--0

SELECT * FROM retail_sales;

--3. DATA ANALYSIS & FINDINGS
--Write a SQL query to retrieve all columns for sales made on 2022-11-05
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';

--Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT * FROM retail_sales
WHERE category = 'Clothing' AND quantity >=4 AND (sale_date BETWEEN '2022-11-01' AND '2022-11-30');

--Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT  SUM(total_sale) AS total_sum, COUNT(*) AS total_count, category FROM retail_sales 
GROUP BY category;

--Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
SELECT AVG(age) AS avg_age_of_customer
FROM retail_sales
WHERE category = 'Beauty';

--Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM retail_sales
WHERE total_sale > '1000';


--Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
SELECT gender, category,COUNT(*) AS total_transactions FROM retail_sales
GROUP BY gender, category;

--Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

SELECT year, month , avg_sale 
FROM (
	SELECT YEAR(sale_date) AS year, MONTH(sale_date) AS month, ROUND(AVG(total_sale),2) AS avg_sale ,RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS rank
	FROM retail_sales
	GROUP BY MONTH(sale_date), YEAR(sale_date) 
	) AS base
WHERE rank = 1
ORDER BY year;

--Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT TOP 5 customer_id, SUM(total_sale) AS total_sale FROM retail_sales
GROUP BY customer_id
ORDER BY total_sale DESC;

--Write a SQL query to find the number of unique customers who purchased items from each category.:
SELECT COUNT(DISTINCT customer_id) AS no_of_unique_customers ,category FROM retail_sales
GROUP BY category;

--Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
SELECT 
    CASE WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
         WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
         ELSE 'Evening' END AS shift,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY 
    CASE WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
         WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
         ELSE 'Evening' END;

--END OF PROJECT


