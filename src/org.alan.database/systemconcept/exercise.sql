
## 3.1.a
select title
from course
where dept_name = 'Comp. Sci.' and credits = 3;

## 3.1.b
select distinct student.ID
from student, advisor, instructor
where student.id = advisor.s_ID
  and advisor.i_ID = instructor.ID
  and instructor.name = 'Einstein';

## 3.1.c
select max(salary)
from instructor;

## 3.1.d
select *
from instructor
where salary = (select max(salary)
                from instructor);

## 3.1.e
select course_id, sec_id, semester, year, count(*)
from takes t
where (t.course_id, t.sec_id, t.semester, t.year) in
      (select course_id, sec_id, semester, year
       from section
       where year = 2017 and semester = 'Fall')
group by course_id, sec_id, semester, year;

# 3.1.f
select max(count_takes.cnt) as answer
from (select s.course_id, s.sec_id, s.semester, s.year, count(*) as cnt
      from section s,
           takes t
      where s.course_id = t.course_id
        and s.sec_id = t.sec_id
        and s.semester = t.semester
        and s.year = t.year
        and s.year = 2017
        and s.semester = 'Fall'
      group by s.course_id, s.sec_id, s.semester, s.year) as count_takes;

# 3.1.g
with count_takes as
    (select s.course_id, s.sec_id, s.semester, s.year, count(*) as cnt
     from section s, takes t
     where s.course_id = t.course_id
       and s.sec_id = t.sec_id
       and s.semester = t.semester
       and s.year = t.year
       and s.year = 2017
       and s.semester = 'Fall'
     group by s.course_id, s.sec_id, s.semester, s.year)
select st.course_id, st.sec_id, st.semester, st.year
from count_takes st
where st.cnt = (select max(count_takes.cnt)
                from count_takes);

# 3.2.a
select sum(grade_points.points * course.credits)
from takes, grade_points, course
where takes.grade = grade_points.grade
  and takes.course_id = course.course_id
  and takes.ID = '12345';

# 3.2.b
select sum(grade_points.points * course.credits) / sum(course.credits)
from takes, grade_points, course
where takes.grade = grade_points.grade
  and takes.course_id = course.course_id
  and takes.ID = '12345';

# 3.2.c
select takes.ID, sum(grade_points.points * course.credits) / sum(course.credits) as gpa
from takes, grade_points, course, student
where takes.grade = grade_points.grade
  and takes.course_id = course.course_id
  and takes.ID = student.ID
group by takes.ID;

# 3.2.d
select takes.ID, sum(grade_points.points * course.credits) / sum(course.credits) as gpa
from takes, grade_points, course, student
where COALESCE(takes.grade, 'F') = grade_points.grade
  and takes.course_id = course.course_id
  and takes.ID = student.ID
group by takes.ID;

# 3.3.a
update instructor
set salary = salary * 1.1
where dept_name = 'Comp. Sci.';
## ROLLBACK
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

# 3.9.a Find the ID, name, and city of residence of each employee who works for “First Bank Corporation”.
select e.ID, e.person_name, e.city
from employee e, works w
where e.ID = w.id
  and w.company_name = 'First Bank Corporation';

# 3.9.b Find the ID, name, and city of residence of each employee who works for “First Bank Corporation” and earns more than $10000.
select e.ID, e.person_name, e.city
from employee e, works w
where e.ID = w.id
  and w.company_name = 'First Bank Corporation'
  and w.salary > 10000;

# 3.9.c Find the ID of each employee who does not work for “First Bank Corporation”.
select ID
from employee
where ID not in (select w.ID
                 from works w
                 where w.company_name = 'First Bank Corporation');

# 3.9.d Find the ID of each employee who earns more than every employee of “Small Bank Corporation”.
select ID
from works
where salary > all (select salary
                    from works
                    where company_name = 'Small Bank Corporation');

# *** 3.9.e Assume that companies may be located in several cities. (City is also an attribute of pk.)
# Find the name of each company that is located in every city in which “Small Bank Corporation” is located.
select a.company_name
from company a
where not exists (select *
                  from company b
                  where b.company_name = 'Small Bank Corporation'
                    and b.city not in (select c.city
                                       from company c
                                       where c.city = a.city));

# select S.company_name
# from company as S
# where not exists ((select city
#                    from company
#                    where company_name = 'Small Bank Corporation')
#                    except
#                   (select city
#                    from company as T
#                    where S.company_name = T.company_name))

# 3.9.f Find the name of the company that has the most employees
# (or companies, in the case where there is a tie for the most).
with x as (
    select c.company_name as name, count(*) as head_count
    from company c, works w
    where c.company_name = w.company_name
    group by c.company_name
)
select name
from x
where head_count = (select max(head_count)
                    from x);

# 3.9.g Find the name of each company whose employees earn a higher salary, on average,
# than the average salary at “First Bank Corporation”.
select average.company_name
from (select c.company_name as company_name, avg(w.salary) as avg_salary
      from company c,
           works w
      where c.company_name = w.company_name
      group by c.company_name) as average
where average.avg_salary > (select avg(salary) as average_salary
                            from company c,
                                 works w
                            where c.company_name = w.company_name
                              and c.company_name = 'First Bank Corporation');

# 3.10.a Modify the database so that the employee whose ID is '12345' now lives in “Newtown”.
update employee e
set city = 'Newtown'
where e.ID = '12345';

# 3.10.b Give each manager of “First Bank Corporation” a 10 percent raise unless the salary becomes greater than $100000;
# in such cases, give only a 3 percent raise.
update employee e, manages m, works w
set w.salary = IF(w.salary <= 90909, w.salary * 1.1, w.salary * 1.03)
where e.ID = m.manager_id
  and e.ID = w.ID
  and w.company_name = 'First Bank Corporation';
