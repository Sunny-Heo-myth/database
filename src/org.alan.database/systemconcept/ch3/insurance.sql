create schema insurance;

use insurance;

create table person
(
    driver_id varchar(30) primary key,
    name varchar(10),
    address varchar(50)
);

create table car
(
    licence_plate varchar(10) primary key,
    model varchar(30),
    year year(4)
);

create table accident
(
    report_number varchar(30) primary key,
    year year(4),
    location varchar(50)
);

create table owns
(
    driver_id varchar(30),
    licence_plate varchar(10),
    primary key (driver_id, licence_plate),
    foreign key (driver_id) references person (driver_id),
    foreign key (licence_plate) references car (licence_plate)
);

create table participated
(
    report_number varchar(30),
    licence_plate varchar(10),
    driver_id     varchar(30),
    damage_amount NUMERIC(12),
    primary key (report_number, licence_plate),
    foreign key (report_number) references accident (report_number),
    foreign key (driver_id) references person (driver_id),
    foreign key (licence_plate) references car (licence_plate)
);
