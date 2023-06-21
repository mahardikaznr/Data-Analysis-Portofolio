--List of all cities where the region is South or east without any duplicates using IN statement
select distinct city from customer 
	where region in ('East','South');

--List of all orders where the ‘sales’ value is between 100 and 500 using the BETWEEN operator
select * from sales
	where sales between 100 and 500;

--List of customers whose last name contains only 4 characters using LIKE
select * from customer
	where customer_name like '% ____';

/* Retrieve all orders where ‘discount’ value is greater than zero
ordered in descending order basis ‘discount’ value*/
select * from sales
	where discount>0 order by discount desc;

--Limit the number of results in above query to top 10
select * from sales
	where discount>0 order by discount desc limit 10;
	
--Sum of all ‘sales’ values.
select sum(sales) from sales;

--Count of the number of customers in north region with age between 20 and 30
select count(customer_id) from customer
	where age between 20 and 30;
	
--average age of East region customers
select avg(age) from customer
	where region = 'East';

--Minimum and Maximum aged customer from Philadelphia
select min(age) as min_age, max(age) as max_age from customer
	where city = 'Philadelphia';
	
--Make a dashboard showing the following figures for each product ID
select  sum(sales) as "Total sale",
		sum(quantity) as "Sales Quantity",
		count(order_id) as "Number of Orders",
		max(sales) as "Max Sales Value",
		min(sales) as "Min Sales Value",
		avg(sales) as "Average Sales Value"
from sales group by product_id order by "Total sale";

--List of product ID’s where the quantity of product sold is greater than 10
select product_id, sum(quantity) as "Total quantity" from sales
	group by product_id having sum(quantity) > 10; 

--creating tables with as
create table sales_2015 as select * from sales where ship_date between '2015-01-01' and '2015-12-31';
create table customer_20_60 as select * from customer where age between 20 and 60;

--total sales done in every state for customer_20_60 and sales_2015 table
select
	cust.state, sum(sales) as total_sales
	from sales_2015 as s left join customer_20_60 as cust on s.customer_id = cust.customer_id
	group by cust.state;

/*Get data containing Product_id, product name, category, total sales value of 
that product and total quantity sold. (Use sales and product table) */
select
	p.product_id,
	p.product_name,
	p.category,
	sum(s.sales) as total_sales,
	sum(s.quantity) as total_sold
from product as p
left join sales as s
on p.product_id = s.product_id
group by p.product_id;

/*Get data with all columns of sales table, and customer name, customer 
age, product name and category are in the same result set.*/
select c.customer_name,c.age,sp.*
	from customer as c
	right join (select s.*, p.product_name, p.category
			   	from sales as s
			   	left join product as p
			   	on s.product_id = p.product_id) as sp
	on c.customer_id = sp.customer_id;

create view Daily_Billing as
	select order_line, product_id, sales, discount from sales
	where order_date in (select max(order_date) from sales);

drop view Daily_Billing;