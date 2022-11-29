-- Practice queries
show databases;
use inventory;

show tables;
describe employee;

select salary*.5 as half_salary from employee;
select avg(salary) from employee;

-- 1.Write a procedure to fetch employee earning less than average salary

delimiter && 
create procedure low_Avg()
begin
select * from employee where salary < (select avg(salary) from employee);
end &&
delimiter ;
call low_avg ;

-- 2)Write a procedure to fetch salary of the employee id passed as input
delimiter &&
create procedure salarye(in eid int, out sal int)
begin
select salary from employee where employee_id = eid;
end &&
delimiter ;
call salarye(1,@sal);

select salary*.5 as half_salary from employee;
select avg(salary) from employee;

-- 1.Write a procedure to fetch employee earning less than average salary

delimiter && 
create procedure low_Avg()
begin
select * from employee where salary < (select avg(salary) from employee);
end &&
delimiter ;
call low_avg ;

-- 2)Write a procedure to fetch salary of the employee id passed as input
delimiter &&
create procedure salarye(in eid int, out sal int)
begin
select salary from employee where employee_id = eid;
end &&
delimiter ;
call salarye(1,@sal);

-- 3)Write a function to fetch 50% of salary
delimiter &&
create function half_salary(hs int)
returns int no sql 
begin
return hs*.5 ;
end &&
delimiter ;

select salary,half_salary(salary) from employee;

/* 4) Write a function to add a string to the passed name */ 
delimiter &&
create function nname(n varchar(50))
returns varchar(50) no sql
begin	
return concat("My name is"," ",n);
end &&
delimiter ;
select nname( "Ihsan"),nname("Ridwan");
select * from employee;

5)Write a function to fetch the next maximum salary to the input number passed
delimiter &&
create function next_max_sal(n int)
returns int reads sql data
begin
return (select max(salary) from employee where salary < n);
end &&
delimiter ;

select next_max_sal(6000000);



-- 3)Write a function to fetch 50% of salary
delimiter &&
create function half_salary(hs int)
returns int no sql 
begin
return hs*.5 ;
end &&
delimiter ;

select salary,half_salary(salary) from employee;

/* 4) Write a function to add a string to the passed name */ 
delimiter &&
create function nname(n varchar(50))
returns varchar(50) no sql
begin
return concat("My name is"," ",n);
end &&
delimiter ;
select nname( "Ihsan"),nname("Ridwan");

5)Write a function to fetch the next maximum salary to the input number passed
delimiter &&
create function next_max_sal(n int)
returns int reads sql data
begin
return (select max(salary) from employee where salary < n);
end &&
delimiter ;

select next_max_sal(6000000);


select * from employee;
select *, sum(salary) over (partition by departement) from employee;
select * from employee e1,
(select departement,sum(salary) from employee group by departement) d
where e1.departement = d.departement;

-- 2. Get department's total salary belonging to each employee's department (including nulls)
insert into employee values (14,'Mike','Andrew',100000,'2019-02-20','null');
use inventory;

 select e.employee_id,e.salary,ifnull(e.departement,'unk') as 'new_type',g.type_sum from employee e,
(select departement,sum(salary) as type_sum from employee group by departement) g where 
ifnull(e.departement,'unk') = ifnull(g.departement,'unk');

select * from employee;
--  3) Get each department's maximum salary(department names as columns and maximum salary in single row)
select 
 max(case when departement = 'IT' then Salary else null end) as "IT",
 max(case when departement = 'Insurance' then salary else null end) as "Insurance",
 max(case when departement = 'Finance' then salary else null end) as "Finance",
 max(case when departement = 'Banking' then salary else null end) as "Banking",
 max(case when departement is null then salary else null end) as "unknown"
  from employee;
-- 4. Get running total of the salary in employee table
select employee_id,salary, sum(salary) over (order by employee_id) as running_total from employee;

-- 5. Get department's total salary belonging to each employee's department using window functions)
select *, sum(salary) over (partition by departement) from employee;

-- 6. Get nth salary (*-using all the possible ways)
-- a)select * from employee order by salary desc limit n-1,1;
-- select * from 
 -- (select employee_id, salary, departement, dense_rank() over (order by salary desc) as "rnk" from employee)  e
 -- where e.rnk = n;
