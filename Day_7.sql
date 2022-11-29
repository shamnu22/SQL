use empdb;
select * from employee;
select * from reward;
-- ignores if emp recieved rewards less than 7500
select first_name,salary,amount, salary+amount as net from employee j
inner join reward k on j.employee_id = k.employee_ref_id where k.amount  < 7500;

-- ignores if emp recieved total of rewards less than 7500
select employee.employee_id,sum(reward.amount) from employee inner join
reward on employee.employee_id =reward.Employee_ref_id 
group by employee_id having sum(reward.amount) < 7500;

update employee set first_name = 'Bob' where trim(first_name) = 'Johny' ;

update employee set first_name = 'Johny' where trim(first_name) =  'Bob';

-- below not working
select Employee.Employee_id, Employee.First_name, sum(reward.amount) from Employee 
left outer join reward on Employee.Employee_id = reward.Employee_ref_id 
group by First_name having First_name like "%John%";

-- below working
select Employee.Employee_id, Employee.First_name, sum(reward.amount) from Employee 
left outer join reward on Employee.Employee_id = reward.Employee_ref_id 
group by Employee_id, First_name having First_name like "%John%";

use salesdb;
-- union 
select outlet_type from outlet where outlet_type in ( 'supermarket', 'mart');

select distinct outlet_type from outlet where outlet_type = 'supermarket';
select distinct outlet_type from outlet where outlet_type = 'mart';
-- for comparison
select outlet_type from outlet where outlet_type = 'supermarket' union
select outlet_type from outlet where outlet_type = 'mart';


select outlet_type from outlet where outlet_type = 'supermarket';
select outlet_type from outlet where outlet_type = 'mart';
-- for comparison
select outlet_type from outlet where outlet_type = 'supermarket' union all
select outlet_type from outlet where outlet_type = 'mart';

select outlet_id from outlet where outlet_type = 'supermarket' union all
select outlet_id from outlet where outlet_type = 'mart';

select * from outlet;

use salesdb;
select * from outlet;
select * from items;
select count(*) from outlet;
select count(*) from items;

select * from outlet o inner join items i on o.outlet_id  = i.outlet_id;
select * from outlet o left outer join items i on o.outlet_id  = i.outlet_id;
select * from outlet o right outer join items i on o.outlet_id  = i.outlet_id;
select * from outlet o cross join items i on o.outlet_id  = i.outlet_id;
select * from outlet o cross join items i ;
select count(*) from outlet o cross join items i ;


create table a (id int, name char(2));
create table b (id int, name char(2), ida int);
create table c (id int, name char(2), idb int);

desc a;
desc b;
desc c;

insert into a values (1,'a1');
insert into a values (2,'a2');
-- or 
insert into a values (1,'a1'), (2,'a2');
insert into b values (11,'b1',1), (12,'b2',12);
insert into c values (21,'c1',1), (22,'c2',22);

select * from a ;
select * from b ;
select * from c ;



use salesdb;
select * from a inner join b on a.id = b.ida
inner join c on a.id = c.idb;

select * from employee;

/* first name 	last name
abdul 		rahaman	
sheik		abdul */
use empdb;
update employee set last_name = 'Johny' where last_name = 'chreketo';
select * from employee ;

-- self join
select * from employee e1 inner join employee e2
on trim(e1.last_name) = trim(e2.first_name);

select e1.First_name,e1.Last_name from employee e1, employee e2
where trim(e1.last_name) = trim(e2.first_name)
union
select e2.First_name,e2.Last_name from employee e1, employee e2
where trim(e1.last_name) = trim(e2.first_name);

select * from employee;

select * from employee a inner join employee b
on trim(a.last_name) = trim(b.first_name);

use empdb;
select * from employee a inner join employee b
on trim(a.first_name) = trim(b.last_name);

select a.first_name, b.last_name, b.first_name, a.last_name from employee a cross join employee b;
