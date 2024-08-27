use pizza_runner;
-- Customer orders table cleaning and formatting --
select * from customer_orders;

create table pizza_runner.customer_orders1
like pizza_runner.customer_orders;

insert  pizza_runner.customer_orders1
select * from customer_orders;

select * from customer_orders1;

-- Identifying and removing duplicates 
select *,
row_number() over(partition by order_id, pizza_id) as row_num
from customer_orders1;

CREATE TABLE `customer_orders2` (
  `order_id` int DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  `pizza_id` int DEFAULT NULL,
  `exclusions` varchar(10) DEFAULT NULL,
  `extras` varchar(10) DEFAULT NULL,
  `order_time` timestamp NULL DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert customer_orders2
select *,
row_number() over(partition by order_id, pizza_id) as row_num
from customer_orders1;

select * from  customer_orders2;

delete 
from customer_orders2
where row_num > '1';

-- Handling nulls and blanks 
select *
from  customer_orders2;

select *
from  customer_orders2
where exclusions = 'null'
or exclusions = '';

update customer_orders2
set exclusions = 'null'
where exclusions = '';

select * from customer_orders2;

select *
from  customer_orders2
where extras = 'null'
or extras = '';

update customer_orders2
set extras = 'null'
where extras = '';

select *
from customer_orders2
where extras is null
or extras = '';

update customer_orders2
set extras = 'null'
where extras is null;

select * from customer_orders2;

-- Data standardization
select *
from customer_orders2;

select date(order_time) as order_date,
time(order_time) as orders_time
from customer_orders2;

CREATE TABLE `customers_orders` (
  `order_id` int DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  `pizza_id` int DEFAULT NULL,
  `exclusions` varchar(10) DEFAULT NULL,
  `extras` varchar(10) DEFAULT NULL,
  `order_time` timestamp NULL DEFAULT NULL,
  `row_num` int DEFAULT NULL,
  `order_date` date,
  `orders_time` time
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert customers_orders
select *,
date(order_time) as order_date,
time(order_time) as orders_time
from customer_orders2;

select * from customers_orders;

-- Removing column not needed 
alter table customers_orders
drop column order_time;

select * from customers_orders;

-- Runner Orders table cleaning and formatting --
select * from runner_orders;

create table runner_orders1
like runner_orders;

insert runner_orders1
select *
from runner_orders;

-- Handling null and blanks
select cancellation
from runner_orders
where cancellation is null 
or cancellation = '';

update runner_orders
set cancellation = 'null'
where cancellation is null 
or cancellation = '';

select * from runner_orders;

-- Data standardization
select *, case when distance like '%km' then trim(replace(distance, 'km', '')) 
else distance end 
from runner_orders;

update runner_orders
set distance = case when distance like '%km' then trim(replace(distance, 'km', '')) 
else distance end;

select * from runner_orders;

select *, case when duration like '%min%' then left(duration, 2)
else duration end 
from runner_orders;

update runner_orders
set duration = case when duration like '%min%' then left(duration, 2)
else duration end;

select *, date(pickup_time),
time(pickup_time)
from runner_orders;

update runner_orders 
set pickup_time = null
where pickup_time ='null';

alter table runner_orders
modify column pickup_time timestamp;

select date(pickup_time) as pickup_date,
time(pickup_time) as pickuptime
from runner_orders;

CREATE TABLE `runner_orders2` (
  `order_id` int DEFAULT NULL,
  `runner_id` int DEFAULT NULL,
  `pickup_time` timestamp NULL DEFAULT NULL,
  `distance` varchar(30) DEFAULT NULL,
  `duration` varchar(30) DEFAULT NULL,
  `cancellation` varchar(30) DEFAULT NULL,
  `pickup_date` date,
  `pickuptime` time
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert runner_orders2
select *, date(pickup_time) as pickup_date,
time(pickup_time) as pickuptime
from runner_orders;

select *
from runner_orders2;

update runner_orders2 
set distance = null
where distance ='null';

alter table runner_orders2
modify column distance int;

update runner_orders2
set duration = null
where duration ='null';

alter table runner_orders2
modify column duration int;

-- Removing column not needed
alter table runner_orders2
drop column pickup_time;

select *
from runner_orders2;