-- c)select * from employee e1 where n = (select count(distinct e2.salary) from employee e2 where e1
-- .salary <= e2.salary);

-- to get total maximum sales of the outlettype belonging to the outlet_id's type
SELECT *, MAX(outlet_sales) over (partition by outlet_type) from outlet;
select o.outlet_id,o.outlet_type,ifnull(o.outlet_type,'unk') as new_type, g.max_outletsales from outlet o, 
(select outlet_type,max(outlet_sales) as max_outletsales from outlet group by outlet_type) g
where ifnull(o.outlet_type,'unk') = ifnull(g.outlet_type,'unk');
select o.outlet_id,o.outlet_type, g.max_outletsales from outlet o, 
(select outlet_type,max(outlet_sales) as max_outletsales from outlet group by outlet_type) g
where o.outlet_type = g.outlet_type ;
select * from outlet o, 
(select outlet_type, sum(outlet_sales) as type_sum , avg(outlet_sales) as type_avg, min(outlet_sales) as type_min, max(outlet_sales) as type_max
from outlet group by outlet_type) g
where ifnull(o.outlet_type,'unk') = ifnull(g.outlet_type,'unk') order by o.outlet_id;
select 
count,(case when outlet_type = 'mart' then outlet_sales else null end) as mart,
count(case when outlet_type = 'supermarket' then outlet_sales else null end) as supermarket,
count(case when outlet_type = 'grocery' then outlet_sales else null end) as grocery,
count(case when outlet_type = 'stall' then outlet_sales else null end) as stall,
count(case when outlet_type is null then outlet_sales else null end) as unknown
 from outlet;
 select row_number() over (partition by outlet_type), outlet_type, outlet_sales from outlet;
 select row_number() over (), outlet_type, outlet_sales from outlet;
 select outlet_id, outlet_type, outlet_sales, rank() over (order by outlet_sales desc) as "rnk",
dense_rank() over (order by outlet_sales desc) as "dense_rnk" 
 from outlet ; 
 select outlet_id, outlet_type, outlet_sales, sum(outlet_sales) over (order by outlet_id) as running_total from outlet;
 
-- 1. Find Second Highest Salary from Employee table using subquery
select * from employee;
select salary from employee where salary < (select max(salary) from employee) order by salary desc limit 1;
-- 2. Find Second Highest Salary from Employee table using "not" any where in the query
select max(salary) from employee where salary not in (select max(salary) from employee);
-- 3. Find Second Highest Salary from Employee table using inline table
select * from (select distinct salary from employee order by salary desc limit 2)  t order by t.salary limit 1;
-- 4. Find Second Highest Salary from Employee table using rank window function
select * from (select salary,dense_rank () over (order by salary desc) as rnk from employee ) r where r.rnk = 2;  
-- 5. Find Second Highest Salary from Employee table using limit
select salary from employee order by Salary desc limit 1,1;
-- 6. Find Second Highest Salary from Employee table using "<>" any where in the query
select max(salary) from employee where salary <> (select max(salary) from employee);
-- 7. Find Second Highest Salary from Employee table using "max() function and subquery" anywhere in the query
select max(salary) from employee where salary < (select max(salary) from employee);
-- 8. Find duplicate employees in reward table
select * from reward;
select employee_ref_id  from reward group by employee_ref_id having count(Employee_ref_id) > 1;
-- or
select * from employee where employee_id in (select employee_ref_id  from reward group by employee_ref_id having count(Employee_ref_id) > 1);

-- 9. Rank each salary using rank function
select *,rank() over(order by salary desc) as rnk from employee ; 

-- 10. Rank each salary using dense rank function
select *,dense_rank() over(order by salary desc) as rnk from employee ; 
-- 11. Rank each salary "with out" using rank functions
select * ,row_number() over (order by Salary desc) as rnk from Employee ;  
-- 12. Find Second Highest Salary from Employee table using "!=" any where in the query
select max(salary) from employee where salary != (select max(salary) from employee);
-- 13. Find Second Highest Salary from Employee table using "left join and self join" anywhere in the query
select e1.salary from employee e1 where 2 = (select count(distinct e2.salary) from employee e2 where e1.salary <= e2.salary);

