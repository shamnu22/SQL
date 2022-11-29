-- Day 8
create table places (
 id int, 
 place_name varchar(10));

 create table tours (
 id int, 
 stloc int, 
 endloc int);

 insert into places values 
 (1,'chennai'),
 (2,'bengaluru'),
 (3,'cochin'),
 (4,'hyderabad'),
 (5,'mysuru');

 insert into tours values  
 (1,	4,	1), 
 (2,	4,	3), 
 (3,	4,	2), 
 (4,	1,	4), 
 (5,	2,	3), 
 (6,	2,	5), 
 (7,	5,	3);

 select * from places;
 select * from tours;
 use empdb;

select * from employee;
select * from reward;
show tables;
select first_name 'name' from employee
union all
select last_name 'name' from employee;

-- 4. Get the first name, each reward amount for employees who have rewards not using “Inner Join”.
select first_name, amount from employee e right outer join reward r on e.employee_id = r.Employee_ref_id;
-- or 
select first_name, amount from employee e cross join reward r on e.employee_id = r.Employee_ref_id;
-- or 
select first_name, amount from employee e inner join reward r on e.employee_id = r.Employee_ref_id;

-- 6. Get the first name, each reward amount for employees along with who not have rewards using “union”.
-- fetch who has rewards
select First_name,amount from employee inner join reward on  employee.employee_id =reward.Employee_ref_id
union
-- fetch who does not have rewards
select First_name,amount from employee left outer join reward on  employee.employee_id =reward.Employee_ref_id;
select * from reward;
-- 6. Get the first name, each reward amount for employees along with who not have rewards using “union”.
(select first_name,amount from employee left outer join reward on employee_id =  Employee_ref_id) 
union 
(select First_name,amount from employee inner join reward on  employee.employee_id =reward.Employee_ref_id);

select employee.first_name from employee 
union 
select amount from reward;

-- 6. display the first name only , for employees have/no rewards using “union”.
/*
first name for employee having rewards;
first name for employee not having rewards;
union
*/
select first_name, amount from employee e inner join reward r on e.employee_id = r.Employee_ref_id
union
select first_name, amount from employee e left outer join reward r on e.employee_id = r.Employee_ref_id;

-- Get count of employees having last name same as first name of other employees
select count(e1.employee_id) from employee e1 inner join employee e2 on trim(e1.last_name) = trim(e2.first_name);

-- 8. List employees having last name same as first name of other employees
select e1.last_name from employee e1 inner join employee e2 on trim(e1.last_name) = trim(e2.first_name);
select trim(last_name) from employee where employee_id in
(select count(e1.employee_id) from employee e1 inner join employee e2 on 
trim(e1.last_name) = trim(e2.first_name));

select * from employee;
select count(*) from employee;
select first_name, left(trim(first_name),1) from employee;
select first_name, left(trim(first_name),5) from employee;
select count(left(trim(first_name),1)) from employee;
select count( distinct left(trim(first_name),1)) from employee;
-- Get count of employees having last name same as first name of other employees
select count(distinct b.Last_name) from employee a, employee b where a.First_name=b.Last_name;
-- Get count of employees having last name same as first name of other employees
select count(distinct b.Last_name) from employee a, employee b where a.First_name<>b.Last_name;
select  distinct b.Last_name from employee a, employee b where a.First_name<>b.Last_name;  --  and b.Last_name='johny' -- and a.first_name='johny';
select distinct b.Last_name from employee a, employee b where a.First_name=b.Last_name;

-- count of names matching
select count(e1.last_name) from employee e1 inner join employee e2 on trim(e1.last_name) = trim(e2.first_name);
select e1.last_name from employee e1 inner join employee e2 on trim(e1.last_name) = trim(e2.first_name);
-- count of names not mmatching
-- select count(e1.last_name), count(distinct e1.last_name), count(e1.last_name)%count(distinct e1.last_name)  
 select count(e1.last_name)%count(distinct e1.last_name)  
from employee e1 inner join employee e2 on trim(e1.last_name) <> trim(e2.first_name);

select count(e1.last_name) from employee e1 inner join employee e2 on trim(e1.last_name) <> trim(e2.first_name);
select count(distinct e1.last_name)  from employee e1 inner join employee e2 on trim(e1.last_name) <> trim(e2.first_name);
 select count(e1.last_name)%count(distinct e1.last_name)  from employee e1 inner join employee e2 on trim(e1.last_name) <> trim(e2.first_name);
 
 select 47%7;

-- 10. List FName,LName,rewardamount of employees having last name same as first name of other employees 
-- or vice-versa, with each of their reward amount
select e1.first_name, e1.last_name, r.amount from employee e1 inner join employee e2 
on trim(e1.last_name) = trim(e2.first_name)
left outer join reward r on e1.employee_id = r.employee_ref_id
union 
select e2.first_name, e2.last_name, r.amount from employee e1 inner join employee e2 on 
trim(e1.last_name) = trim(e2.first_name)
left outer join reward r on e2.employee_id = r.employee_ref_id;

select e1.first_name, e1.last_name, r.amount from employee e1 inner join employee e2 
on trim(e1.last_name) = trim(e2.first_name)
left outer join reward r on e1.employee_id = r.employee_ref_id;

-- names matching but no rewards
select e1.first_name, e1.last_name, r.amount from employee e1 inner join employee e2 on trim(e1.last_name) = trim(e2.first_name)
left outer join reward r on e1.employee_id = r.employee_ref_id;

