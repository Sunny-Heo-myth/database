## truncate all tables
set FOREIGN_KEY_CHECKS = 0;
truncate table TAKES;
truncate table TEACHES;
truncate table SECTION;
truncate table PREREQ;
truncate table COURSE;
truncate table ADVISOR;
truncate table INSTRUCTOR;
truncate table STUDENT;
truncate table CLASSROOM;
truncate table DEPARTMENT;
truncate table TIME_SLOT;
set FOREIGN_KEY_CHECKS = 1;