-- 14. Find Second Highest Salary from Employee table using Row_number() function
select * from (select salary,row_number() over (order by salary desc) as rn from employee)r where r.rn = 2; 

-- 15. Find Second Highest Salary from Employee table using "Row_number() function" and pass blank inside “over()”
select * from (select salary,row_number() over () as rn  from employee order by salary desc)r where r.rn = 2;
use inventory;

-- 1. Find the highest salary of each department
use inventory;
select * from employee;
select max(salary) from employee group by departement;
-- 2. Find the highest salary of each year on joining_date
select max(salary) from employee group by year(joining_date);
-- 3. Find the highest salary of each quarter on joining_date
select max(salary) from employee group by quarter(joining_date);
-- 4. Find the highest salary of each week of the year on joining_date 
select max(salary) from employee group by week(joining_date);
-- 5 Find the highest salary on the even days of joining_date
select max(salary) from employee where day(joining_date) % 2 = 0;
-- 6. Find the highest salary on the odd days of joining_date
select max(salary) from employee where day(joining_date) % 2 <> 0;
-- 7. Find the highest salary of even months on joining_date
select max(salary) from employee where month(joining_date) % 2 = 0;
-- 8. Find the highest salary of odd weeks of the year on joining_date
select max(salary) from employee where week(joining_date) % 2 <> 0;
-- 9. Find the highest 
-- 10. Find week of the month for each joining_date
use inventory;
create table dress (DCODE INT PRIMARY KEY,
DESCRIPTION varchar(20),
PRICE INT,
MCODE varchar(10),
LAUNCHDATE date);
CREATE TABLE MATERIAL (MCODE varchar(10) PRIMARY KEY,
TYPE VARCHAR(15));
ALTER TABLE DRESS ADD CONSTRAINT FOREIGN KEY(MCODE) REFERENCES MATERIAL (MCODE);
describe dress;
insert into material values('M001','TERELENE');
insert into material values('M002','COTTON');
insert into material values('M004','POLYESTER');
insert into material values('M003','SILK');

insert into dress values (10001,'formal_shirt',1250,'M001','2008-01-12');
insert into dress values (10020,'FROCK',750,'M004','2007-09-09');
insert into dress values (10012,'Informal_shirt',1450,'M002','2008-06-06');
insert into dress values (10019,'Evening_Gown',850,'M003','2008-06-06');
insert into dress values (10090,'tulip_skirt',850,'M002','2007-03-31');
update dress
set LAUNCHDATE = '2008-06-06'
where DCODE = 10012;
update dress
set LAUNCHDATE = '2008-06-06'
where DCODE = 10019;

insert into dress values (10023,'pencil_skirt',1250,'M003','2008-12-19');
insert into dress values (10089,'slacks',850,'M002','2008-10-20');
insert into dress values (10007,'formal_pant',1450,'M001','2008-03-09');
insert into dress values (10009,'informal_pant',1400,'M002','2008-10-20');
insert into dress values (10024,'Baby_Top',650,'M003','2007-04-07');

-- (i) To display DCODE and DESCRIPTION of each dress in ascending order of DCODE.
SELECT DCODE,DESCRIPTION FROM DRESS ORDER BY DCODE;

-- (ii) To display the details of all the dresses which have LAUNCHDATE in between 05-DEC-07 and 20-JUN-08 (inclusive of both the dates).
SELECT * FROM DRESS WHERE LAUNCHDATE >= '2007-12-05' AND LAUNCHDATE <= '2008-06-20';

-- (iii) To display the average PRICE of all the dresses which are made of material with MCODE as M003
SELECT AVG(PRICE) FROM DRESS WHERE MCODE = 'M003';

-- (iv) To display material-wise highest and lowest price of dresses from DRESS table.
-- (Display MCODE of each dress along with highest and lowest price).
SELECT MCODE,MAX(PRICE),MIN(PRICE) FROM DRESS GROUP BY MCODE;
select * from dress;
select * from MATERIAL;

