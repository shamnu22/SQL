-- Zia bai Excercise Line 171	
-- Day 13
use salesdb;
select * from outlet;
-- 101	MART

-- 101 MART 31500
select outlet_type, sum(outlet_sales) from outlet group by outlet_type;
/* MART		31500
supermarket	21000
grocery		40700
stall		23020
			319
       */     
-- below is incorrect
select outlet_id, outlet_type, sum(outlet_sales) as type_sum from outlet group by outlet_type;

select count(*) from outlet o,
(select outlet_type, sum(outlet_sales) as type_sum from outlet group by outlet_type) g;
select * from outlet;

/* select count(*) from outlet; -- 22
select count(*) from outlet group by outlet_type -- 5 */
-- 22 * 5 = 100

select * from outlet o,
(select outlet_type, sum(outlet_sales) as type_sum from outlet group by outlet_type) g
where o.outlet_type = g.outlet_type;

select * from outlet o,
(select outlet_type, sum(outlet_sales) as type_sum from outlet group by outlet_type) g
where o.outlet_id = i.outlet_id;

-- select * from outlet o, items i -- cross join or outer join


-- inline table (use query as a table)
-- to get total sales of the outlettype belonging to the outlet_id's type
select o.outlet_id, o.outlet_type,g.type_sum from outlet o,
(select outlet_type, sum(outlet_sales) as type_sum from outlet group by outlet_type) g
where o.outlet_type = g.outlet_type;

-- to get total sales of the outlettype belonging to the outlet_id's type (includes null outlet_type)
select o.outlet_id, o.outlet_type, ifnull(o.outlet_type,'unk') as 'new_type', g.type_sum from outlet o,
(select outlet_type, sum(outlet_sales) as type_sum from outlet group by outlet_type) g
where ifnull(o.outlet_type,'unk') = ifnull(g.outlet_type,'unk');

-- to get total maximum sales of the outlettype belonging to the outlet_id's type
select * from outlet;
	
select o.outlet_id, o.outlet_type, ifnull(o.outlet_type,'unk') as 'new_type', g.type_sum from outlet o,
(select outlet_type, max(outlet_sales) as type_sum from outlet group by outlet_type) g
where ifnull(o.outlet_type,'unk') = ifnull(g.outlet_type,'unk') order by o.outlet_id;

select * from outlet o, 
(select outlet_type, sum(outlet_sales) as type_sum , avg(outlet_sales) as type_avg, min(outlet_sales) as type_min, max(outlet_sales) as type_max
from outlet group by outlet_type) g
where ifnull(o.outlet_type,'unk') = ifnull(g.outlet_type,'unk') order by o.outlet_id;

select distinct outlet_type from outlet;

select outlet_type, sum(outlet_sales) from outlet group by outlet_type;

-- convert rows into columns
/* col1		col2
----		----
MART		31500
supermarket	21000
grocery		40700
stall		23020
unknown		319
            
mart	supermarket grocery stall 	unknown
31500	21000		40700	23020	319 */

select 
sum(case when outlet_type = 'mart' then outlet_sales else null end) as "mart",
sum(case when outlet_type = 'supermarket' then outlet_sales else null end) as "supermarket",
sum(case when outlet_type = 'grocery' then outlet_sales else null end) as "grocery",
sum(case when outlet_type = 'stall' then outlet_sales else null end) as "stall",
sum(case when outlet_type is null then outlet_sales else null end) as "unknown"
 from outlet;
select 
avg(case when outlet_type = 'mart' then outlet_sales else null end) as "mart",
avg(case when outlet_type = 'supermarket' then outlet_sales else null end) as "supermarket"
 from outlet;
 
 select outlet_type, count(outlet_sales) from outlet group by outlet_type;
/*  MART		4
supermarket	3
grocery		4
stall		6
			4 */
            use salesdb;
 select 
count(case when outlet_type = 'mart' then outlet_sales else null end) as "mart",
count(case when outlet_type = 'supermarket' then outlet_sales else null end) as "supermarket",
count(case when outlet_type = 'grocery' then outlet_sales else null end) as "grocery",
count(case when outlet_type = 'stall' then outlet_sales else null end) as "stall",
count(case when outlet_type is null then outlet_sales else null end) as "unknown"
 from outlet;
 -- using 5 case statement for each outlet type
 select 
count(case when outlet_type = 'mart' then outlet_sales else null end) as "col1",
count(case when outlet_type = 'supermarket' then outlet_sales else null end) as "col2",
count(case when outlet_type = 'grocery' then outlet_sales else null end) as "col3",
count(case when outlet_type = 'stall' then outlet_sales else null end) as "col4",
count(case when outlet_type is null then outlet_sales else null end) as "col5"
 from outlet;

select outlet_type, count(outlet_sales) from outlet group by outlet_type having outlet_type='mart';
select count(case when outlet_type = 'mart' then outlet_sales else null end) as "mart" from outlet;

select * from outlet;
	
--- using window function 
-- for cumulative query
select outlet_id, outlet_type, outlet_sales, sum(outlet_sales) over (order by outlet_id) as running_total from outlet;

select  outlet_id, outlet_type, sum(outlet_sales) from outlet group by outlet_type;

-- select outlet_id, outlet_type, outlet_sales, sum(outlet_sales) over (group by outlet_type) from outlet;
select outlet_id, outlet_type, outlet_sales, sum(outlet_sales) over (partition by outlet_type) as total_sum from outlet
order by outlet_id;

select outlet_id, outlet_type, outlet_sales, sum(outlet_sales) over (partition by outlet_type) as total_sum,
avg(outlet_sales) over (partition by outlet_type) as total_avg
from outlet order by outlet_id;

-- select row_number() over (partition by outlet_type), outlet_type, outlet_sales as type_row from outlet

select * from 
(select outlet_id, outlet_type, outlet_sales, rank() over (order by outlet_sales desc) as "rnk" from outlet)  o 
where o.rnk = 1;

select * from 
(select outlet_id, outlet_type, outlet_sales, dense_rank() over (order by outlet_sales desc) as "rnk" from outlet)  o 
where o.rnk = 2;
select * from
(select outlet_id, outlet_type, outlet_sales, rank() over (order by outlet_sales desc) as "rnk",
dense_rank() over (order by outlet_sales desc) as "dense_rnk" 
 from outlet)o;

-- below will not work
/*
select outlet_id, outlet_type, outlet_sales, rank() over (order by outlet_sales desc) 
from outlet order by outlet_id;*/

select * from outlet ;
select * from items;

select * from outlet o inner join items i on o.outlet_id = i.outlet_id;
-- give all records from the left + matching in the right
select * from outlet o left join items i on o.outlet_id = i.outlet_id ;
select count(*) from outlet o ;
select count(*) from items i;
select count(*) from outlet o left join items i on o.outlet_id = i.outlet_id ;
select count(*) from outlet o right join items i on o.outlet_id = i.outlet_id ;

-- cross join or full outer join are same (product - times x * y times) need to verify
