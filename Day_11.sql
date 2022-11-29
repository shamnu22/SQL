-- Day 11
use salesdb;
select * from outlet;
select * from outlet order by outlet_sales desc;

select * from 
(select outlet_id,outlet_type,outlet_sales,rank() over (order by outlet_sales desc) as rnk from outlet)g
where g.rnk = 2;

select * from outlet where outlet_sales in (select outlet_sales from outlet ) order by outlet_sales desc limit 1;
select * from outlet o2 where 3 = 
(select count(distinct o1.outlet_sales) from outlet o1 where o2.outlet_sales <= o1.outlet_sales);

create table suboutlet as select * from outlet where outlet_sales > 500;
select * from suboutlet ;

select database();

-- find low sales
select * from outlet where outlet_sales < 100;

-- procedure - to execute a set of statments together in a single call

-- creating a procedure
delimiter && 
create procedure low_sales()
begin
select * from outlet where outlet_sales < 100;
select 'hi';
select 'bye';
end &&
delimiter ;

-- calling a procedure
call low_sales;
-- deleting a procedure
drop procedure low_sales;
-- create 
delimiter && 
create procedure find_sales(in xyz int, out osales int) -- xyz = 102, osales = 5000
begin
select outlet_sales from outlet where outlet_id = xyz;
select item_mrp  from items where outlet_id = xyz;
end &&
delimiter ;

call find_sales(117,@osales);
drop procedure find_sales;
select * from outlet where outlet_id = 102;
select * from items;

select outlet_sales from outlet where outlet_id = 101;
select item_mrp  from items where outlet_id = 101;

delimiter && 
create procedure find_nth(in xyz int, out abc int) -- xyz = 102, osales = 5000
begin
select o1.outlet_sales from outlet o1 where xyz = 
(select count(distinct o2.outlet_sales) from outlet o2 where o1.outlet_sales <= o2.outlet_sales);
end &&
delimiter ;

call find_nth(1,@abc);

call find_nth(1,@osales);
call find_nth(2,@osales);
call find_nth(3,@osales);


select outlet_sales from outlet where outlet_id = 102;
/* input = outlet_id (102) - in
output = oulet_sales (5000) - out */

-- create function <function name> (input parametername parameter datatype)
create function get_sales10pct(pct10 decimal)
returns decimal no sql -- reads sql data
return pct10*.1;

create function myname(a varchar(100))
returns varchar(100) no sql -- reads sql data
return concat("My name is ",a) ;

select concat("samsung","mobile");
select myname("samsung");

select myname("Abra"), myname("Bala");

create function mysqr(a decimal)
returns decimal no sql -- reads sql data
return a*a;

select mysqr(2), mysqr(3), mysqr(4), mysqr(5);

-- create function <function name> (input parametername parameter datatype)
delimiter && 
create function get_sales10pct2(pct10 decimal)
returns decimal no sql -- reads sql data
begin
declare xyz decimal;
set xyz = pct10*.1;
return xyz;
end &&
delimiter ;
drop function get_sales10pct2;

select outlet_sales, get_sales10pct2(outlet_sales) from outlet;

create function shamnu(efg decimal)
returns decimal no sql -- reads sql data
return efg*.1;

select shamnu(990);
select outlet_sales, shamnu(outlet_sales) from outlet;
select max(outlet_sales) from outlet;

delimiter && 
create function get_max()
returns decimal reads sql data
begin
declare os decimal;
select max(outlet_sales) into os from outlet;
return os;
end &&
delimiter ;

select get_max();

create function get_max_wointo()
returns decimal reads sql data
return (select max(outlet_sales) from outlet);

select get_max_wointo();


create function get_max_wointo_wparam(s decimal)
returns decimal reads sql data
return (select max(outlet_sales) from outlet where outlet_sales < s);

select get_max_wointo_wparam(550);
select get_max_wointo_wparam(100);

select * from outlet;
select max(outlet_sales) from outlet where outlet_sales < 100;
select outlet_sales from outlet where outlet_sales < 100;

