
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



select *
from instructor
where dept_name = 'Comp. Sci.';