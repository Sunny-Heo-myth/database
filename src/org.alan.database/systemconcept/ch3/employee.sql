create schema employee;

use employee;

create table employee
(
    ID int primary key,
    person_name varchar(30),
    street varchar(30),
    city varchar(30)
);

create table company
(
    company_name varchar(30) primary key,
    city varchar(30)
);

create table works
(
    ID int primary key,
    company_name varchar(30),
    salary int,
    foreign key (ID) references employee(ID),
    foreign key (company_name) references company(company_name)
);

create table manages
(
    ID int primary key,
    manager_id int,
    foreign key (ID) references employee(ID),
    foreign key (manager_id) references employee(ID)
);