-- (v) To display total price for Terelene
SELECT SUM(PRICE) FROM DRESS D,MATERIAL M WHERE D.MCODE = M.MCODE AND TYPE = 'TERELENE'; 

-- (vi) To display DESCRIPTION, TYPE with PRICE more than 1250; (vii) To display the maximum code from the material
SELECT D.DESCRIPTION,M.TYPE,D.PRICE FROM DRESS D LEFT OUTER JOIN MATERIAL M ON D.MCODE = M.MCODE 
WHERE D.PRICE > 1250;
-- (vii) To display the maximum code from the material
SELECT MAX(MCODE) FROM MATERIAL;

/* (viii) To display number of unique dress price */
	SELECT COUNT(DISTINCT (PRICE)) FROM DRESS;

    create database books_db;
    use books_db;
    CREATE TABLE books
(
book_id INT NOT NULL AUTO_INCREMENT, title VARCHAR(100),
author_fname VARCHAR(100),
author_lname VARCHAR(100),
released_year INT,
stock_quantity INT,
pages INT,
PRIMARY KEY(book_id)
);
INSERT INTO books (title, author_fname, author_lname, released_year, stock_quantity, pages) VALUES
('The Namesake', 'Jhumpa', 'Lahiri', 2003, 32, 291),
('Norse Mythology', 'Neil', 'Gaiman',2016, 43, 304),
('American Gods', 'Neil', 'Gaiman', 2001, 12, 465),
('Interpreter of Maladies', 'Jhumpa', 'Lahiri', 1996, 97, 198),
('A Hologram for the King: A Novel', 'Dave', 'Eggers', 2012, 154, 352),
('The Circle', 'Dave', 'Eggers', 2013, 26, 504),
('The Amazing Adventures of Kavalier & Clay', 'Michael', 'Chabon', 2000, 68, 634),
('Just Kids', 'Patti', 'Smith', 2010, 55, 304),
('A Heartbreaking Work of Staggering Genius', 'Dave', 'Eggers', 2001, 104, 437),
('Coraline', 'Neil', 'Gaiman', 2003, 100, 208),
('What We Talk About When We Talk About Love: Stories', 'Raymond', 'Carver', 1981, 23, 176), ("Where I'm Calling From: Selected Stories", 'Raymond', 'Carver', 1989, 12, 526),
('White Noise', 'Don', 'DeLillo', 1985, 49, 320),
('Cannery Row', 'John', 'Steinbeck', 1945, 95, 181),
('Oblivion: Stories', 'David', 'Foster Wallace', 2004, 172, 329),
('Consider the Lobster', 'David', 'Foster Wallace', 2005, 92, 343);
use books_db;
select * from books;
-- 1) Reverse and Uppercase the following sentence
-- "Why does my cat look at me with such hatred?"
select upper("Why does my cat look at me with such hatred?");
select reverse("Why does my cat look at me with such hatred?");
-- 2) Replace spaces in titles with '->'
SET SQL_SAFE_UPDATES = 0;
update books set title = replace(title,' ','->');
-- 3) Print The last name and reverse of last name
select author_lname, reverse(author_lname) from books;
-- 4) Print full name in caps
select concat(upper(author_fname),' ',upper(author_lname)) as full_name from books;
-- 6) Print title followed by 'was released in' followed by released year example 
-- 'The Namesake was released in 2003' for all title
select concat(title,' ','was released in ',released_year) as Print_New_Title from books;
 update books set title = replace(title,'->',' ');
-- 7) Print book titles and the length of each title 
select * from books;
select title,length(title) from books;
-- 8)short title to 10 chr followed by '...' , author last name followed by ',' then first name and 
-- also like '12 in stock'
select concat(substring(title,1,10),'...') as short_title,concat(author_lname,',',author_fname) as author,
concat(stock_quantity,' in stock') as stock from books; 
-- 9) insert new values*/
 INSERT INTO books (title, author_fname, author_lname, released_year, stock_quantity, pages) VALUES 
('10% Happier', 'Dan', 'Harris', 2014, 29, 256), ('fake_book', 'Freida', 'Harris', 2001, 287, 428), 
('Lincoln In The Bardo', 'George', 'Saunders', 2017, 1000, 367);
-- 10 Select All Story Collections Titles That contain 'stories'
select title from books where title like '%Stories%';

