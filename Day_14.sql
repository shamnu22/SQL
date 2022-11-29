-- Day 14
--  Find the highest salary of odd weeks of the year on joining_date
show tables;
use inventory;
select * from employee;
select * from employee where salary in (select max(salary) from employee where week(joining_date) % 2 <> 0);
select max(salary) from employee where week(joining_date) % 2 = 0;
-- even
select max(salary) from employee where week(joining_date)%2=0;
select max(salary) from employee where week(joining_date)%2<>0;

select joining_date, week(joining_date), week(joining_date)%1, week(joining_date)%2, salary from employee;

-- using case
select max(case day(joining_date)%2 when 1 then salary else null end) as "odd" from employee;
select max(
	case 
	day(joining_date)%2 when 1 then salary 
    else null end) as "odd" 
from employee;
select max(
	case when day(joining_date)%2 = 1 then salary 
    else null end) as "odd" 
from employee;
    
select max(case when day(joining_date)%2 = 0 then salary else null end) as "even" from employee;

-- 9. Find week of the month for each joining_date
select joining_date, salary from employee;
use empdb;
select joining_date, salary,
day(joining_date), concat(year(joining_date),'-',month(joining_date),'-','01') 'a',
weekday(concat(year(joining_date),'-',month(joining_date),'-','01')) 'b'
from employee;

select date(now()), day(date(now())), year(date(now())), month(date(now())),
concat(year(date(now())),'-',month(date(now())),'-','01') '1st day',
-- concat(year(date(now())),'-',month(date(now())),'-',day(date(now()))) 'xxa',
weekday(concat(year(date(now())),'-',month(date(now())),'-','01')) 'weekday of 1stday',
(day(date(now()))-1+weekday(concat(year(date(now())),'-',month(date(now())),'-','01')))/7 'finalweek1',
floor(day(date(now()))-1+weekday(concat(year(date(now())),'-',month(date(now())),'-','01')))/7 'finalweek2',
(floor(day(date(now()))-1+weekday(concat(year(date(now())),'-',month(date(now())),'-','01')))/7)+1 'finally';

select date(now())+2, day(date(now())+2), year(date(now())+2), month(date(now())+2),
concat(year(date(now())+2),'-',month(date(now())+2),'-','01') '1st day',
-- concat(year(date(now())),'-',month(date(now())),'-',day(date(now()))) 'xxa',
weekday(concat(year(date(now())+2),'-',month(date(now())+2),'-','01')) 'dayoftheweek of 1stday',
'---',
day(date(now())+2),
(day(date(now())+2)-1),
(day(date(now())+2)-1+weekday(concat(year(date(now())+2),'-',month(date(now())+2),'-','01'))) 'calc_part2',
(day(date(now())+2)-1+weekday(concat(year(date(now())+2),'-',month(date(now())+2),'-','01')))/7 'finalweek1',
(day(date(now())+2)-1+weekday(concat(year(date(now())+2),'-',month(date(now())+2),'-','01')))%7 'finalweek2',
floor((day(date(now())+2)-1+weekday(concat(year(date(now())+2),'-',month(date(now())+2),'-','01')))/7) 'finalweek3',
floor((day(date(now())+2)-1+weekday(concat(year(date(now())+2),'-',month(date(now())+2),'-','01')))/7)+1 'finally';

select * from empdb.employee;
select concat('Mr.',first_name, lastname) from empdb.employee;


select date(joining_date), day(joining_date), concat(year(joining_date),'-',month(joining_date),'-','01') 'a',
weekday(concat(year(joining_date),'-',month(joining_date),'-','01')) 'aa';

select joining_date,salary,
floor((day(joining_date)-1+weekday(concat(year(joining_date),'-',month(joining_date),'-','01')))/7)+1 'wom'
from employee order by wom ;

/* 8900000	2
6000000	3
1230000	4
2200000	5 */
-- 10. Find the highest salary for each week of the month on joining_date
select max(salary),
floor((day(joining_date)-1+weekday(concat(year(joining_date),'-',month(joining_date),'-','01')))/7)+1 as 'wom'
from empdb.employee group by wom order by wom;


select joining_date, week(joining_date),weekday(joining_date),weekofyear(joining_date) from employee;

/* sunday - starting of the week
monday - starting of the weekofyear 
15-jan-2019 - tue */
select date("2019-01-15")-3, week(date("2019-01-15")-3),weekday(date("2019-01-15")-3),weekofyear(date("2019-01-15")-3)
union
select date("2019-01-15")-2, week(date("2019-01-15")-2),weekday(date("2019-01-15")-2),weekofyear(date("2019-01-15")-2)
union
select date("2019-01-15")-1, week(date("2019-01-15")-1),weekday(date("2019-01-15")-1),weekofyear(date("2019-01-15")-1)
union
select date("2019-01-15"), week(date("2019-01-15")),weekday(date("2019-01-15")),weekofyear(date("2019-01-15"))


union
select date(now())-7, week(date(now())-7),weekday(date(now())-7),weekofyear(date(now())-7)
union
select date(now())-6, week(date(now())-6),weekday(date(now())-6),weekofyear(date(now())-6)
union
select date(now())-5, week(date(now())-5),weekday(date(now())-5),weekofyear(date(now())-5)
union
select date(now())-4, week(date(now())-4),weekday(date(now())-4),weekofyear(date(now())-4)
union
select date(now())-3, week(date(now())-3),weekday(date(now())-3),weekofyear(date(now())-3)
union
select date(now())-2, week(date(now())-2),weekday(date(now())-2),weekofyear(date(now())-2)
union
select date(now())-1, week(date(now())-1),weekday(date(now())-1),weekofyear(date(now())-1)
union
select date(now()), week(date(now())),weekday(date(now())),weekofyear(date(now()));

-- Find the highest salary of each week of the year on joining_date



select date(now())+6, week(date(now())+6),weekday(date(now())+6),weekofyear(date(now())+6);

select date(now())+6, week(date(now())+6),weekday(date(now())+6),weekofyear(date(now())+6);





drop trigger updaffsubtbl;
delimiter &&
create trigger updaffsubtbl
after update on outlet for each row
begin
	update out_aff_ins set outlet_sales = new.outlet_sales where outlet_id = old.outlet_id;
end &&
delimiter ;

-- before delete
select * from outlet where outlet_id = 125;
	-- 125	stall	2000
select * from out_aff_ins where outlet_id = 125;
--	125	stall	2000
    
delete from outlet where outlet_id = 125;

-- after delete
select * from outlet where outlet_id = 125;
select * from out_aff_ins where outlet_id = 125;

update outlet set outlet_sales = 555 where outlet_id = 125;


show databases;
select database()
show tables;
use salesdb;

insert into outlet values (125,'stall',300);


create trigger Salary_log_update
after update on salary for each row
begin
insert into Trg_Salary_log values(new.Salary_id,new.gross_salary,new.hourly_pay,new.state_tax,new.federal_tax,new.Account_id);
end &&
delimiter ;

SELECT employee_id, Joining_date, weekday(Joining_date) as weekday_count,
FLOOR((DAYOFMONTH(Joining_date)-1 + WEEKDAY(concat(YEAR(Joining_date),'-',MONTH(Joining_date),'-01')))/7) + 1 as week_of_month
FROM Employee;


select * from empdb.employee;
select * from empdb.reward;
