
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

# 3.5.a Display the grade for each student, based on the marks relation.


select ID,
    case when score < 40 then 'F'
        when score >= 40 and score < 60 then 'C'
        when score>= 60 and score < 80 then 'B'
        else 'A'
    end as grade
from marks;

# 3.5.b
select grade, count(*) as cnt
from (
    select ID,
        case when score < 40 then 'F'
             when score >= 40 and score < 60 then 'C'
             when score >= 60 and score < 80 then 'B'
             else 'A'
            end as grade
    from marks
    ) as student_grade
group by grade;

with student_grade (ID, grade) as (
    select ID, case
               when score < 40 then 'F'
               when score >= 40 and score < 60 then 'C'
               when score >= 60 and score < 80 then 'B'
               else 'A'
               end
    from marks
    )
select grade, count(*) as cnt
from student_grade
group by grade;

# 3.6
select dept_name
from department
where lower(dept_name) like '%sci%';

# 3.7
# p.a1 is either null or not.
# r1.a1 or r2.a1 are also either null or not.
# when there is null in predicate database exclude the case.
# So p.a1 and either r1.a1 or r2.a1 both should not be null.
# For the rest cases, if p.a1 = r1.a1 or p.a1 = r2.a1 the cartesian product record will appear as a record.

# 3.8.a Find the ID of each customer of the bank who has an account but not a loan.
select c.ID
from customer c, borrower b, depositor d
where c.ID = b.ID
  and c.ID = d.ID
  and c.ID not in (
    select ID
    from borrower
    )
  and (
    select count(*)
    from depositor dd
    where c.ID = dd.ID
    ) = 1;
# lateral?

# 3.8.b Find the ID of each customer who lives on the same street and in the same city as customer '12345'.
select c1.ID
from customer c1
where (customer_street, customer_city) = (select customer_street, customer_city
                                          from customer c2
                                          where c2.ID = '12345');

# 3.8.c Find the name of each branch that has at least one customer who has an account in the bank and who lives in “Harrison”.
select distinct b.branch_name
from branch b, account a, depositor d, customer c
where b.branch_name = a.branch_name
  and a.account_number = d.account_number
  and d.ID = c.ID
  and c.customer_city = 'Harrison';
