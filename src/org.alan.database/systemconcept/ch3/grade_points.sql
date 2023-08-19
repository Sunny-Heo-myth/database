create table grade_points
    (grade			varchar(2),
     points			DECIMAL(2,1),
     primary key (grade)
    );

insert into grade_points values ('A+', 4.3);
insert into grade_points values ('A', 4.0);
insert into grade_points values ('A-', 3.7);
insert into grade_points values ('B+', 3.3);
insert into grade_points values ('B', 3.0);
insert into grade_points values ('B-', 2.7);
insert into grade_points values ('C+', 2.3);
insert into grade_points values ('C', 2.0);
insert into grade_points values ('C-', 1.7);
insert into grade_points values ('D+', 1.3);
insert into grade_points values ('D', 1.0);
insert into grade_points values ('D-', 0.7);
insert into grade_points values ('F', 0.0);