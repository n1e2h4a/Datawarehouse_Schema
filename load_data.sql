
STEPS:--------------------

create database mytask;
use mytask;
create table city(cityid int primary key,city_description varchar(255));

create table employees(empid int primary key,firstname varchar(255));

create table country(countryid int primary key,countrydescription varchar(255));

create table product(productid int primary key,productname varchar(255));

create table sales(productid int primary key,totalquantity int ,sales int);

#create 5 csv file.

#and load data on that table.

LOAD DATA LOCAL INFILE '/home/niharika/Desktop/city.csv' 
INTO TABLE city
FIELDS TERMINATED BY ',' 
ENCLOSED BY "'"
LINES TERMINATED BY '\n';


LOAD DATA LOCAL INFILE '/home/niharika/Desktop/employees.csv' 
INTO TABLE employees
FIELDS TERMINATED BY ',' 
ENCLOSED BY "'"
LINES TERMINATED BY '\n';


LOAD DATA LOCAL INFILE '/home/niharika/Desktop/country.csv' 
INTO TABLE country
FIELDS TERMINATED BY ',' 
ENCLOSED BY "'"
LINES TERMINATED BY '\n';


LOAD DATA LOCAL INFILE '/home/niharika/Desktop/product.csv' 
INTO TABLE product
FIELDS TERMINATED BY ',' 
ENCLOSED BY "'"
LINES TERMINATED BY '\n';



LOAD DATA LOCAL INFILE '/home/niharika/Desktop/sales.csv' 
INTO TABLE sales
FIELDS TERMINATED BY ',' 
ENCLOSED BY "'"
LINES TERMINATED BY '\n';



#create fact table and load data

create table fact(cityid int,empid int,countryid int,productid int,totalquantity int,sales int,FOREIGN KEY (cityid) REFERENCES city(cityid),FOREIGN KEY (empid) REFERENCES employees(empid),FOREIGN KEY (countryid) REFERENCES country(countryid),FOREIGN KEY (productid) REFERENCES product(productid));

insert into fact (
SELECT c.cityid, e.empid, c1.countryid, p.productid, s.totalquantity, s.sales FROM city as c, employees as e, country as c1, product as p, sales as s  where c.cityid = e.empid AND c1.countryid = p.productid AND p.productid = s.productid);


