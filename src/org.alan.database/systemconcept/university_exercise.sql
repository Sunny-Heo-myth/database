
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
## ROLLBACK
insert into course values ('BIO-399', 'Computational Biology', 'Biology', '3');

# 3.3.c
# Insert every student whose tot cred attribute is greater than 100 as an instructor in the same department, with a salary of $10,000.
# alter table instructor drop constraint instructor_chk_1;
insert into instructor (id, name, dept_name, salary)
select id, name, dept_name, 10000 as salary
from student
where tot_cred > 100;

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

# 3.11.a
# Find the ID and name of each student who has taken at least one Comp. Sci. course;
# make sure there are no duplicate names in the result.
select distinct st.ID, st.name
from student st,
     takes t,
     section s,
     course c
where st.ID = t.ID
  and t.course_id = s.course_id
  and t.sec_id = s.sec_id
  and t.semester = s.semester
  and t.year = s.year
  and s.course_id = c.course_id
  and c.dept_name = 'Comp. Sci.';

# 3.11.b
# Find the ID and name of each student who has not taken any course offered before 2017.
select stu.ID, stu.name
from student stu
where stu.ID not in (select st.ID
                     from student st,
                          takes t,
                          section s
                     where st.ID = t.ID
                       and t.course_id = s.course_id
                       and t.sec_id = s.sec_id
                       and t.year = s.year
                       and t.semester = s.semester
                       and s.year < '2017');

# 3.11.c
# For each department, find the maximum salary of instructors in that department.
# You may assume that every department has at least one instructor.
select d.dept_name d_name, max(i.salary) max_salary
from instructor i, department d
where i.dept_name = d.dept_name
group by d.dept_name;

# 3.11.d
# Find the lowest, across all departments, of the per-department maximum salary computed by the preceding query.
with t as
         (select d.dept_name d_name, max(i.salary) max_salary
          from instructor i,
               department d
          where i.dept_name = d.dept_name
          group by d.dept_name)
select min(max_salary)
from t;

# 3.12.a
# Create a new course “CS-001”, titled “Weekly Seminar”, with 0 credits.
insert into course value ('CS-001', 'Weekly Seminar', 'Comp. Sci.', 0);

# 3.12.b
# Create a section of this course in Fall 2017, with sec id of 1,
# and with the location of this section not yet specified.
insert into section value ('CS-001', 1, 'Fall', '2017', null, null, null);

# 3.12.c
# Enroll every student in the Comp. Sci. department in the above section.
insert into takes (select s.ID, 'CS-001', 1, 'Fall', '2017', 'A+'
                   from student s
                   where s.dept_name = 'Comp. Sci.');

# 3.12.d
# Delete enrollments in the above section where the student’s ID is 12345.
delete
from takes
where ID = '12345'
  and course_id = 'CS-001'
  and sec_id = 1
  and semester = 'Fall'
  and year = '2017';

# 3.12.e
# Delete the course CS-001.
# What will happen if you run this delete statement without first deleting offerings (sections) of this course?
delete from course where course_id = 'CS-001';
# Foreign Key constraint of course_id at section relation would throw an constraint violation error
# since there is still section record which has it's course_id attribute as 'CS-001'.

# 3.12.f
# Delete all takes tuples corresponding to any section of any course with the word “advanced” as a part of the title;
# ignore case when matching the word with the title.
delete
from takes
where course_id in (select course_id
                    from course
                    where lower(title) like '%advanced%');


