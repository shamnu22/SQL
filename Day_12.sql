
-- Day 12
use salesdb;
select outlet_sales from outlet order by outlet_sales ;
select * from outlet order by outlet_id desc;

-- before trigger is created
insert into outlet values (117, 'stall', -100);
select outlet_sales from outlet order by outlet_sales ;


delimiter &&
create trigger chg_negto0
before insert on outlet for each row
begin
if new.outlet_sales <0 then
	set new.outlet_sales = 0;
end if;
end &&
delimiter ;


delimiter &&
create trigger chg_maxto20k
before insert on outlet for each row
begin
if new.outlet_sales >20000 then
	set new.outlet_sales = 20000;
end if;
end &&
delimiter ;


-- after trigger is created
insert into outlet values (118, 'mart', -99);
select * from outlet order by outlet_id desc;

-- before trigger chg_maxto20k is created
insert into outlet values (119, 'mart', 30000);
select * from outlet order by outlet_id desc;

-- after trigger chg_maxto20k is created
insert into outlet values (120, 'stall', 40000);
select * from outlet order by outlet_id desc;

show tables

-- select * from suboutlet;

 
delimiter &&
create trigger chg_maxto20kaffsubtbl
after insert on outlet for each row
begin
	insert into out_aff_ins values (new.outlet_id, new.outlet_type, new.outlet_sales);
end &&
delimiter ; 
drop trigger chg_maxto20kaffsubtbl;

delimiter &&
create trigger delaffsubtbl
after delete on outlet for each row
begin
	delete from out_aff_ins where outlet_id = old.outlet_id;
end &&
delimiter ;
drop trigger delaffsubtbl;
/* -- before delete
select * from outlet where outlet_id = 125;
--	125	stall	2000
select * from out_aff_ins where outlet_id = 125;
--	125	stall	2000
    
delete from outlet where outlet_id = 125;

-- after delete
select * from outlet where outlet_id = 125
-- no rows */
/* select * from out_aff_ins where outlet_id = 125;
no rows */


 show databases;
show tables; 

select * from empdb.employee; 

use salesdb;
select * from outlet;

-- after trigger chg_maxto20kaffsubtbl is created
insert into outlet values (123, 'grocery', 50000);
select * from outlet order by outlet_id desc;
select * from suboutlet order by outlet_id desc;
insert into outlet values (124, 'stall', 3000);

insert into outlet values (125, 'stall', 2000);

select * from outlet; 
select count(*) from outlet; -- 22 rows

select * from out_aff_ins; 
delete from out_aff_ins ;


create table out_aff_ins as select * from outlet; -- all records -- out_aff_ins -- 22 rows
select count(*) from out_aff_ins ; -- 22
drop table out_aff_ins ;

create table out_aff_ins as select * from outlet where outlet_id = 101 ; -- out_aff_ins -- 1 rows (101) -- true condition (matching)
select count(*) from out_aff_ins ; -- 1
drop table out_aff_ins ;

create table out_aff_ins as select * from outlet where outlet_id = -111 ; -- out_aff_ins -- empty rows -- false condition (not matching)
select count(*) from out_aff_ins ; -- 0

drop table out_aff_ins ;
create table out_aff_ins as select * from outlet where 1=2; -- out_aff_ins -- empty rows -- false condition (not matching)
select * from out_aff_ins ;
select count(*) from out_aff_ins ; -- 0

drop table out_aff_ins ;


create table out_aff_ins as select * from outlet where 124=124; -- out_aff_ins -- non-empty rows -- 
--- equivalent to
create table out_aff_ins as select * from outlet; -- out_aff_ins -- non-empty rows -- 

select * from out_aff_ins ;
select count(*) from out_aff_ins ; -- 22


-- without any column reference in where clause
/* 1=1  match/true			create table out_aff_ins as select * from outlet where True - all rows
1=2  notmatch/false		create table out_aff_ins as select * from outlet where false - no rows
100=99 notmatch/false	create table out_aff_ins as select * from outlet where false - no rows
100=100 match/true		create table out_aff_ins as select * from outlet where True  - all rows 

-- refering a column in where clause
column ( outlet_id = 101) match/true	create table out_aff_ins as select * from outlet where True - 1 row (rows eq 101)
column ( outlet_id = -111) nomatch/false create table out_aff_ins as select * from outlet where false - no rows

a = 100
if a = 100 then "pass"
if a <> 100 then "fail"
pass
fail 
*/




 