-- 1.
select e1.first_name, e1.last_name from employee e1 inner join employee e2 on trim(e1.last_name) = trim(e2.first_name);

-- 2.
select e1.first_name, e1.last_name, r.amount from employee e1 inner join employee e2 on trim(e1.last_name) = trim(e2.first_name)
left outer join reward r on e1.employee_id = r.employee_ref_id;

select e1.first_name, e1.last_name, r.amount from employee e1 inner join employee e2 on trim(e1.last_name) = trim(e2.first_name)
left outer join reward r on e1.employee_id = r.employee_ref_id;

/* id	firstname		lastname	reward
1	Johny		Kinto			1000
1	Johny		Kinto			8000
2	  Jerry  	Kansxo			5000
6	Alex		Johny			null
7 	Yohan		Jerry			null */

select * from employee;
select * from reward;


-- 5/3 = q=1 r=2
select 5/3 as division , 5%3 as reminder;
select 10/3 as division , 10%3 as reminder;
 
select 22/6, 22%6;
select 48/7, 48%7;
/* select 49/7 -- = total not matching/ total employees = 7
select 49%7 -- = total not matching/ total employees = 7
select 48%7 --  total not matching/ total employees
select 47%7 --  total not matching/ total employees

7 * 7 = 49
1 match
48 non match
*/
select e1.last_name from employee e1 inner join employee e2 on trim(e1.last_name) <> trim(e2.first_name);
select count(distinct e1.last_name) from employee e1 inner join employee e2 on trim(e1.last_name) <> trim(e2.first_name);

select * from employee;
update employee set last_name = 'Jerry' where last_name = 'soso';

-- combination of self join and inner join
select a.First_name, a.Last_name, r.amount from Employee a inner join Employee b on trim(a.Last_name) = trim(b.First_name) 
left outer join reward r on a.Employee_id = r.Employee_ref_id
union
select b.First_name, b.Last_name, r.amount from Employee a inner join Employee b on trim(a.Last_name) = trim(b.First_name) 
left outer join reward r on b.Employee_id = r.Employee_ref_id;

select * from employee;
select 'output of first self join', a.employee_id, a.First_name, a.Last_name from Employee a
 inner join Employee b on trim(a.Last_name) = trim(b.First_name) 
union 
select 'output of second self join', b.employee_id, b.First_name, b.Last_name from Employee a
 inner join Employee b on trim(a.Last_name) = trim(b.First_name) ;

select a.employee_id, a.First_name, a.Last_name , b.employee_id, b.First_name, b.Last_name
from Employee a inner join Employee b on trim(a.Last_name) = trim(b.First_name);

/* id	firstname	lastname
1	Johny		Kinto	1000000	2019-01-20	Finance		1	Johny		Kinto	1000000	2019-01-20	Finance		
2	  Jerry  	Kansxo	6000000	2019-01-15	IT			2	  Jerry  	Kansxo	6000000	2019-01-15	IT
3	   Philip   Jose	8900000	2019-02-05	Banking		3	   Philip   Jose	8900000	2019-02-05	Banking
4	 John 		Abraham	2000000	2019-02-25	Insurance	4	 John 		Abraham	2000000	2019-02-25	Insurance
5	  Michael  	Mathew	2200000	2019-02-28	Finance		5	  Michael  	Mathew	2200000	2019-02-28	Finance
6	   Alex   	Johny	4000000	2019-05-10	IT			6	   Alex   	Johny	4000000	2019-05-10	IT
7	 Yohan 		Jerry	1230000	2019-06-20	Banking		7	 Yohan 		Jerry	1230000	2019-06-20	Banking
					
1	Johny		Kinto	1000000	2019-01-20	Finance		6	   Alex   	Johny	4000000	2019-05-10	IT
2	  Jerry  	Kansxo	6000000	2019-01-15	IT			7	 Yohan 		Jerry	1230000	2019-06-20	Banking */


select e1.first_name, e1.last_name, r.amount from employee e1 inner join employee e2 on trim(e1.last_name) = trim(e2.first_name)
left outer join reward r on e1.employee_id = r.employee_ref_id
union 
select e2.first_name, e2.last_name, r.amount from employee e1 inner join employee e2 on trim(e1.last_name) = trim(e2.first_name)
left outer join reward r on e2.employee_id = r.employee_ref_id;


-- using subquery
select First_name,last_name,amount from employee left outer join reward on  employee.employee_id =reward.Employee_ref_id 
where employee_id in (select e1.employee_id from employee as e1 inner join employee as e2 on trim(e1.first_name)=trim(e2.last_name)
union
select e2.employee_id from employee as e1 inner join employee as e2 on trim(e1.first_name)=trim(e2.last_name)
);


select First_name,last_name,amount from employee left outer join reward on  employee.employee_id =reward.Employee_ref_id 
where employee_id in (select distinct e1.employee_id from employee as e1 inner join employee as e2 on trim(e1.first_name)=trim(e2.last_name)
union 
select distinct e2.employee_id from employee as e1 inner join employee as e2 on trim(e1.first_name)=trim(e2.last_name));

select distinct e1.employee_id from employee as e1 inner join employee as e2 on trim(e1.first_name)=trim(e2.last_name);
select distinct e2.employee_id from employee as e1 inner join employee as e2 on trim(e1.first_name)=trim(e2.last_name)
