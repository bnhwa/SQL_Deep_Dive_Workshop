/*
Spring 2021
SQL Deep Dive Workshop for Columbia Data Science Society by
Bailey Hwa: bnh2128



this file covers intermediate SQL:
DDL(Data Definition Language):
	CREATE – creates the database or its objects (like table, index, function, views, stored procedure and triggers).
	DROP – deletes objects from the database.
	ALTER- alters the structure of the database.
DML(Data Manipulation Language)
	INSERT – inserts data into a table.
	UPDATE – updates existing data within a table.
	DELETE – deletes existing data within a table.
Database Basics
	Manipulation:
	Tables: basic data storage structures that has: 
		Keys:
			Primary: Unique ID of a table entry, cannot be null, can be a single, or combination of different database attributes
			Foreign: Key in one table referencing an existing column attribute in another.
		Constraints: Limits on database entries' values
	Views: cached queries, updates when data updates
    Stored prodcedures: programs that run, often manipulating/loading/data
    Functions: literally just functions
    Permissioning: Statements that can set what users can see and do within the database
    
*/

DROP schema IF EXISTS sql_workshop;
create schema sql_workshop; -- create schema
USE sql_workshop; -- switch to use this schema



/*
 ===============================================================
Create tables and DDL/Insert
 ===============================================================
*/

DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS professor;
DROP TABLE IF EXISTS columbia_people;
DROP TABLE IF EXISTS department;

CREATE TABLE department  (
	dept_key varchar(9) not null,
	department_name varchar(128) not null,
    dept_endowment float default null,
    primary key (dept_key) -- unique identifiers
);

# table of everyone and generic info
CREATE TABLE columbia_people (
	uni varchar(128) not null,
	name_first varchar(128) not null,
	name_last varchar(128) not null,
	role enum ("professor","student"), -- must be either student or professor unless specified otherwise
	department varchar(128) not null,
	primary key (uni),
    FOREIGN KEY (department) references department (dept_key) -- make sure dept exists
    );
    
# columbia professor table:
CREATE TABLE professor (
	uni varchar(128) not null,
    department varchar(128) not null,
    status enum ("lecturer","associate","adjunct","tenured","overlord"),
    salary float not null,
    social_security_number varchar(9),
	primary key (uni),
    FOREIGN KEY (uni) references columbia_people (uni), -- make sure uni exits
    FOREIGN KEY (department) references department (dept_key) -- make sure dept exists
    
);
# student table
CREATE TABLE student (
	uni varchar(128) not null,
    department varchar(128) not null,
    year int not null,
    advisor varchar(128) not null, 
	primary key (uni),
    CONSTRAINT year CHECK (year BETWEEN 1 AND 4), -- ensure that the year is between 1-4
	FOREIGN KEY (uni) references columbia_people (uni),
    FOREIGN KEY (advisor) references professor (uni), -- this constraint ensures that uni of advisor is faculty
    FOREIGN KEY (department) references department (dept_key) -- make sure dept exists
);

INSERT INTO department 
VALUES
("CS","Computer Science",15000000),
("IEOR","Industrial Engineering/Operations Research",12000000),
("ECON","Economics",10000000),
("LAW","Law",300000),
("ENG","English",50);
INSERT INTO columbia_people 
-- made up unis
VALUES
    ("bnh2128","Bailey","Hwa","student","CS"),
    ("eg1232","Eli","Goldin","student","CS"),
    ("amr2221","Amir","Idris","student","CS"),
    ("sa3782","Soo","Ahn","student","IEOR"),
    ("fb2342","Finance","Bro","student","ECON"),
    ("d12324","Dropout","kid","student","ECON"),
    ("rl2311","Random","EnglishMajor1","student","ENG"),
    ("rl2312","Random","EnglishMajor2","student","ENG"),
    ("rl2313","Random","EnglishMajor3","student","ENG"),
    ("rl2314","Random","EnglishMajor4","student","ENG"),
    ("rl2315","Random","EnglishMajor5","student","ENG"),
    ("rl2316","Random","EnglishMajor6","student","ENG"),
    ("ra3454","Rachel","Adams","professor","ENG"),
    ("ja3454","James","Adams","professor","ENG"),
    ("ah123","Ali","Hirsa","professor","ECON"),
    ("ec123","Econ","Prof","professor","ECON"),
	("df0","Donald","Ferguson","professor","CS"),
    ("bs1233","Lee","Bollinger","professor","LAW"),
    ("se1234","Stephen","Edwards","professor","CS"),
    ("jwl1232","Jae","Lee","professor","CS");
    /* below are error causing statements if they were to be run 
    (change the commas and semicolons to proper syntax if u test it out) */
    -- ("bnh2128","Bailey","Hwa","student","CS"), -- duplicate primary key
    
	/*assuming the row with "ja3454" wasn't inserted,  the below will return an error because
    we defined a constraint on the 'department' attribute  in the table 'professor' which as a foreign key
    checks the entered field in the 'department' table. If you look above when values were inserted into the
    department table, there is no "dank_memes" department.
    */
    -- ("ja3454","dank_memes","tenured","300000","asdfasdf8");
    

