create database capstone;
create table brands (Brand_id int,Brand_name text);
create table categories(Category_id int,Category_name text);
create table customers(Customer_id int,First_name text,Last_name text,Phone bigint,Email text,Street text,
City text,State text,Zip_code int);
create table order_items(Order_id int,Item_id int,Product_id int,Quantity int, List_price double,
Discount double,Total_price double,Product_name text,Category_id int,Category_name text);
create table orders(Order_id int,Customer_id int,Order_status int,Order_date date,Required_date date,
Shipped_date date,Store_id int,staff_id int,orderstatus text);
create table products (Product_id int,Product_name text,Brand_id int,Category_id int,Model_year int,List_price double);
create table staffs(Staff_id int,First_name text,Last_name text,Phone bigint,Email text,Phone bigint,
Active int,Store_id int,Manager_id text);
create table stocks(Store_id int,Product_id int,Quantity int);
create table stores(Store_id int,Store_name text,Phone bigint,Email text,Street text,City text,
State text,Zip_code int);

-- inner join for order details
select o.Order_id as Order_id,o.Customer_id as Customer_id,o.Order_date as Order_date,
c.Product_id as Product_id,c.Product_name as Product_name,c.Category_name as Category_name,
p.Category_id as Category_id from capstone.order_items as c
join capstone.orders as o
on o.Order_id=c.Order_id
join capstone.products as p
on c.Product_id=c.Product_id;

-- toatl sales by store
select o.Store_id as Store_id,sum(oi.Total_price) as Sales from capstone.order_items as oi
join capstone.orders as o
on oi.Order_id=o.Order_id
group by Store_id;

-- top 5 selling products
select Product_id,Product_name,sum(Quantity) as total_quantity from capstone.order_items
group by Product_id,Product_name
order by total_quantity desc
limit 5;

-- customer purchase summary
select o.Customer_id, count(oi.Order_id) as total_order,sum(oi.Total_price) as total_revanue
from capstone.orders as o
join capstone.order_items as oi
on o.Order_id=oi.Order_id
group by o.Customer_id
order by total_order,total_revanue;

-- segment customers by total spend

select o.Customer_id,sum(oi.Total_price) as total_spend,
case
when sum(oi.Total_price)<=10000 then "low"
when sum(oi.Total_price)<=35000 then "medium"
else "high"
end as customer_status
from capstone.order_items as oi
join capstone.orders as o
on o.Order_id=oi.Order_id
group by o.Customer_id;

-- Staff Performance Analysis
select s.Staff_id,sum(oi.Total_price) as toatl_revenue from capstone.orders as o
join capstone.order_items as oi
on o.Order_id=oi.Order_id
join capstone.staffs as s
on o.Staff_id=s.Staff_id	
group by s.Staff_id;

-- Stock Alert Query
select p.Product_id as product_id,sum(s.Quantity) as count_quantity,s.Store_id 
from capstone.stocks as s
join capstone.products as p
on p.Product_id=s.Product_id
group by p.Product_id,s.Store_id
having sum(s.Quantity)<10;

select * from capstone.customers;
select* from capstone.orders;
select* from capstone.order_items;

create table capstone.customer_segments(Customer_id varchar(100) primary key,Recency int,Frequency int,
Monetary decimal(12,2),Segment varchar(50));

select * from capstone.customer_segments
order by Customer_id ;				






