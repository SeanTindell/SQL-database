/* Sean Tindell
SQL Assignment 5
02/14/2015*/

Use Master
Go
IF DB_ID('MytestDb') IS NOT NULL --check to see if the exists database
DROP DATABASE mytestdb; -- if it does drop the database
GO
Create Database MyTestDB;--Creates the database
Go
Use MyTestDB -- makes the database the active database
Go

--Question 1
CREATE TABLE ZipCode
(ZipCode	Varchar(10)	NOT NULL,
City		Varchar(20),
StateCode	Varchar(2));

--Question 2
ALTER TABLE ZipCode
ADD PRIMARY KEY (ZipCode);

--Question 3
CREATE TABLE Customer
(CustomerID		INT		PRIMARY KEY,
CustomerName	Varchar(30),
Address			Varchar(30),
ZipCode			Varchar(10) REFERENCES ZipCode (ZipCode),
CreditLimit		Money,
Balance			Money);

--Question 4
CREATE TABLE Orders
(OrderID		INT		PRIMARY KEY,
OrderDate		DATE,
CustomerID		INT		REFERENCES Customer (CustomerID));

--Question 5
CREATE TABLE Product
(ProductID		INT		PRIMARY KEY,
Description		Varchar(30),
UnitsOnHand		INT,
UnitsOnOrder	INT,
UnitOfMeasure	INT,
ReorderPoint	INT,
UnitCost		Money,
UnitPrice		Money);

--Question 6
CREATE TABLE OrderedProduct
(OrderID		INT		REFERENCES Orders (OrderID),
ProductID		INT		REFERENCES Product (ProductID),
NumberOrdered	INT,
QuotedPrice		Money,
PRIMARY KEY (OrderID, ProductID));

--Question 7
CREATE UNIQUE INDEX CustName
ON Customer (CustomerName)
WHERE CustomerName IS NOT NULL;

--Question 8
CREATE INDEX OrderPOrder
ON OrderedProduct (OrderID);
CREATE INDEX OrderPProduct
ON OrderedProduct (ProductID);