## DML insert

INSERT INTO TIME_SLOT (TIME_SLOT_ID, DAY, START_TIME, END_TIME)
VALUES ('TS001', 'Mon', '09:00', '10:30'),
       ('TS002', 'Tue', '11:00', '12:30'),
       ('TS003', 'Wed', '14:00', '15:30'),
       ('TS004', 'Thu', '16:00', '17:30'),
       ('TS005', 'Fri', '13:00', '14:30');

INSERT INTO CLASSROOM (BUILDING, ROOM_NUMBER, CAPACITY)
VALUES ('Science Building', 101, 50),
       ('Science Building', 102, 45),
       ('Life Sciences Building', 201, 60),
       ('Life Sciences Building', 202, 55),
       ('Math Building', 301, 40),
       ('Math Building', 302, 35),
       ('Social Sciences Building', 101, 30),
       ('Social Sciences Building', 102, 25),
       ('Humanities Building', 201, 20),
       ('Humanities Building', 202, 15);

INSERT INTO DEPARTMENT (DEPT_NAME, BUILDING, BUDGET)
VALUES ('Computer Science', 'Science Building', 100000),
       ('Biology', 'Life Sciences Building', 80000),
       ('Mathematics', 'Math Building', 75000),
       ('Psychology', 'Social Sciences Building', 90000),
       ('History', 'Humanities Building', 70000);

INSERT INTO STUDENT (ID, NAME, DEPT_NAME, TOT_CREDIT)
VALUES (10001, 'John Doe', 'Computer Science', 60),
       (10002, 'Jane Smith', 'Biology', 45),
       (10003, 'Michael Johnson', 'Mathematics', 50),
       (10004, 'Emily Williams', 'Psychology', 55),
       (10005, 'David Lee', 'History', 48);

INSERT INTO INSTRUCTOR (ID, NAME, DEPT_NAME, SALARY)
VALUES (20001, 'Professor Adams', 'Computer Science', 80000),
       (20002, 'Professor Brown', 'Biology', 75000),
       (20003, 'Professor Clark', 'Mathematics', 85000),
       (20004, 'Professor Davis', 'Psychology', 78000),
       (20005, 'Professor Evans', 'History', 72000);

INSERT INTO ADVISOR (S_ID, I_ID)
VALUES (10001, 20001),
       (10002, 20002),
       (10003, 20003),
       (10004, 20004),
       (10005, 20005);

INSERT INTO COURSE (COURSE_ID, TITLE, DEPT_NAME, CREDITS)
VALUES ('CS101', 'Introduction to Computer Science', 'Computer Science', 3),
       ('BIO101', 'Biology Fundamentals', 'Biology', 4),
       ('MATH201', 'Calculus I', 'Mathematics', 4),
       ('PSY101', 'Introduction to Psychology', 'Psychology', 3),
       ('HIST102', 'World History', 'History', 3);

INSERT INTO PREREQ (COURSE_ID, PREREQ_ID)
VALUES ('CS101', 'MATH201'),
       ('BIO101', NULL),
       ('MATH201', NULL),
       ('PSY101', 'CS101'),
       ('HIST102', NULL);

INSERT INTO SECTION (COURSE_ID, SEC_ID, SEMESTER, YEAR, BUILDING, ROOM_NUMBER, TIME_SLOT_ID)
VALUES ('CS101', '001', 'Fall', 2023, 'Science Building', 101, 'TS001'),
       ('BIO101', '001', 'Fall', 2023, 'Life Sciences Building', 201, 'TS002'),
       ('MATH201', '001', 'Fall', 2023, 'Math Building', 301, 'TS003'),
       ('PSY101', '001', 'Fall', 2023, 'Social Sciences Building', 102, 'TS004'),
       ('HIST102', '001', 'Fall', 2023, 'Humanities Building', 202, 'TS005');


INSERT INTO TEACHES (ID, COURSE_ID, SEC_ID, SEMESTER, YEAR)
VALUES (20001, 'CS101', '001', 'Fall', 2023),
       (20002, 'BIO101', '001', 'Fall', 2023),
       (20003, 'MATH201', '001', 'Fall', 2023),
       (20004, 'PSY101', '001', 'Fall', 2023),
       (20005, 'HIST102', '001', 'Fall', 2023);

INSERT INTO TAKES (ID, COURSE_ID, SEC_ID, SEMESTER, YEAR, GRADE)
VALUES (10001, 'CS101', '001', 'Fall', 2023, 'A'),
       (10002, 'BIO101', '001', 'Fall', 2023, 'B+'),
       (10003, 'MATH201', '001', 'Fall', 2023, 'A-'),
       (10004, 'PSY101', '001', 'Fall', 2023, 'B'),
       (10005, 'HIST102', '001', 'Fall', 2023, 'A');

