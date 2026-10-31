select * from Employee;

--------------------------------------------------------
--Phase 5: Database Relations & Junction Tables (Day 03)
--Task 5.1: Create AccessCards Table (1:1 Relation)
create table AccessCard (
CardID INT PRIMARY KEY,
CardNumber VARCHAR(50) NOT NULL UNIQUE,
EmployeeID INT UNIQUE FOREIGN KEY References Employee
);

--Task 5.2: Create Projects & EmployeeProjects Tables (M:N Relation)
create table Projects (
ProjectID INT primary key,
ProjectName VARCHAR(100) NOT NULL
);

create table EmployeeProjects (
EmployeeID INT  FOREIGN KEY References Employee,
ProjectID INT  FOREIGN KEY References Projects, 
PRIMARY KEY (EmployeeID, ProjectID),
AssignedDate DATE
);
--Task 5.3: Populate New Tables

insert into AccessCard 
values(1,'Card 101',1),
(2,'Card 102',2),
(3,'Card 103',3);

insert into Projects
values(1,'AI & Security Training' ),
(2,'Cloud Migration');

insert into EmployeeProjects(EmployeeID,ProjectID,AssignedDate)
values (1,1,'2026-11-29'),
(1,2,'2026-12-29'),
(2,1,'2026-11-10'),
(3,2,'2026-11-11');
-------------------------------------------------------
--Phase 6: Database Joins & Multi-Table Queries (Day 04)
--Task 6.1: INNER JOIN (1:N Relation)
select FullName,Salary,DepartmentName  from Employee  join Department
on Employee.DepartmentID=Department.DepartmentID;

--Task 6.2: LEFT JOIN (1:N Relation)
select FullName,DepartmentName  from  Department left join Employee
on Employee.DepartmentID=Department.DepartmentID;

--Task 6.3: INNER JOIN (1:1 Relation)
select FullName,CardNumber from Employee  join AccessCard
on Employee.EmployeeID=AccessCard.EmployeeID


--Task 6.4: Multi-Table JOIN across Junction Table (M:N Relation)
select FullName,ProjectName,AssignedDate 
from Employee e 
join EmployeeProjects ep on e.EmployeeID= ep.EmployeeID
join Projects p on p.ProjectID=ep.ProjectID;

----------------------------------------------
--Phase 7: GROUP BY, HAVING, and WHERE (Day 04)
--Task 7.1: Department Salary Analysis (GROUP BY)
select SUM(Salary) as TotalSalary ,COUNT(EmployeeID) as EmployeeCount from Employee
group by Employee.DepartmentID;

--Task 7.2: Filtering Grouped Results (HAVING)
select DepartmentID , AVG(Salary) as averageSalary from Employee
group by DepartmentID
having AVG(Salary)>1000.00

--Task 7.3: Subqueries
select * from Employee 
where Salary >(select AVG(Salary) from Employee )


--Task 7.4: Views
create view  vw_EmployeeDetails as
select EmployeeID, FullName, Email,DepartmentName 
from Employee join Department
on Employee.DepartmentID=Department.DepartmentID

select * from vw_EmployeeDetails

--Task 7.5: Stored Procedures
create procedure sp_GetEmployeesByDepartment
@DeptID INT 
as
begin
select * from Employee
where EmployeeID=@DeptID
end;

exec sp_GetEmployeesByDepartment @DeptID =2;

--Task 7.6: Triggers
create table EmployeeAudit(
AuditID INT primary key IDENTITY, 
EmployeeID INT, 
ActionE VARCHAR(50),
ActionDate DATE
); 
create trigger AfterDelete
on Employee
after delete
as
begin
INSERT INTO EmployeeAudit (EmployeeID, ActionE, ActionDate)
    SELECT EmployeeID, 'DELETE', GETDATE()
    FROM deleted;
end;

insert into Employee 
values(4,'yam','yam@gmail.com',300,3,0788888888)
DELETE FROM Employee WHERE EmployeeID=4;
select * from EmployeeAudit;

