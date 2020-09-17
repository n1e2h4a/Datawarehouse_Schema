create database snowflake;
use snowflake;

create table place(cityid int primary key,city_description varchar(255), countryid int,
countrydescription varchar(255));

create table country(countryid int primary key, countrydescription varchar(45));

create table employees(empid int primary key,firstname varchar(255));


create table product(productid int primary key,productname varchar(255), totalquantity int, 
sales int);



create table sale(totalquantity int primary key, sales int);

create table fact(cityid int, empid int, productid int, totalquantity int, sales int,
FOREIGN KEY (cityid)
REFERENCES place(cityid),FOREIGN KEY (empid) REFERENCES employees(empid),
FOREIGN KEY (productid) REFERENCES product(productid));



LOAD DATA LOCAL INFILE '/home/niharika/Desktop/EVERYTHING/schemacsv/place.csv' 
INTO TABLE place
FIELDS TERMINATED BY ',' 
ENCLOSED BY "'"
LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE '/home/niharika/Desktop/EVERYTHING/schemacsv/employees.csv' 
INTO TABLE employees
FIELDS TERMINATED BY ',' 
ENCLOSED BY "'"
LINES TERMINATED BY '\n';

LOAD DATA LOCAL INFILE '/home/niharika/Desktop/EVERYTHING/schemacsv/product.csv' 
INTO TABLE product
FIELDS TERMINATED BY ',' 
ENCLOSED BY "'"
LINES TERMINATED BY '\n';


insert into fact(
SELECT l.cityid, e.empid, p.productid, p.totalquantity, p.sales FROM place as l,
employees as e, product as p where l.cityid = e.empid AND e.empid = p.productid);

AlTER TABLE sale ADD FOREIGN KEY (totalquantity)REFERENCES product(totalquantity);

AlTER TABLE country ADD FOREIGN KEY (countryid)REFERENCES place(countryid);


insert into country (
select countryid, countrydescription from place
);

insert into sale (
select totalquantity, sales from product
);

