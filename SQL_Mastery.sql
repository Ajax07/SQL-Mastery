DROP TABLE IF EXISTS users;
CREATE TABLE users(
	userID int primary key,
	name varchar(50) not null,
	email varchar(100) unique,
	age integer check (age >= 18),
	reg_date TIMESTAMP DEFAULT current_timestamp
);
--inserting data into table
insert into users(userID, name, email, age)
values(1,'john','john@gmail.com',25);

insert into users(userID, name, email, age)
values(2,'john','john1@gmail.com',25);

select * from users;


--create the user2 table for data update
CREATE TABLE IF NOT EXISTS users2(
	userID int primary key,
	name varchar(50) not null,
	email varchar(100) unique,
	age integer check (age >= 18),
	city varchar(20)
);

insert into users2(userID, name, email, age)
values(1,'john','john@gmail.com',25),
(2,'john','john1@gmail.com',25);

update users2
set city='pune'
where name='john';


update users2
set age=31, city='kolkata'
where userID = 2;

select userID,city from users2;

select * from users2 order by userID ASC;

--Delete
delete from users where userID=6;

--To rename the username column to Full_Name
alter table users
rename column userID to user_id;

--To change the age column's data type INT to smalINT
alter table users
alter column age type smallint;

--to add a not null constraint to city column
alter table users2
alter column city set not null;

--adding check constraint to age column
alter table users2
add constraint age check(age>18);

--drop constraint
alter table users
add constraint age check(age>=18)

select * from customers;

--change table name 
alter table users
rename to customers;

-- Import csv file into SQL
drop table if exists employee2;

create table employee2(
	employee_id INT primary key,
	first_name varchar(20) not null,
	last_name varchar(20) not null,
	department varchar(20),
	salary numeric(10,2),
	joining_date DATE,
	age int
);

alter table employee2
alter column joining_date type varchar(20);

copy employee2 (employee_id, first_name, last_name, department, salary, joining_date, age)
FROM '/Users/ajaysinghchouhan/Downloads/employee_data.csv'
DELIMITER ',' CSV HEADER;

select * from employee2;


-- Operator :

--retrieve the first name, salary, and, calculate a 10% bonus on the salary
select first_name, salary, (0.1 * salary) as bonus from employee2;

--calc the annual sal and sal inc by 5% show monthly new sal as well
select first_name, (12*salary) as annual_sal, (0.5 * salary) as bonus, (0.5*salary + salary) as new_monthly from employee2;

-- comparision operator
select * from employee2 where age = 30;

--matches all except 30
select * from employee2 where age <>30;


-- 1) Retrieve employees whose salary is between 40,000 and 60,000
select * from employee2 where salary between 40000 and 60000;

-- 2) Find employee whose email addresses end with gmail.com
select * from employee2 where department like 'IT';

--3) Retrieve employees who belong to either 'Finance' or 'Marketing'
select * from employee2 where department in('Finance','Marketing');

-- find where the column data is Null (if applicable)

select * from employee2 where department is Null;
-- list employees sorted by salary in Descending order.
select * from employee2 order by salary desc;

-- Retrieve the top 5 highest-paid employee.
select * from employee2 order by salary desc limit 5;

--Retrieve a list of unique departments
select distinct department from employee2;

--set operator
drop table if exists students_2023;
create table students_2023 (
	student_id int primary key,
	student_name varchar(100),
	course varchar(50)
);

insert into students_2023 (student_id, student_name, course) values
(1, 'Aarav','CS'),
(2, 'Ishita','ME'),
(3, 'kabir','EC'),
(4, 'ananya','CE'),
(5, 'Rahul','CS');

select * from students_2023;

drop table if exists students_2024;
create table students_2024 (
	student_id int primary key,
	student_name varchar(100),
	course varchar(50)
);

insert into students_2024 (student_id, student_name, course) values
(1, 'Meera','CS'),
(2, 'sanya','ME'),
(3, 'kabir','EC'),
(4, 'ananya','CE'),
(5, 'vikram','CS');

select * from students_2024;

--union -- combine results, remove duplicates

select * from students_2023 union select * from students_2024;
--union all - combine results, keeps duplicates

select * from students_2023 union all select * from students_2024;
--Intersect - Returns common results in both tables

select * from students_2023 intersect select * from students_2024;
--except --return results in the first table but not in the second table

select * from students_2023 except select * from students_2024;

--Function in SQL (Aggregate function)
drop table if exists products;
create table products (
	product_id SERIAL primary key,
	product_name varchar(30),
	category varchar(50),
	price numeric(10,2),
	quantity int,
	added_date date,
	discount numeric(5,2)
);

insert into products (product_name, category, price, quantity, added_date, discount) values
('laptop','electronics',75000.00,10,'2024-01-15',10.00),
('Phone','electronics',25000.00,25,'2024-01-25',20.00),
('headphone','Accessories',5000.00,50,'2024-01-05',13.00),
('table','furniture',5100.00,20,'2024-01-11',12.00),
('chair','furniture',25000.00,8,'2024-01-10',11.00),
('monitor','electronics',15000.00,9,'2024-01-12',16.00),
('tablet','electronics',35000.00,12,'2024-01-14',17.00);

select * from products;

-- total quantity available of all product
select sum(quantity) as total_quantity from products;