-- 11) Find The Longest Book Print Out the Title and Page Count not using max
select * from books;
select title from books order by title desc limit 1;
select title,pages from books order by pages desc limit 1;
-- 12) Print a summary containing the title and year, for the 3 most recent books (eg) Lincoln In The Bardo – 2017
select concat(title,' - ',released_year) as Title_and_Year from books order by released_year desc Limit 3;
-- 13) Find all books with an author_lname that contains a space(" ")
select * from books where author_lname like '% %';
-- 14) Find The 3 Books With The Lowest Stock Select title, year, and stock 
select title, released_year, stock_quantity from books order by stock_quantity limit 3;
-- 15)Print title and author_lname,  sorted first by author_lname and then by title
select title,author_lname from books order by author_lname,title;
-- 16)Make This Happen...Sorted Alphabetically By Last Name
-- (eg) MY FAVORITE AUTHOR IS RAYMOND CARVER!
select concat('MY FAVORITE AUTHOR IS ',author_fname,' ',author_lname,'!') as FAVORITE_AUTHOR  from books
order by author_lname;
-- 17) Print the number of books in the database
select count(title) from books;
-- 18) Print out how many books were released in each year
select released_year,count(title) from books group by released_year;
-- 19) Print out the total number of books in stock
select sum(stock_quantity) as total_number_of_books from books; 
-- 20) Find the average released_year for each author
select author_fname, avg(released_year) from books group by author_fname;
-- 21) Find the full name of the author who wrote the longest book
select * from books;
select concat(author_fname,' ',author_lname) as full_name,pages from books order by pages desc limit 1; 
-- 22) -- year | # books | avg pages | print in this format
select released_year as year,count(title) as '# books',avg(pages) as 'avg pages' from books group by released_year;
-- 23) Select All Books Written Before 1980 (non inclusive)
select title,released_year from books where released_year < 1980;
-- 24) Select All Books Written By Eggers Or Chabon
select title,author_lname from books where author_lname like'%Eggers%' or author_lname like '%Chabon%';
-- 25) Select All Books Written By Lahiri, Published after 2000
select title,author_lname,released_year from books where author_lname like '%Lahiri%' and released_year > 2000;
-- 26) Select All books with page counts between 100 and 200
select title,pages from books where pages between 100 and 200;
-- 27) Select all books where author_lname starts with a 'C' or  'S'
select title,author_lname from books where author_lname like 'C%' or author_lname like 'S%';
-- 'If title contains 'stories' -> Short Stories,'Just Kids' and 'A Heartbreaking Work' -> Memoir
-- Everything Else -> Novel 
select title,
case 
when title like '%stories%' then 'Short Stories'
when title like '%Just Kids%' or title like '%A Heartbreaking Work%' then 'Memoir'
else 'Novel'
end as book_type
from books;
-- 29) Bonus: Make This Happen |title | author_lname | COUNT 
-- (eg) What We Talk About When We Talk About Love: Stories | Carver | 2 books */
use books_db;
select * from books;
select b.title,c.author_lname,c.count from books b,
(select author_lname,
case 
when count(author_lname)<= 1 then concat(count(author_lname),' book')
else concat(count(author_lname),' books')
end as count from books group by author_lname)c
where b.author_lname = c.author_lname;

select 
 author_lname,
case 
when count(author_lname)<= 1 then concat(count(author_lname),' book')
else concat(count(author_lname),' ','books')
end as count from books group by author_lname;


-- select author_lname, group_concat(title,' | ',author_lname,' | ',cnt(author_lname),' books') as New_Title from books 
 -- group by author_lname;
 show databases;
use books_db;
create database school;
use school;
 CREATE TABLE students
(
id INT NOT NULL AUTO_INCREMENT primary key, 
first_name VARCHAR(100));
	CREATE TABLE papers
	(
    student_id int,
	foreign key (student_id)  references students(id) , 
	title VARCHAR(100),
	grade int);
   INSERT INTO students (first_name) VALUES ('Caleb'),('Samantha'),('Raj'),('Carlos'), ('Lisa');
   INSERT INTO papers (student_id, title, grade ) VALUES (1, 'My First Book Report', 60),
