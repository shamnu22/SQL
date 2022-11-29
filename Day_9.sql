-- Day 9
use salesdb;
select * from outlet ;

select A.outlet_id, A.outlet_type,B.outlet_id from outlet A, outlet B 
where A.outlet_type=b.outlet_type and a.outlet_id < b.outlet_id  order by a.outlet_id ;

select o1.outlet_id,o1.outlet_type,o2.outlet_id from outlet o1 inner join outlet o2 
on o1.outlet_type=o2.outlet_type where o1.outlet_id < o2.outlet_id order by o1.outlet_id;

-- to find top sales using max
select max(outlet_sales) from outlet;

-- to find top sales using order and limit
select outlet_sales from outlet order by outlet_sales desc limit 1;

select outlet_sales from outlet order by outlet_sales desc limit 2;

select outlet_sales from outlet limit 10;
select outlet_sales from outlet order by outlet_sales desc limit 1;
select * from outlet order by outlet_id limit 5,1;

-- get top sales using subquery
select outlet_sales from outlet where outlet_sales = (select max(outlet_sales) from outlet);

select * from outlet where outlet_sales > (select avg(outlet_sales) from outlet);
select avg(outlet_sales) from outlet;
select outlet_sales from outlet where outlet_sales > 1688.50;

select * from outlet where outlet_sales < (select avg(outlet_sales) from outlet);
-- get 3 lowest perform outlets than the avg sales
select outlet_id,outlet_sales from outlet where outlet_sales < (select avg(outlet_sales) from outlet) 
order by outlet_sales, outlet_id limit 3;

select outlet_id, outlet_sales from outlet order by outlet_sales, outlet_id limit 3;

-- using multiple tables in the subquery
-- find outlets selling products with mrp more than 50
select * from outlet where outlet_id in (select outlet_id from items where item_mrp > 50);
show tables;
-- create table using existing tables (without providing structural details)
create table performers as select * from outlet where 1=1;

select * from performers;
delete from performers;
-- insert using multiple/other tables along with subquery
insert into performers ( select * from outlet where outlet_sales > (select avg(outlet_sales) from outlet));
show tables;
drop table performers;
create table performers as select * from outlet where outlet_sales > (select avg(outlet_sales) from outlet);

alter table performers add column remarks varchar(50);
-- update using multiple/other tables along with subquery
update performers set remarks = 'give 5% bonus to their employees' where outlet_id in 
(select outlet_id from outlet where outlet_sales = (select max(outlet_sales) from outlet));
select * from performers;

-- sample update using one table outlet only 
-- update employee set first_name = 'Johny' where first_name = ' Bob ';

-- delete using multiple/different/other tables along with subquery
delete from performers where outlet_id in 
(select outlet_id from outlet where outlet_sales < (select max(outlet_sales) from outlet));
select * from performers;
-- views (virtual table)
-- base table: outlet 
-- drop view outlet_gtavg ;
create view outlet_gtavg as select outlet_id from outlet where outlet_sales > (select avg(outlet_sales) from outlet);
create view outlet_ltavg as select outlet_id from outlet where outlet_sales < (select avg(outlet_sales) from outlet);
show tables;
select * from outlet_gtavg ;
select * from outlet_ltavg ;

select avg(outlet_sales) from outlet















