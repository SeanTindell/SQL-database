/*
Sean Tindell
Chapter 13 Assignment
07/15/2015
*/


--Question 1
CREATE VIEW CustomerAddresses
AS
SELECT Customers.CustomerID, EmailAddress, LastName, FirstName, 
Line1 AS BillLine1, Line2 as BillLine2, city as BillCity, state as BillState, ZipCode as BillZip, Line1 as ShipLine1, Line2 as ShipLine2, City as ShipCity, State as ShipState, ZipCode as ShipZip
FROM Customers JOIN Addresses
	ON Customers.CustomerID = Addresses.CustomerID;

--Question 2
SELECT CustomerID, LastName, FirstName, BillLine1
FROM CustomerAddresses;


--Question 3
UPDATE CustomerAddresses
SET ShipLine1 = '1990 Westwood Blvd.'
where CustomerID = 8;


--Question 4
CREATE VIEW OrderItemProducts 
AS
SELECT ProductName, Orders.OrderID, OrderDate, TaxAmount, ShipDate, ItemPrice, DiscountAmount, (ItemPrice - DiscountAmount) AS FinalPrice , Quantity, (ItemPrice - DiscountAmount) * Quantity AS ItemTotal
FROM Orders JOIN OrderItems
	ON ORDERS.OrderID = OrderItems.OrderID
	JOIN Products ON Products.ProductID = OrderItems.ProductID; 


--Question 5
CREATE VIEW ProductSummary 
AS 
SELECT ProductName, COUNT(ProductName) AS OrderCount,  SUM(itemTotal) AS OrderTotal 
FROM OrderItemProducts
group BY ProductName;


--Question 6
SELECT TOP 5 ProductName, OrderTotal
FROM ProductSummary
ORDER BY OrderTotal DESC;