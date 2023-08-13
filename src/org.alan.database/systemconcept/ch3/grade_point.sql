
create table grade_points
(grade			varchar(2),
 points			numeric(2,1) check (points >= 0),
 primary key (grade),
 foreign key (grade) references takes (grade)
);

insert into grade_points values( 'A+', 4.3 );
insert into grade_points values( 'A' , 4   );
insert into grade_points values( 'A-', 3.7 );
insert into grade_points values( 'B+', 3.3 );
insert into grade_points values( 'B' , 3   );
insert into grade_points values( 'B-', 2.7 );
insert into grade_points values( 'C+', 2.3 );
insert into grade_points values( 'C' , 2   );
insert into grade_points values( 'C-', 1.7 );
insert into grade_points values( 'D+', 1.3 );
insert into grade_points values( 'D' , 1   );
insert into grade_points values( 'D-', 0.7 );
insert into grade_points values( 'F' , 0   );

## add foreign key constraints to takes table for grade from grade_points table
SET foreign_key_checks = 0;
alter table takes add constraint takes_grade_fkey
    foreign key (grade) references grade_points (grade)## on delete set null;
SET foreign_key_checks = 1;

## delete foreign key constraints to takes table for grade from grade_points table
alter table takes drop foreign key takes_grade_fkey;