--Stage 1: Manual Database Setup & GUI Operations (Day 01)
create database CourseHubDB;

create table TempInstructors (
TempID INT primary key,
TempName VARCHAR(50),
JoinedDate DATE
);

------------------------------------------------------------------
--Stage 2: Schema Definition & Constraints - DDL (Day 02 & Day 03)
--Task 2.1: Departments Table
create table Department(
DepartmentID INT primary key,
DepartmentName VARCHAR(100) NOT NULL UNIQUE
);

--Task 2.2: Students Table (1:N with Departments)
create table Student(
StudentID INT primary key, 
FullName VARCHAR(100) NOT NULL,
Email VARCHAR(100) UNIQUE,
GPA DECIMAL(3,2),
DepartmentID INT foreign key references  Department(DepartmentID)
);

--Task 2.3: StudentProfiles Table (1:1 Relation with Students)
create table StudentProfile(
ProfileID INT primary key,
StudentID INT UNIQUE foreign key references Student(StudentID),
Address VARCHAR(200), 
EmergencyPhone VARCHAR(20)
);

--Task 2.4: Courses Table (1:N with Departments)
create table Course(
CourseID INT primary key , 
CourseName VARCHAR(100) NOT NULL,
Credits INT,
DepartmentID INT foreign key references Department(DepartmentID)
);

--Task 2.5: StudentCourses Table (M:N Junction Table)
create table StudentCourses(
StudentID INT foreign key references Student(StudentID),
CourseID INT  foreign key references Course(CourseID) , 
EnrollmentDate DATE DEFAULT GETDATE(),
Primary Key (StudentID, CourseID)
); 

--Task 2.6: ALTER & DROP Operations
alter table Student add Age INT ;
drop table TempInstructors ;

--------------------------------------------------
--Stage 3: Data Insertion & Updates - DML (Day 02)
--Task 3.1: Insert Departments
insert into Department
values (1, 'Computer Science'), 
(2, 'Software Engineering'),
(3, 'Business Administration')
--Task 3.2: Insert Students
insert into Student
values (101 ,'Ali Smadi' ,'ali@coursehub.com' ,3.80 ,1 ,22),
(102,'Omar Ahmad' ,'omar@coursehub.com' ,2.90 ,1 ,21),
(103 ,'Laila Hassan' ,'laila@coursehub.com' ,3.50 ,2 ,23),
(104 ,'Tariq Zaid' ,'tariq@coursehub.com' ,2.10 ,3 ,20)

--Task 3.3: Insert Student Profiles (1:1)
insert into StudentProfile
values (1, 101, 'Amman, Jordan', '0791111111'), 
(2, 102, 'Irbid, Jordan', '0792222222'), 
(3, 103, 'Zarqa, Jordan', '0793333333')

--Task 3.4: Insert Courses
insert into Course
values (201, 'Database Systems', 3, 1), 
(202, 'Web Development', 3, 1),
(203, 'Software Architecture', 3, 2)
--Task 3.5: Enroll Students in Courses (M:N)
insert into StudentCourses
values(101,201,GETDATE()),
(101,202,GETDATE()),
(102,201,GETDATE()),
(103,203,GETDATE());

--Task 3.6: Update & Delete Operations
update Student set GPA=2.50 where StudentID=104;
delete from Student where StudentID=104;

------------------------------------------------
--Stage 4: Multi-Table Joins & Relations (Day 04)
--Task 4.1: INNER JOIN (1:N)
select FullName, GPA,DepartmentName
from Student join Department
on student.DepartmentID=Department.DepartmentID

--Task 4.2: LEFT JOIN (1:N)
select d.DepartmentName,StudentID,FullName
from Department d left join Student s
on d.DepartmentID=s.DepartmentID

--Task 4.3: INNER JOIN (1:1)
select FullName, Address,EmergencyPhone
from Student s join StudentProfile sp
on s.StudentID=sp.StudentID

--Task 4.4: M:N Multi-Table JOIN
select FullName, CourseName,EnrollmentDate 
from Student s join StudentCourses sc
on s.StudentID=sc.StudentID
join Course on sc.CourseID=Course.CourseID

--------------------------------------------------------------
--Stage 5: Aggregations, Grouping & Filtering (Day 02 & Day 04) 
--Task 5.1: Global Aggregations
select COUNT(StudentID) as TotalStudents,AVG(GPA) as AverageGPA,
MAX(GPA) as HighestGPA,MIN(GPA) as LowestGPA from Student

--Task 5.2: GROUP BY Department
select DepartmentID, AVG(GPA) as AverageGPA,COUNT(Student.StudentID) as TotalStudents
from Student
group by Student.DepartmentID

--Task 5.3: HAVING Clause
select DepartmentID, AVG(GPA) as AverageGPA
from Student
group by Student.DepartmentID
having AVG(GPA)>3.00

--Task 5.4: Combined Query (WHERE + GROUP BY + HAVING)
select DepartmentID, AVG(GPA) as AverageGPA,COUNT(Student.StudentID) as TotalStudents
from Student
where GPA >= 2.50
group by Student.DepartmentID
having COUNT(Student.StudentID)>1

---------------------------
--Stage 6: Indexing (Day 04)
--Task 6.1: Clustered Index
CREATE CLUSTERED INDEX IX_Students_StudentID
ON Student(StudentID);
--Task 6.2: Non-Clustered Index
CREATE NONCLUSTERED INDEX IX_Students_Email 
ON Student(Email);
----------------------------------------
--Stage 7: Advanced SQL Objects (Day 04)
--Task 7.1: Subqueries
select * from Student
where GPA>(select Avg(GPA) from Student)

--Task 7.2: Views
Create View  vw_StudentAcademicDetails as
select StudentID, FullName, GPA, DepartmentName 
from Student s join Department d
on s.DepartmentID=d.DepartmentID

select * from vw_StudentAcademicDetails

--Task 7.3: Stored Procedures
create procedure sp_GetStudentsByDepartment 
@DeptID INT 
as
begin
select * from student 
where DepartmentID=@DeptID
end;
exec sp_GetStudentsByDepartment @DeptID=1;
