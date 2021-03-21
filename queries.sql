/* Queries 

*/
use sql_workshop;
-- find people whose name starts with 'Ra'
Select * from columbia_people where name_first like 'RA%' ;


-- find get professors, non-confidential info about them, and the number of advisees they have
select t.name_first, t.name_last, o.uni,o.status,o.advisees from
(
select 
	p.uni,
	p.status, 
    p.department,
	IFNULL(advisees,0) as advisees 
from professor p
left outer join
(select advisor, count(advisor) as advisees from student group by advisor ) a
on p.uni = a.advisor
) o
inner join 
(select uni,name_first,name_last from columbia_people where role = "professor") t
on o.uni=t.uni


-- select count(*) from columbia_people where LEFT(uni, 2)='df';