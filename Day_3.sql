describe outlet;

-- add columns
alter table outlet add outlet_year_opened int default 1500;
describe outlet;

select * from outlet;

-- fill data
update outlet set outlet_year_opened  = 2000;

-- drop the column
alter table outlet drop outlet_year_opened;  

insert into outlet values (107,'grocery',300,2022);
insert into outlet(outlet_id, outlet_type, outlet_sales) values (109,'stall',100);

alter table outlet modify outlet_year_opened int;

-- find pattern in data
select * from outlet where outlet_type = 'supermarket';
select * from outlet where outlet_type like '%market%'; 
/* difference 1 char at the end after "supermarket"
 supermarket1
 supermarket2
 supermarket3
 */
 select * from outlet where outlet_type like 'supermarket_'; 
/* difference of n char at the end after "supermarket"
 supermarket1abc
 supermarket2def
 supermarket3xyz
 */ 
select * from outlet where outlet_type like 'supermarket%';
/* difference of n char at the end after "supermarket"
 supermarket1abc
 supermarket2def
 hypersupermarket3xyz
 */ 
select * from outlet where outlet_type like '%supermarket%';

-- fetch data with m and t
select * from outlet where outlet_type like '%m%t%';

-- fetch data with m and t
select * from outlet where outlet_type like '%m__t%';

-- fetch data with m and t
select * from outlet where outlet_type like '%m____t%';

select * from outlet where outlet_id = 101;
select * from outlet where outlet_id = 101 or outlet_id = 102 or outlet_id = 103;
-- easy option for the OR
select * from outlet where outlet_id in (101,102,103);

select 1;
select 1,2;
select 1 as "c1" ,2 as "c2";
select 1000+2301 as "summation";

select outlet_id as "my_id" from outlet;

select "Test" as "String";

select "samsung" ;
select "samsung" as "dummy_text";
select length("samsung") as "text_length";
select "samsung" as "Text", length("samsung") as "text_length";

select "Samsung",upper("Samsung");
select "Samsung",lower("Samsung");

select repeat('$',10);

select now();
select curdate();
select day(curdate());
select month(curdate());
select year(curdate());

select hour(now());
select minute(now());
select second(now());

select now(), curdate(),day(curdate()),month(curdate()),year(curdate()),hour(now()),minute(now()),second(now());

select 'Samsung', "Samsung";

select outlet_type, length(outlet_type) as type_length  from outlet;

select outlet_type, upper(outlet_type) as "type upper"  from outlet;

select outlet_type, reverse(outlet_type) as "type reverse"  from outlet;

select "samsung", " is a ", "mobile brand";
select concat("samsung", " is a ", "mobile brand");

select outlet_id, outlet_type, concat(outlet_id,"-",outlet_type) as "id_type"  from outlet;

select "samsung is a mobile brand";
select replace("samsung is a mobile brand","mobile","eletronics");

select outlet_type, replace(outlet_type,"super","hyper") as "changed type"  from outlet;

select "  samsung   ";
select "  samsung   ", length("  samsung   ");
select "  samsung   ", length("  samsung   "), ltrim("  samsung   "), length(ltrim("  samsung   "));
select "  samsung   ", length("  samsung   "), rtrim("  samsung   "), length(rtrim("  samsung   "));
select "  samsung   ", length("  samsung   "), trim("  samsung   "), length(trim("  samsung   "));

select "samsung is a mobile brand";
select position("i" in "samsung is a mobile brand");
select position("mobile" in "samsung is a mobile brand");
select position("samsung" in "samsung is a mobile brand");
select position("brand" in "samsung is a mobile brand");

CREATE TABLE Employee (
    Employee_id int ,
    First_name VARCHAR(50),
	Last_name VARCHAR(50),
	Salary int,
	Joining_date Date,
    Departement  VARCHAR(50) 
);
INSERT INTO Employee (Employee_id, First_name, Last_name, Salary, Joining_date, Departement) VALUES (1, ' Bob ', 'Kinto', 1000000, "2019-01-20", "Finance");
INSERT INTO Employee (Employee_id, First_name, Last_name, Salary, Joining_date, Departement) VALUES (2, '  Jerry  ', 'Kansxo', 6000000, "2019-01-15", "IT");
INSERT INTO Employee (Employee_id, First_name, Last_name, Salary, Joining_date, Departement) VALUES (3, '   Philip   ', 'Jose', 8900000, "2019-02-05", "Banking");
INSERT INTO Employee (Employee_id, First_name, Last_name, Salary, Joining_date, Departement) VALUES (4, ' John ', 'Abraham', 2000000, "2019-02-25", "Insurance");
INSERT INTO Employee (Employee_id, First_name, Last_name, Salary, Joining_date, Departement) VALUES (5, '  Michael  ', 'Mathew', 2200000, "2019-02-28", "Finance");
INSERT INTO Employee (Employee_id, First_name, Last_name, Salary, Joining_date, Departement) VALUES (6, '   Alex   ', 'chreketo', 4000000, "2019-05-10", "IT");
INSERT INTO Employee (Employee_id, First_name, Last_name, Salary, Joining_date, Departement) VALUES (7, ' Yohan ', 'Soso', 1230000, "2019-06-20", "Banking");