(1, 'My Second Book Report', 75),
(2, 'Russian Lit Through The Ages', 94),
(2, 'De Montaigne and The Art of The Essay', 98), (4, 'Borges and Magical Realism', 89);
select * from students;
select * from papers;
-- 3)
select s.first_name,p.title,p.grade from students s,papers p where s.id = p.student_id order by grade desc;
-- 4)
select s.first_name,p.title,p.grade from students s left outer join papers p on s.id = p.student_id;
-- 3)
alter table papers modify grade int default 0;
alter table papers modify title varchar(100) default 'MISSING';
describe papers;
select s.first_name,
case when title is null then 'Missing'
     else title
     end as name_title,
   case when grade is null then 0
   else grade
   end as final_grade
     from students s left outer join papers p on s.id = p.student_id; 
     
     select first_name, ifnull (title, "MISSING") as title, ifnull (grade, 0) as grade from students s 
     left join
		papers p on s.id = p.student_id ;
     create database sample_sql;
use sample_sql;
create table dept_sample(  
  deptno     int,  
  dname      varchar(14),  
  loc        varchar(13),  
  constraint pk_dept primary key (deptno));
create table emp_sample  
  (empno    int,  
  ename    varchar(10),  
  job      varchar(9),  
  mgr      int,  
  hiredate date,  
  sal      int,  
  comm     int,  
  deptno   int,  
  constraint pk_emp primary key (empno),  
  constraint fk_deptno foreign key (deptno) references dept_sample (deptno));
  insert into DEPT_sample (DEPTNO, DNAME, LOC)
values(10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO dept_sample VALUES(10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO dept_sample VALUES(20, 'RESEARCH', 'DALLAS');
INSERT INTO dept_sample VALUES(30, 'SALES', 'CHICAGO');
INSERT INTO dept_sample VALUES(40, 'OPERATIONS', 'BOSTON');
select * from dept_sample;
describe table employee;
INSERT INTO EMP_sample VALUES
  (7369, 'SMITH', 'CLERK', 7902, '1980-12-17', 800, NULL, 20);
 INSERT INTO EMP_sample VALUES
  (7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600, 300, 30);
INSERT INTO EMP_sample VALUES
  (7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250, 500, 30);
INSERT INTO EMP_sample VALUES
  (7566, 'JONES', 'MANAGER', 7839, '1981-04-2', 2975, NULL, 20);
INSERT INTO EMP_sample VALUES
  (7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250, 1400, 30);
 INSERT INTO EMP_sample VALUES
  (7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850, NULL, 30);
INSERT INTO EMP_sample VALUES
  (7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450, NULL, 10);
INSERT INTO EMP_sample VALUES
  (7788, 'SCOTT', 'ANALYST', 7566, '1982-12-09', 3000, NULL, 20);
INSERT INTO EMP_sample VALUES
  (7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000, NULL, 10);
INSERT INTO EMP_sample VALUES
  (7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', 1500, 0, 30);
 INSERT INTO EMP_sample VALUES
  (7876, 'ADAMS', 'CLERK', 7788, '1983-01-12', 1100, NULL, 20);
 INSERT INTO EMP_sample VALUES
  (7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950, NULL, 30);
 INSERT INTO EMP_sample VALUES
  (7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000, NULL, 20);
INSERT INTO EMP_sample VALUES
  (7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300, NULL, 10);
  select * from emp_sample;
  
  -- 1)find all employees who are also managers
  select distinct(empno),ename from emp_sample where empno in(select distinct(mgr) from emp_sample);
  -- or
  select distinct(e1.empno),e1.ename from emp_sample e1 inner join emp_sample e2 on e1.empno = e2.mgr;
  -- 2) give empno,ename,mgr,mgr name
  select e1.empno,e1.ename,e1.mgr,e2.ename as managername from emp_sample e1 left outer join emp_sample e2 on e1.mgr=e2.empno; 
  create table temp_sample(temp1 int);
  insert into temp_sample values(1);
  insert into temp_sample values(1);
  insert into temp_sample values(1);
  delete from temp_sample;
  SET SQL_SAFE_UPDATES = 0;
  select * from temp_sample;
  -- 3) refer temp_sample  how many records will return with same values in both the tables (inner,left,right,fullouter/cross) all will return 9 in this eg ie. 3*3
  select * from temp_sample t1 inner join temp_sample t2 on t1.temp1 = t2.temp1; -- (9)
  select * from temp_sample t1 left outer join temp_sample t2 on t1.temp1 = t2.temp1;--  (9)
  select * from temp_sample t1 right outer join temp_sample t2 on t1.temp1 = t2.temp1; -- (9)
  select * from temp_sample t1 cross join temp_sample t2; -- (9)
  -- 4)find Employees whose salary is greater than their Manager's salary 
 select empno,ename from emp_sample where sal > mgr;
  select * from emp_sample;
  select e1.empno,e1.ename,e1.sal,e1.mgr,e2.sal,e2.ename from emp_sample e1 inner join emp_sample e2 on e1.mgr = e2.empno where e1.sal > e2.sal ;
  select empno,ename from emp_sample e1 where sal > (select sal from emp_sample  where empno = e1.mgr);
  
