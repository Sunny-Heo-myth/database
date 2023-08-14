create table branch
(
    branch_name varchar(20) primary key,
    branch_city varchar(20),
    assets int
);

create table customer
(
    ID int primary key,
    customer_name varchar(20),
    customer_street varchar(20),
    customer_city varchar(20)
);

create table loan
(
    loan_number int primary key,
    branch_name varchar(20),
    amount int,
    foreign key (branch_name) references branch(branch_name)
);

create table borrower
(
    ID int,
    loan_number int,
    primary key (ID, loan_number),
    foreign key (ID) references customer (ID),
    foreign key (loan_number) references loan (loan_number)
);

create table account
(
    account_number int primary key,
    branch_name varchar(20),
    balance int,
    foreign key (branch_name) references branch (branch_name)
);

create table depositor
(
    ID int,
    account_number int,
    primary key (ID, account_number),
    foreign key (ID) references customer (ID),
    foreign key (account_number) references account (account_number)
);