INSERT INTO professor
-- made up values
values
	("df0","CS","tenured",350000,"asdfasdf1"),
    ("bs1233","LAW","overlord",4000000,"asdfasdf2"), -- prezbo makes 4 mil
    ("se1234","CS","tenured",300000,"asdfasdf3"),
    ("jwl1232","CS","lecturer",50000,"asdfasdf4"),
    ("ec123","ECON","associate",80000,"asdfasdf5"),
    ("ra3454","ENG","tenured","400000","asdfasdf6"),
    ("ja3454","ENG","tenured","200000","asdfasdf7"),
    ("ah123","IEOR","tenured","300000","asdfasdf8");
    /* below are error causing statements if they were to be run 
    (change the commas and semicolons to proper syntax if u test it out) */
    
    

INSERT INTO student 
VALUES
    ("bnh2128","CS",4,"se1234"),
    ("eg1232","CS",4,"jwl1232"),
    ("amr2221","CS",2,"jwl1232"),
    ("sa3782","IEOR",2,"ah123"),
    ("fb2342","ECON",1,"ec123"),
    ("rl2311","ENG",1,"ja3454"),
	("rl2312","ENG",1,"ja3454"),
	("rl2313","ENG",1,"ja3454"),
	("rl2314","ENG",1,"ra3454"),
	("rl2315","ENG",1,"ra3454"),
	("rl2316","ENG",1,"ra3454"),
	("d12324","ECON",1,"ec123"); -- we will be deleting this value


/*
 ===============================================================
DDL Updating and deleting data
 ===============================================================
*/
SET SQL_SAFE_UPDATES = 0; -- mysql requires by default to turn off safe updates when updating/deleting values through 'update' or 'delete'
	-- change soo to soohyun based on uni
	UPDATE columbia_people SET name_first='soohyun'  WHERE uni = 'sa3782';
	-- delete dropout kid, because keys are linked, we must delete first from tables referencing the dropout kid, then from columbia_people
	DELETE FROM student where uni = "d12324";
	DELETE FROM columbia_people where uni = "d12324";
SET SQL_SAFE_UPDATES = 1;
-- uncomment below and you will see that there is no longer the dropout student,
-- select * from columbia_people where uni = 'd12324';
-- select * from student where uni = 'd12324';

-- uncomment this and you will see that soo, identified by her uni, is now Soohyun
-- select * from columbia_people where uni = 'sa3782';


/*
 ===============================================================
VIEWS: 
 ===============================================================
 a view is a precached query
 Example: professor info
*/
Drop View If Exists prof_info;
create view prof_info as
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
on o.uni=t.uni;
-- uncomment and see! 
-- select * from prof_info;


/*
 ===============================================================
FUNCTIONS
 ===============================================================
create uni from 
Example: function: first char of first name, first char of last name
Example: procedure: create students and professors and uni, insert into relevant tables
*/
DROP FUNCTION IF EXISTS create_uni; 
SET GLOBAL log_bin_trust_function_creators = 1; -- use this flag so u can declare functions


DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION create_uni(
	name_first varchar(50),
	name_last varchar(50)
) RETURNS varchar(50)
BEGIN
 set @comb = CONCAT(left(name_first,1),left(name_last,1)) ;

SET @result = concat(@comb,CAST((select count(*) from columbia_people where LEFT(uni, 2)=@comb) as char(50)));

RETURN @result;
END$$
DELIMITER ;
-- there is already one dfcreate_student, uncomment and see below
-- select * from columbia_people where LEFT(uni, 2)='df';
-- select count(*) from columbia_people where LEFT(uni, 2)='df';
-- select create_uni("Daniel","Fu");

/*
 ===============================================================
stored procedures
 ===============================================================
 Example: auto uni creation and insertion into appropriate tables for 
 professors and students
*/

DROP PROCEDURE IF EXISTS create_student;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE create_student(
	-- arguments
    name_first varchar(50),
	name_last varchar(50),
    dept_key varchar(9),
    syear Integer,
    advisor varchar(9)
)
BEGIN
	set @uni= sql_workshop.create_uni(name_first,name_last);
    -- INSERTS INTO BOTH columbia_person and student! Convenient!
    insert into sql_workshop.columbia_people values (@uni,name_first,name_last,"student",dept_key);
    insert into sql_workshop.student values (@uni,dept_key,syear,advisor);
END$$
DELIMITER ;

CALL sql_workshop.create_student("Daniel","Fu", "CS","1","se1234");
CALL sql_workshop.create_student("Dan","Fang","CS","1","se1234");
CALL sql_workshop.create_student("Don","Fan","CS","1","se1234");

-- uncomment below and see how convenient this is!!! 
-- select * from columbia_people;
-- select * from student;



/*
 ===============================================================
Permissioning
 ===============================================================

create users and privilages, we will get to this later
Limit the scope of users to the sql_workshop database
*/
DROP USER IF EXISTS 'cuit_user1'@'localhost';
CREATE USER 'cuit_user1'@'localhost' IDENTIFIED BY 'password';
GRANT ALL ON sql_workshop.* TO 'cuit_user1'@'localhost';
FLUSH PRIVILEGES;

DROP USER IF EXISTS 'sneaky_student'@'localhost';
CREATE USER 'sneaky_student'@'localhost' IDENTIFIED BY 'password';
-- only give permission for student to look at views which give non-confidential info
GRANT SELECT ON sql_workshop.prof_info TO 'sneaky_student'@'localhost';
FLUSH PRIVILEGES;