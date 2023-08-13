
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