-- with condition
select sum(quantity) as elec_quantity from products
where category='electronics' and price > 20000;

--total number of product
select count(*) from products;

--count with condition

select count(*) AS total_products
from products
where product_name like'%phone%';

--Average price of products
select avg(price) as avg_price
from products;

--avg price of product with specification
select avg(price) as avg_price
from products
where category = 'furniture' or discount > 10;

--STRING function
-- get all the categories in uppercase

select upper(category) as cat_capital
from products;

-- get all the categories in lowercase

select lower(category) as cat_capital
from products;

--concat join product name and category text 
select concat(product_name,'-',category) as pro_details
from products;

--extract the first five char
select substring(product_name,1,5) as five_char
from products;

-- count length
select product_name, length(product_name) as len_product
from products;

--remove leading and trailing spaces
select trim('  mouse ') as trim_name;

--replace the name
select replace(product_name,'Phone','device') as new_name
from products;

-- get the first 3 char from cat.

select left(category,3) as cat_capital
from products;

-- get the last 3 char from cat.

select right(category,3) as cat_capital
from products;

-- Data & Time Functions
-- NOW() - Get Current Date and Time
select now() as current_datetime;

-- current_date() - get current date
select current_date as today_date;

select added_date, current_date, (current_date - added_date) as diff_date
from products;

-- extract - parts of date extract the year, month, and day

select product_name, extract(year from added_date) as year_added,
extract(month from added_date) as month_added,
extract(day from added_date) as day_added
from products;

-- AGE() calc age between dates
-- calc the time diff between added_date and today's date

select product_name, age(current_date, added_date) as age_since_added
from products;

--TO_CHAR() - format dates as string

select product_name, to_char(added_date, 'DD-Mon-YY') as formated_date
from products;

--6. DATE_PART() - Get specific date part
-- extract the day of the week from added_date.

select product_name, added_date,
		date_part('dow', added_date) as day_of_week
from products;

/* Conditional function
1 case function - categorizing based on condition
01 expensive if the price higher>50k moderate if between 10 to 49k
affordable if the price is < 10k */

select product_name, price,
		case
			when price >= 50000 then 'Expensive'
			when price >=10000 and price <49999 then 'Moderate'
			else 'Affordable'
		end as price_category
from products;


/*1 case function - classifying stock status using the CASE statement based on quantity,  */
select * from products;

select product_name, quantity,
		case
			when quantity >= 10 then 'In stock'
			when quantity >=5 and quantity <10 then 'limited stock'
			else 'out of stock soon'
		end as stock_status
from products;

/*1 case function - another for filtering items by category using the LIKE operator. */
select * from products;

select product_name, category,
		case
			when category like 'electronics' then 'electronic item'
			when category like 'furniture' then 'furniture item'
			else 'Accessory item'
		end as category_club
from products;

-- coalesce function handling null value

alter table products
add column discount_price numeric(10,2)

update products
set discount_price = null
where product_name in('laptop','Phone');

update products
set discount_price = price * 0.9
where product_name not in('laptop','Phone');

select product_name,
	coalesce(discount_price, price) as finel_price
from products;


/*Window function perform calculations across a set of 
table rows related to the current row. They are useful for
ranking, calculating running totals, percentages and much more.
*/

select * from products;
-- assign unique row number to each product within the same category

select product_name, category, price,
	row_number() over (partition by category order by price desc) as row_number
from products;

select product_name, category, price, quantity,
	dense_rank() over (partition by category order by price desc) as rank_number
from products;

select product_name, category, price, quantity,
	sum(price) over (partition by category order by price desc) as sum_number
from products;


-- joins in sql inner, left, right, full, cross, self
drop table  if exists employees3;
create table employees3(
	employee_id serial primary key,
	first_name varchar(30),
	last_name varchar(30),
	department_id int
);

insert into employees3 (first_name, last_name, department_id)
values
('rahul', 'sharma', 101),
('priya', 'mehta', 102),
('vijay', 'sharma', 103),
('ajay', 'sharma', NULL),
('aman', 'sharma', 101);

select * from employees3;
drop table if exists departments;
create table departments (
	department_id int primary key,
	department_name varchar(20)
);

insert into departments(department_id, department_name)
values
(101, 'sales'),
(102, 'Marketing'),
(103, 'IT'),
(104, 'HR')

--inner join
select e.employee_id, e.first_name, 
d.department_id, d.department_name
from employees3 e
inner join
departments d
on e.department_id=d.department_id;


--left join
select e.employee_id, e.first_name, 
d.department_id, d.department_name
from employees3 e
left join
departments d
on e.department_id=d.department_id;

--right join
select e.employee_id, e.first_name, 
d.department_id, d.department_name
from employees3 e
right join
departments d
on e.department_id=d.department_id;

--full outer join
select e.employee_id, e.first_name, 
d.department_id, d.department_name
from employees3 e
full outer join
departments d
on e.department_id=d.department_id;

--cross join all possible matches
select e.employee_id, e.first_name, 
d.department_id, d.department_name
from employees3 e
cross join
departments d;

--self join

select e1.first_name as emp_name1,
e2.first_name as emp_name2,
d.department_name
from employees3 e1 join employees3 e2
on e1.department_id=e2.department_id 
and  e1.employee_id != e2.employee_id
join
departments d
on
e1.department_id = d.department_id;



