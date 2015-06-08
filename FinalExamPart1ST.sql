/* Sean Tindell
Final Exam Part 1
2/21/2015*/

---question 01
SELECT Products.ProductID, ProductName
FROM Products
WHERE ProductID NOT IN
	(SELECT OrderDetails.ProductID
	FROM OrderDetails)

---question 02
SELECT CustomerID, CompanyName, Address + ', ' + City + ' ' + PostalCode AS Full_address
FROM Customers
WHERE CustomerID LIKE 'M%'

---question 03 
---UNABLE to find employee hourly rate so used empID for rate
---unable to find indication of hourly employee used reports to to determine if hourly
SELECT FirstName + ' '+ LastName AS Employee_Name, 2080 * EmployeeID AS Estimated_Yearly_Salary
FROM  Employees
WHERE Employees.EmployeeID NOT IN 
	(SELECT ReportsTo
	FROM Employees)
	
---question 04
SELECT TOP 10 UnitPrice AS Product_Prices, Products.ProductName
FROM Products
ORDER BY UnitPrice DESC;

---question 05
SELECT *
FROM Customers
WHERE Region IS NULL

---question 06
SELECT Products.ProductName, Suppliers.CompanyName
FROM Products JOIN Suppliers
	ON Products.SupplierID = Suppliers.SupplierID
ORDER BY Suppliers.CompanyName, Products.ProductName;


--- EXTRA Credit 
--- Using same method I used the same method to find the estimated salary 
SELECT LastName,  STR(SUM(Freight)*.05, 8, 2) AS Commission_Paid, (2080 * Employees.EmployeeID) AS Estimated_Salary, STR((2080 * Employees.EmployeeID) + (SUM(Freight)*.05 ), 8, 2) AS Total_Compensation
FROM Employees JOIN Orders
	ON Employees.EmployeeID = Orders.EmployeeID
WHERE Employees.EmployeeID NOT IN 
	(SELECT ReportsTo
	FROM Employees)
GROUP BY LastName, Employees.EmployeeID;


--- question 07
IF DB_ID('College') IS NOT NULL --check to see if the database exists
DROP DATABASE College; -- if it does drop the database
GO
Create Database College;--Creates the database
Go
Use College -- makes the database the active database
Go

CREATE TABLE Student
(StuNum	Varchar(5)	Primary Key,
StuFirstName	Varchar(25), 
StuLastName		Varchar(25),StuMajor		Varchar(40));

CREATE TABLE Instructor
(InstructorID Varchar(5)	Primary Key,
Ins_FName	Varchar(30),
Ins_LName	Varchar(30),Phone		Varchar(15));

CREATE TABLE Class
(ClassCode	Varchar(5) PRIMARY KEY,
SectionNum Varchar(5),
InstructorID Varchar(5) REFERENCES Instructor (InstructorID),
Location Varchar(40));

CREATE TABLE Enrollment
(Class_code	Varchar(5) REFERENCES Class (ClassCode),
StuNum	Varchar(5)	REFERENCES Student (StuNum),
EnrollDate	DATETIME, 
PRIMARY KEY(Class_code, StuNum));

---question 08
/*
the StuNUm is both a primary key because each enrollment would require a StuNum, this is also a froegin key in order to draw from the student table 
but a student must have also a class_code in order to be on the enrollment table in short a 
student must have an class code and an student number in order to be enrolled 
this is to prevent a many to many relationship between student and class createing the possibilities of mulitple null values
*/

