create database Pizza_DB

select * from pizza_sales

-- 1. Total Revenue

select sum(total_price) as Total_Revenue from pizza_sales

-- 2. Average Order Value

select SUM(total_price) / COUNT(distinct order_id) as Average_Order_Value from pizza_sales

-- 3. Total Pizza Sold

select SUM(quantity) Total_Pizza_Sold from pizza_sales

-- 4. Total Orders Placed

select COUNT(distinct order_id) as Total_Orders from pizza_sales

-- 5. Average Pizzas Per Order

Select cast(SUM(quantity) as decimal(10,2)) / 
CAST(COUNT(distinct order_id) as decimal(10,2)) 
as Average_Pizzas_Per_Order from pizza_sales

-- 5.1 If you want to add decimals in output

select CAST(
CAST(SUM(quantity) as decimal(10,2)) / 
CAST(count(distinct order_id) as decimal (10,2))
as decimal(10,2))
as Average_Pizzas_Per_Order from pizza_sales

-- 6. Daily Trend for Total Orders

select DATENAME(DW, order_date) as Order_Day, COUNT(distinct order_id) as Total_Orders
from pizza_sales
group by Datename(DW, Order_date)

-- 7. Monthly Trend for Total Orders

select DATENAME(MONTH, order_date) as Month_Name, COUNT(distinct order_id) as Total_Orders
from Pizza_sales
group by DATENAME(MONTH, order_date)
order by Total_Orders desc

-- 8. Percentage of Sales by Pizza Category 

select pizza_category, SUM(total_price) * 100 / (select SUM(total_price) from pizza_sales)  as Percentage_of_Sales
from pizza_sales
group by pizza_category

-- 8.1 If you want to add Total sales column in output

select pizza_category, SUM(total_price) as Total_Sales, 
SUM(total_price) * 100 / (select SUM(total_price) from pizza_sales)  as Percentage_of_Sales
from pizza_sales
group by pizza_category

-- 8.2 If you want to filtter by month of Jan

select pizza_category, SUM(total_price) as Total_Sales, 
SUM(total_price) * 100 / (select SUM(total_price) from pizza_sales where MONTH(order_date) = 1)  as Percentage_of_Sales
from pizza_sales
where MONTH(order_date) = 1
group by pizza_category


-- 8.3 If you want to filtter by Quarter

select pizza_category, SUM(total_price) as Total_Sales, 
SUM(total_price) * 100 / (select SUM(total_price) from pizza_sales where DATEPART(QUARTER, order_date) = 1)  as Percentage_of_Sales
from pizza_sales
where DATEPART(QUARTER, order_date) = 1
group by pizza_category

-- 9. Percentage of Sales by Pizza Size 

select pizza_size, SUM(total_price) as Total_Sales, 
SUM(total_price) * 100 / (select SUM(total_price) from pizza_sales)  as Percentage_of_Sales
from pizza_sales
group by pizza_size

-- 9.1 If you want output will be in ascending order

select pizza_size, SUM(total_price) as Total_Sales, 
SUM(total_price) * 100 / (select SUM(total_price) from pizza_sales)  as Percentage_of_Sales
from pizza_sales
group by pizza_size
order by Percentage_of_Sales

-- 9.2 If you want output will be in descending order

select pizza_size, SUM(total_price) as Total_Sales, 
SUM(total_price) * 100 / (select SUM(total_price) from pizza_sales)  as Percentage_of_Sales
from pizza_sales
group by pizza_size
order by Percentage_of_Sales desc

-- 9.3 If you want output will be in two decimal points

select pizza_size, CAST(SUM(total_price) as decimal(10,2)) as Total_Sales, 
CAST(SUM(total_price) * 100 / (select SUM(total_price) from pizza_sales) as decimal(10,2))  
as Percentage_of_Sales
from pizza_sales
group by pizza_size
order by Percentage_of_Sales desc

-- 10. Top 5 Best Sellers by Revenue

select top 5 pizza_name, SUM(total_price) as Total_Revenue from pizza_sales
group by pizza_name 
order by Total_Revenue desc

-- 10.1 If you want last 5 or bottom 5 Pizza by Revenue

select top 5 pizza_name, SUM(total_price) as Total_Revenue from pizza_sales
group by pizza_name 
order by Total_Revenue asc 

-- 11. Top 5 Best Sellers by Total Quantity

select top 5 pizza_name, SUM(quantity) as Total_Quantity from pizza_sales
group by pizza_name 
order by Total_Quantity desc

-- 11.1 If you want last 5 or bottom 5 Pizza by Quantity

select top 5 pizza_name, SUM(quantity) as Total_Quantity from pizza_sales
group by pizza_name 
order by Total_Quantity asc

-- 12. Top 5 Best Sellers by Total Orders 

select top 5 pizza_name, COUNT(distinct order_id) as Total_Orders from pizza_sales
group by pizza_name 
order by Total_Orders desc

-- 12.1 If you want last 5 or bottom 5 Pizza by Total Orders

select top 5 pizza_name, COUNT(distinct order_id) as Total_Orders from pizza_sales
group by pizza_name 
order by Total_Orders asc