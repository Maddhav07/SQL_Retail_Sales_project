-- create table 

CREATE TABLE Retail_sales
   (
   transactions_id int primary key,
   sale_date date,
   sale_time time,
   customer_id int,
   gender varchar(15),
   age int,
   category varchar(20),
   quantiy int,
   price_per_unit int,
   cogs float,
   total_sale float

  );

SELECT * FROM RETAIL_SALES;

SELECT COUNT(*) FROM RETAIL_SALES;

--  DATA CLEANING

SELECT * FROM RETAIL_SALES
 WHERE transactions_id IS NULL
  OR
  SALE_DATE IS NULL
  OR 
  SALE_TIME IS NULL
  OR 
  CUSTOMER_ID IS NULL
  OR 
  GENDER IS NULL
  OR 
  AGE IS NULL
  OR 
  CATEGORY IS NULL
  OR 
  QUANTIY IS NULL
  OR 
  PRICE_PER_UNIT IS NULL
  OR 
  COGS IS NULL
  OR 
  TOTAL_SALE IS NULL;

-- DELETE NULL VALUE

DELETE FROM RETAIL_SALES
WHERE transactions_id IS NULL
  OR
  SALE_DATE IS NULL
  OR 
  SALE_TIME IS NULL
  OR 
  CUSTOMER_ID IS NULL
  OR 
  GENDER IS NULL
  OR 
  AGE IS NULL
  OR 
  CATEGORY IS NULL
  OR 
  QUANTIY IS NULL
  OR 
  PRICE_PER_UNIT IS NULL
  OR 
  COGS IS NULL
  OR 
  TOTAL_SALE IS NULL;

-- DATA EXPLORATION  

  -- HOW MANY CUSTOMER WE HAVE ?

  SELECT COUNT(*) AS TOTAL_SALES FROM RETAIL_SALES;

  -- HOW MANY UNIQUE CUSTOMER WE HAVE ?

  SELECT COUNT(DISTINCT CUSTOMER_ID) AS TOTAL_SALES FROM RETAIL_SALES;

  -- DATA ANALYSIS 
  -- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05 ?

  SELECT * FROM RETAIL_SALES 
  WHERE SALE_DATE = '2022-11-05';

--2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022 ?
SELECT * FROM RETAIL_SALES
WHERE CATEGORY = 'Clothing'
AND TO_CHAR(SALE_DATE,'YYYY-MM') = '2022-11'
AND QUANTIY > 3;

alter table retail_sales
rename column quantiy to quantity;

-- 3. Write a SQL query to calculate the total sales (total_sale) for each category. ?

select category, sum(total_Sale)as total_sales from retail_sales
group by category;

-- 4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.? 

select round(avg(age),2) from retail_Sales
where category = 'Beauty';

-- 5. Write a SQL query to find all transactions where the total_sale is greater than 1000.?  

select (total_Sale) from retail_Sales;
where total_sale > 1000;

-- 6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.?

select category, gender,count(transactions_id) from retail_sales
group by gender , category;

-- 7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

select * from 
(
select
extract(year from sale_date) as year,
extract(month from sale_date) as month,
avg(total_Sale) as avg_Sale,
rank() over(partition by extract(year from sale_date) order by avg(total_Sale) desc) as rank
from retail_Sales 
group by 1 , 2 
) as t1
where rank = 1;
-- 8. Write a SQL query to find the top 5 customers based on the highest total sales. ?

select customer_id, sum(total_Sale) as total_Sum from retail_sales
group by 1
order by total_sum desc
limit 5;

-- 9. Write a SQL query to find the number of unique customers who purchased items from each category.?

select count(distinct customer_id), category from retail_sales
group by category;

-- 10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
 with hourly_sale 
 as
 (
 select *,
 case
     when extract(hour from sale_time) < 12 then 'morning'
	 when extract(hour from sale_time) between 12 and 17 then 'afternoon'
	 else 'evening'
 end as shift
 from retail_sales 
) 
select count(*), shift from hourly_sale
group by shift;
 






  
