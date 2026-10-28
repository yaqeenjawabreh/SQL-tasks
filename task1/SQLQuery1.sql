-------------------------------------------------
--Phase 1: Manual Setup in SSMS (Day 01 Topics)
create database TechWorldHRDB;
create table TemporaryStaff (
StaffID INT primary key,
StaffName VARCHAR(50) ,
HireDate DATE
);

------------------------------------
--Phase 2: Database Structure & DDL 
--Task 2.1: Create Departments Table
create table Department(
DepartmentID INT PRIMARY KEY,
DepartmentName VARCHAR(50) NOT NULL UNIQUE
);

--Task 2.2: Create Employees Table
create table Employee(
EmployeeID INT PRIMARY KEY,
FullName VARCHAR(100) NOT NULL,
Email VARCHAR(100) UNIQUE,
Salary DECIMAL(10,2),
DepartmentID INt
);

--Task 2.3: Modify Table (ALTER TABLE)
alter table Employee add PhoneNumber VARCHAR(20);


--Task 2.4: Table Cleanup (DROP TABLE)
 drop table TemporaryStaff ;

 ----------------------------------
--Phase 3: Data Manipulation - DML 
--Task 3.1: Insert Departments (INSERT)

insert into Department 
values(1,'IT'),
      (2,'HR'),
      (3,'Finance');

--Task 3.2: Insert Employees (INSERT)

insert into Employee
values(1,'Ahmad Ali','ahmad@techworld.com' ,1200.00,1,'0791111111'),
(2,'Sara Hassan' ,'sara@techworld.com' ,950.00 , 2 ,'0792222222'),
(3,'Zaid Omar' ,'zaid@techworld.com',1500.00 ,1,'0793333333'),
(4,'Mona Khaled' ,'mona@techworld.com',800.00 ,3 ,'0794444444');

--Task 3.3: Update Salary (UPDATE)
update Employee set Salary=1350.00 where EmployeeID=1;

--Task 3.4: Delete Record (DELETE)
delete from Employee where EmployeeID=4;


----------------------------------------------------
--Phase 4: Queries & Aggregations (Day 02 Topics)
--Task 4.1: Retrieve All Employee Records
select * from Employee;

--Task 4.2: Retrieve Specific Columns
select FullName ,Salary from Employee;

--Task 4.3: Total Payroll Expense (SUM)
select sum(Salary) as TotalSalaries from Employee;

--Task 4.4: Average Employee Salary (AVG)
select Avg(Salary) as AverageSalary from Employee;

--Task 4.5: Salary Range Extremes (MAX & MIN)
 select MIN(Salary) as LowestSalary,MAX(Salary) as HighestSalary from Employee;

--Task 4.6: Total Headcount (COUNT)
select COUNT(EmployeeID) as TotalEmployees from Employee;