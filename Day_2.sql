show databases;

use world;

show tables;

/*
DDL = Create, alter, drop
DML = insert, update, delete
DQL = select 
DCL = grant, revoke
TCL = commit, rollback
*/

-- database creation
create database salesdb;
drop database salesdb;
show databases;
create database if not exists salesdb;

-- database deletion
drop database salesdb;
show databases;

-- table creation
use salesdb;
select database(); -- to check what db are we using

-- table creation
create table outlet (outlet_id int, outlet_type varchar(5), outlet_sales numeric);
show tables;

-- table deletion
drop table outlet;

-- describe the table
describe outlet;


-- data addition
insert into outlet values (101, 'mart', 500);
insert into outlet values (102, 'supermarket', 5000);
insert into outlet(outlet_id, outlet_type) values (103, 'supermarket');
insert into outlet(outlet_id, outlet_type) values (104, 'supermarket');
insert into outlet(outlet_id, outlet_type) values (105, 'supermarket');

-- display data
select * from outlet;

-- table modification
alter table outlet modify outlet_type varchar(15);
describe outlet;
alter table outlet modify outlet_sales numeric default 10;
alter table outlet modify outlet_id int primary key;
-- table data modification
update outlet set outlet_sales = 10000 where outlet_id = 103;
update outlet set outlet_sales = 6000 where outlet_id = 104;

-- table data deletion/remove the data
delete from outlet where outlet_id = 105;

-- drop table
-- drop table outlet;

use world;
show tables;
describe outlet;



select * from outlet;
select outlet_type from outlet;
select outlet_id,outlet_type from outlet;

select count(*) from outlet; -- fetch total rows
select count(*) as "row_count" from outlet; -- fetch total rows

select sum(outlet_sales) from outlet;
select * from outlet;

select sum(outlet_sales) from outlet where outlet_type = 'mart';

select sum(outlet_sales) from outlet where outlet_type = 'supermarket';

select * from outlet where outlet_type = 'mart';

select * from outlet where outlet_sales < 5000;
select * from outlet where outlet_sales = 5000;
select * from outlet where outlet_sales > 5000;

select * from outlet where outlet_sales between 500 and 2000;

select * from outlet where outlet_id = 106;
select * from outlet where outlet_sales between 500 and 5000 and outlet_type ='mart';

select * from outlet order by outlet_sales;
select * from outlet order by outlet_sales desc;

select * from outlet;
