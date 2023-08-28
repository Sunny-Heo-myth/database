create schema university;

use university;

drop table if exists prereq;
drop table if exists time_slot;
drop table if exists advisor;
drop table if exists takes;
drop table if exists student;
drop table if exists teaches;
drop table if exists section;
drop table if exists instructor;
drop table if exists course;
drop table if exists department;
drop table if exists classroom;

## new

## Time table
create table TIME_SLOT(
                          TIME_SLOT_ID varchar(8),
                          DAY varchar(3) check (DAY in ('Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun')),
                          START_TIME TIME,
                          END_TIME TIME,
                          PRIMARY KEY(TIME_SLOT_ID, DAY, START_TIME)
);

create table CLASSROOM(
                          BUILDING varchar(30),
                          ROOM_NUMBER numeric(3),
                          CAPACITY numeric(3),
                          PRIMARY KEY(BUILDING, ROOM_NUMBER)
);

create table DEPARTMENT(
                           DEPT_NAME varchar(20),
                           BUILDING varchar(30),
                           BUDGET numeric(12),
                           PRIMARY KEY(DEPT_NAME),
                           FOREIGN KEY(BUILDING) REFERENCES CLASSROOM(BUILDING) ON DELETE CASCADE
);

create table STUDENT(
                        ID numeric(5),
                        NAME varchar(20),
                        DEPT_NAME varchar(20),
                        TOT_CREDIT numeric(3),
                        PRIMARY KEY(ID),
                        FOREIGN KEY(DEPT_NAME) REFERENCES DEPARTMENT(DEPT_NAME) ON DELETE CASCADE
);

create table INSTRUCTOR(
                           ID numeric(5),
                           NAME varchar(20),
                           DEPT_NAME varchar(20),
                           SALARY numeric(7),
                           PRIMARY KEY(ID),
                           FOREIGN KEY(DEPT_NAME) REFERENCES DEPARTMENT(DEPT_NAME) ON DELETE CASCADE
);

create table ADVISOR(
                        S_ID numeric(5),
                        I_ID numeric(5),
                        PRIMARY KEY(S_ID),
                        FOREIGN KEY(S_ID) REFERENCES STUDENT(ID) ON DELETE CASCADE,
                        FOREIGN KEY(I_ID) REFERENCES INSTRUCTOR(ID) ON DELETE CASCADE
);

create table COURSE(
                       COURSE_ID varchar(8),
                       TITLE varchar(50),
                       DEPT_NAME varchar(20),
                       CREDITS numeric(2),
                       PRIMARY KEY(COURSE_ID),
                       FOREIGN KEY(DEPT_NAME) REFERENCES DEPARTMENT(DEPT_NAME) ON DELETE CASCADE
);

## Course prerequisite
create table PREREQ(
                       COURSE_ID varchar(8),
                       PREREQ_ID varchar(8) NULL,
                       UNIQUE (COURSE_ID, PREREQ_ID),
                       FOREIGN KEY(COURSE_ID) REFERENCES COURSE(COURSE_ID) ON DELETE CASCADE,
                       FOREIGN KEY(PREREQ_ID) REFERENCES COURSE(COURSE_ID) ON DELETE CASCADE
);

## Unit of teaching section of a course
create table SECTION(
                        COURSE_ID varchar(8),
                        SEC_ID varchar(8),
                        SEMESTER varchar(6),
                        YEAR YEAR,
                        BUILDING varchar(30),
                        ROOM_NUMBER numeric(3),
                        TIME_SLOT_ID varchar(8),
                        PRIMARY KEY(COURSE_ID, SEC_ID, SEMESTER, YEAR),
                        FOREIGN KEY(COURSE_ID) REFERENCES COURSE(COURSE_ID) ON DELETE CASCADE,
                        FOREIGN KEY(TIME_SLOT_ID) REFERENCES TIME_SLOT(TIME_SLOT_ID) ON DELETE CASCADE,   ##Referencial Integrity Constraint
                        FOREIGN KEY(BUILDING, ROOM_NUMBER) REFERENCES CLASSROOM(BUILDING, ROOM_NUMBER) ON DELETE CASCADE
);

## Table between INSTRUCTOR and SECTION
create table TEACHES(
                        ID numeric(5),
                        COURSE_ID varchar(8),
                        SEC_ID varchar(8),
                        SEMESTER varchar(6),
                        YEAR YEAR,
                        PRIMARY KEY(ID, COURSE_ID, SEC_ID, SEMESTER, YEAR),
                        FOREIGN KEY(ID) REFERENCES INSTRUCTOR(ID) ON DELETE CASCADE,
                        FOREIGN KEY(COURSE_ID, SEC_ID, SEMESTER, YEAR) REFERENCES SECTION(COURSE_ID, SEC_ID, SEMESTER, YEAR) ON DELETE CASCADE
);

## Table between STUDENT and SECTION
create table TAKES(
                      ID numeric(5),
                      COURSE_ID varchar(8),
                      SEC_ID varchar(8),
                      SEMESTER varchar(6),
                      YEAR YEAR,
                      GRADE varchar(2),
                      PRIMARY KEY(ID, COURSE_ID, SEC_ID, SEMESTER, YEAR),
                      FOREIGN KEY(ID) REFERENCES STUDENT(ID) ON DELETE CASCADE,
                      FOREIGN KEY(COURSE_ID, SEC_ID, SEMESTER, YEAR) REFERENCES SECTION(COURSE_ID, SEC_ID, SEMESTER, YEAR) ON DELETE CASCADE
);

create table grade_points
(
    grade			varchar(2),
    points			DECIMAL(2,1),
    primary key (grade)
);

## add foreign key constraints to takes table for grade from grade_points table
SET foreign_key_checks = 0;
alter table takes add constraint takes_grade_fkey
    foreign key (grade) references grade_points (grade) ## on delete set null;
SET foreign_key_checks = 1;

create table marks
(
    ID varchar(30) primary key,
    score numeric(2)
);