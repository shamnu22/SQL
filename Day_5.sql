select database();
use empdb;
-- below are alternate solutions for a single question
select * from employee where first_name not like '%John%' and  first_name not like '%Jerry%';
select * from employee where trim(first_name) not in ('John', 'Jerry');
select * from Employee where trim(First_name) <> 'John' and trim(First_name) <>'Jerry';

select * from employee where trim(first_name) like '___n';

select departement, salary from employee order by departement;
/*
Finance		1000000
Finance		2200000
*/
select departement, sum(salary) from employee where salary > 1000000 group by departement;
/*
IT			10000000
Banking		10130000
Insurance	2000000
Finance		2200000
*/
select departement, sum(salary) from employee group by departement having sum(salary) > 1000000;
/*
Finance		3200000
IT			10000000
Banking		10130000
Insurance	2000000
*/

select last_name,salary from employee;
select max(salary) from employee where last_name not like '%o%';
-- 10. using where 
select position('o' in last_name), max(salary) from employee where position('o' in last_name)=0; 
-- using group by
select position('o' in last_name) as pos, max(salary) from employee group by pos=0 having pos=0;
select  last_name, salary from employee ;
-- blood group-'o'
select * from employee;
-- Query1 : Select all employees who have names length of 5.
select first_name from employee where length(First_name)=5;
-- Query 2 : Select the employees whose hire date between '11-Sep-1980' to '03-Mar-2001'
select first_name from employee where Joining_date between '1980-09-1' and '2001-03-03';
select first_name from employee where Joining_date between '2019-01-11' and '2019-03-03';
-- Select count of employees , # of depatments , total Employee salary of  Employee table in a single query.
select count(distinct employee_id) as count_of_emp,count(distinct d.departement) as count_departement,
sum(salary) as sum_salary from employee;
select count(distinct employee_id),count(distinct d.departement),sum(salary) from employee e,departement d
where e.departement = d.departement;
/*
Abraham	2000000
Mathew	2200000
------- 2200000
--blood group other than -'o'
Kinto	1000000
Kansxo	6000000
Jose	8900000
chreket 4000000
Soso	1230000
------- 8900000*/
-- fetch where ln does not hv 'o'
select  max(salary) from employee where Last_name not like '%o%' ;
select  last_name, salary from employee where Last_name not like '%o%' ;
-- fetch where ln does contains 'o'
select  max(salary) from employee where Last_name like '%so%' ;
select  last_name, salary from employee where Last_name  like '%so%' ;

-- final query
select  max(salary) from Employee group by Last_name <> 'Kinto' ;

select  max(salary) from Employee where Last_name <> 'Kinto' 
union
select  max(salary) from Employee where Last_name = 'Kinto' ;

select  last_name, salary from Employee where Last_name <> 'Kinto' ;
select  max(salary) from Employee where Last_name <> 'Kinto' ;
select  last_name, salary from Employee where Last_name = 'Kinto' ;
select  max(salary) from Employee where Last_name = 'Kinto' ;

select * from employee;
select departement, max(salary) from employee group by departement;

select departement, max(salary) from employee group by departement;

select max(salary)  from Employee group by  (trim(Last_name) <> 'o') ;

select last_name, max(salary) from employee group by last_name 
 having last_name not like '%o%' order by max(salary) desc LIMIT 1;

select  last_name, max(salary) from Employee group by last_name;
-- equi to the below since all the values in the group by column are unique
select  last_name, salary from Employee ;
select  year(joining_date), max(salary) from Employee group by year(joining_date);
select  month(joining_date), max(salary) from Employee group by month(joining_date);
select  day(joining_date), max(salary) from Employee group by day(joining_date);
select  joining_date, max(salary) from Employee group by joining_date;
select  * from Employee ;
