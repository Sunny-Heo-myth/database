
# 3.1.e
select course_id, sec_id, semester, year, count(id)
from takes
where semester = 'Fall' and year = 2017
group by course_id, sec_id, semester, year;

# 3.1.f
select max(num) as max_enrollment
from (
    select count(*) as num
    from takes
    where semester = 'Fall' and year = 2017
    group by course_id, sec_id, semester, year
    ) as temp;

# 3.1.g
with temp as (
    select course_id, sec_id, semester, year, count(*) as num
    from takes
    where semester = 'Fall' and year = 2017
    group by course_id, sec_id, semester, year
)
select course_id, sec_id, semester, year
from temp
where num = (
    select max(num)
    from temp
);

# 3.2.a
select sum(points) as total_points
from takes, grade_points
where takes.grade = grade_points.grade and id = '12345';

# 3.2.b
select avg(points) as average_points
from takes, grade_points
where takes.grade = grade_points.grade and id = '12345';

# 3.2.c
select ID, avg(points) as average_points
from takes, grade_points
where takes.grade = grade_points.grade
group by ID;

# 3.2.d
select *
from takes
where grade is null;

# 3.3.a
update instructor
set salary = salary * 1.1
where dept_name = 'Comp. Sci.';
# rollback
update instructor
set salary = salary * 1 / 1.1
where dept_name = 'Comp. Sci.';

# 3.3.b
delete from course
where course.course_id not in (
    select course_id
    from section
);
# rollback
insert into course values ('BIO-399', 'Computational Biology', 'Biology', '3');

# 3.3.c Insert every student whose tot cred attribute is greater than 100 as an instructor in the same department, with a salary of $10,000.
# alter table instructor drop constraint instructor_chk_1;
insert into instructor (id, name, dept_name, salary)
select id, name, dept_name, 10000 as salary
from student
where tot_cred > 100;

# 3.4.a Find the total number of people who owned cars that were involved in accidents in 2017.
select count(distinct x.pid) as cnt
from (select p.driver_id as pid
      from person p,
           owns o,
           car c,
           participated pt,
           accident a
      where p.driver_id = o.driver_id
        and o.licence_plate = c.licence_plate
        and c.licence_plate = pt.licence_plate
        and pt.report_number = a.report_number
        and a.year = 2017
      group by pid) as x;

# 3.4.b Delete all year-2010 cars belonging to the person whose ID is '12345'.
delete from car
where licence_plate in (
select c.licence_plate
from (select * from car) as c, owns o, person p # mysql problem
where c.licence_plate = o.licence_plate
  and o.driver_id = p.driver_id
  and p.driver_id = '12345'
  and c.year = '2010'
);

