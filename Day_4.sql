select * from employee;
show databases;
use empdb;
-- finding quarter from date
select * from employee where quarter(joining_date) = 2;

-- fetch 'n' no.of characters from left side, right side, and from any position
select last_name,  substring(last_name,1,4), left(last_name,4), right(last_name,4), 
substring(last_name,4,4)  from employee;

select first_name, left(first_name,4), left(trim(first_name),4) from employee;

select "   Philip   ", left("   Philip   ",4),  left(trim("   Philip   "),4);

-- padding extra characters
select "samsung" , length("samsung"), rpad("samsung",15,"#"), length(rpad("samsung",15,"#"));

select "samsung" , length("samsung"), lpad("samsung",15,"#"), length(lpad("samsung",15,"#"));

-- Aggregate functions
use salesdb;
select * from outlet;
select distinct outlet_type from outlet;

select count(outlet_type) from outlet;
select count(distinct outlet_type) from outlet;

select max(outlet_sales) from outlet;
select min(outlet_sales) from outlet;

-- partial inserts
insert into outlet(outlet_id, outlet_sales) values(114,99);
insert into outlet(outlet_id, outlet_type) values(115,'stall');
insert into outlet(outlet_id) values (116);

desc outlet;
select * from outlet;
select * from outlet order by outlet_sales;
select * from outlet where outlet_sales < 20;
select * from outlet where outlet_sales is null;

select * from outlet where outlet_type is null;

select * from outlet where outlet_id is null;

select outlet_type from outlet where outlet_type is not null;

-- update using the builtin functions
select outlet_type from outlet ;
select upper(outlet_type) from outlet ;
select outlet_type from outlet ;
update outlet set outlet_type = upper(outlet_type) where outlet_type='mart';
select outlet_type from outlet ;

-- Group by 
select outlet_sales from outlet;
select sum(outlet_sales) from outlet;
select outlet_type, sum(outlet_sales) from outlet where outlet_type='mart';
select outlet_type, outlet_sales from outlet where outlet_type='supermarket';

select outlet_type, sum(outlet_sales) from outlet where outlet_type='supermarket';
select outlet_type, sum(outlet_sales) from outlet where outlet_type='stall';
select outlet_type, sum(outlet_sales) from outlet where outlet_type='mart';
select outlet_type, sum(outlet_sales) from outlet where outlet_type='grocery';
 -- or use group by
select outlet_type, sum(outlet_sales) from outlet group by outlet_type;

select outlet_type, max(outlet_sales) from outlet group by outlet_type;
select outlet_type, outlet_sales from outlet where outlet_type='supermarket';

select outlet_type, count(outlet_id) from outlet group by outlet_type;
select outlet_type, count(outlet_id) from outlet group by outlet_type order by count(outlet_id) desc;

select outlet_type, count(outlet_id) from outlet group by outlet_type having count(outlet_id) >3 ;

select outlet_type, sum(outlet_sales) from outlet group by outlet_type;
select outlet_type, sum(outlet_sales) from outlet group by outlet_type having sum(outlet_sales) > 15000 ;
select outlet_type, sum(outlet_sales) from outlet group by outlet_type having sum(outlet_sales) < 1500 ;

select outlet_type, outlet_sales from outlet where outlet_sales between 300 and 3000;
/*
outlet_type	outlet_sales
MART		500
MART		1000
grocery		300
grocery		400
*/
select sum(outlet_sales)  from outlet where outlet_sales between 300 and 3000;
/*
			sum(outlet_sales)
			2200
*/
select outlet_type, sum(outlet_sales)  from outlet group by outlet_type having sum(outlet_sales) between 300 and 3000;
/*
outlet_type	sum(outlet_sales)
MART		1500
grocery		700
null		31
*/
select * from outlet order by outlet_sales desc;

select outlet_type, outlet_sales from outlet where outlet_sales >= 1500;
select sum(outlet_sales)  from outlet where outlet_sales >= 1500;
select outlet_type, sum(outlet_sales)  from outlet group by outlet_type ;
select outlet_type, sum(outlet_sales)  from outlet group by outlet_type having sum(outlet_sales) >= 1500;
