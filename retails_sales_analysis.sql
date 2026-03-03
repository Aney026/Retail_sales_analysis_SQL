--Creating table 


create table retails_sales (

				transactions_id INT PRIMARY KEY,
				sale_date DATE,
				sale_time TIME,
				customer_id INT,
				gender VARCHAR(15),
				age	INT,
				category VARCHAR(15),
				quantiy	INT,
				price_per_unit FLOAT,
				cogs FLOAT,
				total_sale FLOAT
)

select * from retails_sales
limit 10

select count(*)
from retails_sales

--check for null values

select * from retails_sales
where 

	sale_date is null
	or
	sale_time is null
	or 
	customer_id is null
	or
	gender is null
	or
	age is null
	or
	category is null
	or
	quantiy is null
	or
	price_per_unit is null
	or
	cogs is null
	or
	total_sale is null


--Deleting null values
	
delete from retails_sales

where 

	sale_date is null
	or
	sale_time is null
	or 
	customer_id is null
	or
	gender is null
	or
	age is null
	or
	category is null
	or
	quantiy is null
	or
	price_per_unit is null
	or
	cogs is null
	or
	total_sale is null

select count (*) from retails_sales

-- Data Exploration 

--How many sales we have ?

select count (*) as total_sales from retails_sales

-- How many unique CX we have ?

select count(distinct customer_id) as number_of_CX from retails_sales

-- Name of the categories 

select Distinct category from retails_sales

--Business Problems:-

--1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

select * from retails_sales
where sale_date = '2022-11-05'

--2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022.

select * from retails_sales
where category = 'Clothing'
	and 
	to_char(sale_date,'YYYY-MM')='2022-11'
	and
	quantiy >=4

--3 Write a SQL query to calculate the total sales for each category.

select category, sum(total_sale) as net_sale,
count(*) as total_orders
from retails_sales
group by 1

--4 Write a SQL query to find the avg age of CXs who purchased items from the 'Beautry' category.

select round(avg (age),2) from retails_sales
where category = 'Beauty'

--5 Write a SQL query to find all transactions where the total sale is greater than 1000.

select * from retails_sales
where total_sale > 1000

--6 Write a SQL query to find the total number of transactions made by each category.

select category,gender,count(*) as total_trans
from retails_sales
group by category,gender
order by 1

--7 Write a SQL query to calculate the avg sale for each month. Find out best selling month in each year.

select * from 

(
	select 
		extract(year from sale_date) as year,
		extract(month from sale_date) as month,
		avg (total_sale) as avg_sale,
		rank()over(partition by extract(year from sale_date) order by avg (total_sale) desc)
	from retails_sales
	group by 1,2
) as t1
where rank =1 

--8 Write a SQL query to find the top 5 CX based on the highest total sales

select customer_id, sum(total_sale) as total_sales
from retails_sales
group by 1
order by 2 desc
limit 5

--9 Write a SQL query to find the number of unique CX purchased items from each category.

select category,count(distinct customer_id) as unique_CX
from retails_sales
group by category

--10 Write a SQL query to create each shift and number of orders (eg: Morning <=12, Afternoon b/w 12& 17, and evening >17).

with hourly_sales
as 
(
select * ,
	case
		when extract (hour from sale_time)<12 then 'Morning'
		when extract (hour from sale_time) between 12 and 17 then 'Afternoon'
		else 'Evening'
	end as shift
from retails_sales
)
select count (*)as total_orders
from hourly_sales
group by shift

--End of project