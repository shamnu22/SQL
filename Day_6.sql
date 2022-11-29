select database();
use salesdb;

select departement, joining_date, salary from employee;
/*
Banking		2019-02-05	8900000
Insurance	2019-02-25	2000000
Finance		2019-02-28	2200000
*/
select departement, month(joining_date), sum(salary) from employee 
where month(joining_date) = 2 group by departement ;
select departement, sum(salary) from employee 
where month(joining_date) = 2 group by departement ;
/*
Banking		2	8900000
Insurance	2	2000000
Finance		2	2200000
*/

use empdb;
select * from employee where trim(first_name) <> 'Jerry' and
trim(first_name) not like '%John%' and trim(first_name) like '%_n%';
select * from employee ;
select departement, count(employee_id) from employee group by departement;
update employee set first_name = 'Johny' where first_name = ' Bob ';
select * from employee where trim(first_name) like '%_n'; --  _ is for one char ' '
select * from employee where trim(first_name) like '%_n%'; -- % is for many characters '....' 1 to n

-- ---n -> total length of 4 letters ending with 'n' -->john
-- %n ->  total length has no limit but ending with 'n --> john, yohan

select quarter(joining_date), month(joining_date), count(employee_id) from employee 
group by quarter(joining_date), month(joining_date);
select * from employee ;
/*
Q1 jan - 2 
Q1 feb - 3
Q2 may - 1
Q2 jun - 1
*/

select Joining_date, count(Employee_id), quarter(Joining_date) from Employee 
group by quarter(Joining_date),Joining_date;

-- select sum(), max(), min(), count(), sum();

use salesdb;
select * from outlet;
desc outlet;
select * from items;
drop table items ;

create table items ( item_id char(5) primary key, item_name varchar(20), item_wt decimal(7,2), 
item_mrp decimal(10,2), outlet_id int, 
foreign key (outlet_id) references outlet(outlet_id));

create table items ( item_id char(5) primary key, item_name varchar(20), item_wt decimal(7,2), 
item_mrp decimal(10,2), outlet_id int);

desc items;

insert into items values ('FDA01', 'can', 15, 59.00,101);
insert into items values ('FDA02', 'fruits', 150, 9.00,101);
insert into items values ('FDA03', 'fruits', 150, 9.00,117);
select * from items;


create table items ( item_id char(5) primary key, item_name varchar(20), 
item_wt decimal(7,2), item_mrp decimal(10,2), outlet_id int);

select * from items;
select * from outlet;

select count(*) from items;
select count(*) from outlet;


select A.id, A.type, B.id, B.sales from A inner join B on A.id = B.id;

select A.id, A.type, C.id, C.location from A inner join C on A.id = C.id;
select A.id, A.type, C.id, C.location from A inner join C on A.id = C.oid;
select A.*,B.*,C.* from A, B, C where A.id = B.id and A.id = C.oid;

select outlet.*, items.* from outlet inner join items on outlet.outlet_id = items.outlet_id;
/*
FDA01	can		15.00	59.00	101		101	MART	500
FDA02	fruits	150.00	9.00	101		101	MART	500 */

select outlet.outlet_type, outlet.outlet_id, items.item_wt from outlet inner join
items on outlet.outlet_id = items.outlet_id;

select outlet_type from outlet;

select outlet.*, items.* from outlet left outer join items on outlet.outlet_id = items.outlet_id;

select outlet.*, items.* from outlet inner join items on outlet.outlet_id = items.outlet_id;
select outlet.*, items.* from outlet right outer join items on outlet.outlet_id = items.outlet_id;
select outlet.*, items.* from outlet left outer join items on outlet.outlet_id = items.outlet_id;

select outlet.*, items.* from outlet inner join items;
items = 3
outlet = 17 

-- another option for joins
select outlet.*, items.* from outlet inner join items on outlet.outlet_id = items.outlet_id;
select outlet.*, items.* from outlet inner join items where outlet.outlet_id = items.outlet_id;
select outlet.*, items.* from outlet, items where outlet.outlet_id = items.outlet_id;
select * from outlet join items using (outlet_id);
select o.*, i.* from outlet o inner join items i on o.outlet_id = i.outlet_id;




