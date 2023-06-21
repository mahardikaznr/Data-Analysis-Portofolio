/*case 1*/
select region, case when age < 36 then 'Less than 36 Years'
					when age > 54 then 'Above 54 Years'
					else 'Between 36 and 54 Years' end as Age_group,
		count(customer_id) as Total_Customer from customer
group by Region, Age_Group
order by Region, Age_Group;		

/*case 2*/
-- Top 5 Selling Product in East Region
select
	p.product_id,
	p.product_name,
	sc.region as region,
	sum(sc.quantity) as total_sold
from product as p
right join (select s.*, c.*
			   	from sales as s
			   	left join customer as c
			   	on s.customer_id = c.customer_id) as sc
on p.product_id = sc.product_id
where region = 'East'
group by p.product_id, p.product_name, region
order by total_sold desc limit 5;

--5 least selling product in South Region
select
	p.product_id,
	p.product_name,
	sc.region as region,
	sum(sc.quantity) as total_sold
from product as p
right join (select s.*, c.*
			   	from sales as s
			   	left join customer as c
			   	on s.customer_id = c.customer_id) as sc
on p.product_id = sc.product_id
where region = 'South'
group by p.product_id, p.product_name, region
order by total_sold limit 5;

/*case 3*/
--Total revenue loss due to discount
select sum(sales*discount) as Total_Revenue_Loss_due_Disc from sales;

--Total Revenue and Discount for Each Product
select 
	s.product_id,
	p.product_name,
	sum(s.sales*s.discount) as Total_Discount,
	sum(s.sales) - sum(s.sales*s.discount) as Total_Revenue
from sales as s
left join product as p
on s.product_id = p.product_id
group by p.product_name, s.product_id
order by s.product_id;