-- 5)fetch a query to display if the salary of the employee is higher,lower or equal to previous employee
-- lag is for previous record and lead is for next record
select e.*,lag(salary) over (partition by departement order by employee_id) as previous_emp_sal,
case when e.salary > lag(salary) over (partition by departement order by employee_id) then "higher_than_pe" 
when e.salary = lag(salary) over (partition by departement order by employee_id) then 'equal_pe'
when e.salary < lag(salary) over (partition by departement order by employee_id) then 'lower_than_pe'
end sal_range
from employee e;
select e.*,lag(salary) over (order by employee_id) as previous_emp_sal,
case when e.salary > lag(salary) over (order by employee_id) then 'higher_than_pe' 
when e.salary = lag(salary) over (order by employee_id) then 'equal_pe'
when e.salary < lag(salary) over (order by employee_id) then 'lower_than_pe'
end sal_range
from employee e;
-- 6)fetch a query to display if the salary of the employee is higher,lower or equal to next employee
select e.*,lead(salary) over (order by employee_id) as next_emp_sal,
case when e.salary > lead(salary) over (order by employee_id) then 'higher_than_ne' 
when e.salary = lead(salary) over (order by employee_id) then 'equal_ne'
when e.salary < lead(salary) over (order by employee_id) then 'lower_than_ne'
end sal_range
from employee e;
use sample_sql;
-- 7) find the name of the department where more than 2 employees are working 
select distinct d.dname from dept_sample d inner join emp_sample e on d.deptno = e.deptno group by d.dname having count(e.empno) > 2;
-- or
select distinct d.dname from dept_sample d left outer join emp_sample e on d.deptno = e.deptno group by d.dname having count(e.empno) > 2;
-- 8)query to calculate the avg sal of each dept which is higher than 2000 dept name in desc order
select d.dname,avg(e.sal) from dept_sample d inner join emp_sample e on d.deptno = e.deptno group by d.dname having avg(e.sal) > 2000 order by d.dname desc;
-- or
select d.dname,avg(e.sal) from dept_sample d left outer join emp_sample e on d.deptno = e.deptno group by d.dname having avg(e.sal) > 2000 order by d.dname desc;select deptno,avg(sal) from emp_sample group by deptno;
-- 9) find the manager and employee belonging to same city (usualy city will be in the employee tab )
-- select e1.empno,e1.ename,e1.mgr,e2.ename as managername,e1.city from emp_sample e1 left outer join emp_sample e2 on e1.mgr = e2.empno where e.city = e2.city;  
-- 10) find employees whose sal between 2000 and 3000 with the department and manager name 
select e1.ename,e2.ename as managername,d.dname,e1.sal from emp_sample e1 left outer join emp_sample e2 on e1.mgr = e2.empno inner join dept_sample d on d.deptno = e1.deptno where e1.sal between 2000 and 3000 ;
select * from dept_sample;
select * from emp_sample;
use sample_sql; 

