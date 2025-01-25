-----CREATE TABLE

Create table retail_sales
(
	transactions_id int PRIMARY KEY,
 sale_date date,
 sale_time time,
 customer_id int,
 gender varchar,
 age int,
 category varchar(20),
 quantiy int,
 price_per_unit float,
	cogs float,
 total_sale float
);

SELECT * FROM retail_sales;



----TO COUNT DATA 


select 
count (*) 
from retail_sales;

---DATA CLEANING

---find where values are null

SELECT * FROM retail_sales
WHERE 
transactions_id ISNULL
OR
sale_date ISNULL
OR
sale_time ISNULL
OR
customer_id ISNULL
OR
gender ISNULL
OR
age ISNULL
OR
category ISNULL
OR
quantiy ISNULL
OR
price_per_unit ISNULL
OR
cogs ISNULL
OR
total_sale ISNULL;

-----DELETE NULL VALUES

DELETE from retail_sales 
WHERE 
transactions_id ISNULL
OR
sale_date ISNULL
OR
sale_time ISNULL
OR
customer_id ISNULL
OR
gender ISNULL
OR
age ISNULL
OR
category ISNULL
OR
quantiy ISNULL
OR
price_per_unit ISNULL
OR
cogs ISNULL
OR
total_sale ISNULL;

----DATA EXPLORATION
---HOW MANY SALES DO WE HAVE ?



SELECT total_sale
FROM retail_sales

---count total sales 
select count(*) as total_sale from retail_sales; 

-------- How many unique customers do we have ?

select count(distinct customer_id) as total_sale from retail_sales; 
select distinct customer_id from retail_sales; 

--- how many unique catergory do we have 
select distinct category from retail_sales; 


-----DATA ANALYSIS AND BUSINESS KEY PROBLEM AND ANSWERS

--FIND ALL THE SALES MADE ON 2022-11-05
SELECT * FROM retail_sales
where (sale_date) = '2022-11-05';

----retrieve all transaction where the categoty is clothing and the quamityt sold is more then 10 in the month of november

select * from retail_sales
where category = 'Clothing'
AND TO_CHAR(sale_date, 'YYYY-MM')= '2022-11'
AND quantiy >= 4;
 
 ---- CALCULATE THE TOTAL SALES FOR EACH CATEGORY
 
 SELECT 
 category,
 sum(total_sale),
 count (*) as total_orders
 FROM retail_sales
 group by 1;
 
---find the average age of customers who purchased items from the beauty category

select 
category,
ROUND(AVG (age),2 )as age_avg
from retail_sales
where category = 'Beauty'
group by Category;

---Find all transactions wheere the total_sale is greater than 1000

select * from retail_sales
WHERE total_sale >= 1000;

----find the total number of transaction made by each gender in each category

select 
category,
gender, 
count(transactions_id)
from retail_sales 
group by 1,2
order by 1;


-----Calculate the average sale for each month and find out the best selling month
SELECT 
YEAR,
MONTH,
avg_sale
from
(
select 
EXTRACT (YEAR from sale_date) as year,
Extract (MONTH from sale_date)as month,
avg(total_sale) as avg_sale,
Rank() Over(PARTITION BY EXTRACT (YEAR from sale_date)  ORDER BY avg(total_sale) DESC)
FROM retail_sales
GROUP BY 1,2)
WHERE RANK=1;
===============
Order by 1,3 desc;

----Find the top 5 custoerm base on the highest total sales 

select customer_id, 
sum(total_sale)from retail_sales
group by 1
order by 2 desc
LIMIT 5;

------FIND THE NUMBER ROF UNIQUE CUSTOMERS WHO PURCHASED ITEMS FORM EACH CATEGORY
select category,
count(distinct customer_id) as unique_customers
from retail_sales
group by 1;


--------create each shift and number of orders example morning<=12, afternoon between 12 and 17 evening >17

select * ,
case 
WHEN EXTRACT( HOUR FROM sale_time) <12 THEN 'Morning'
WHEN EXTRACT( HOUR FROM sale_time) between 12 and 17 THEN 'Afternoon'
ELSE 'evening'
END as Shift 
FROM retail_sales;


 
 
 
 