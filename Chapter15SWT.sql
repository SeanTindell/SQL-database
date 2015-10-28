/*
Sean Tindell
Chapter 15 Assignment
07/30/2015
*/


--Question 1
ALTER PROC spInsertCategory
		@catName varchar(30)=NULL
AS
INSERT  Categories
VALUES (@catName);

EXEC spInsertCategory @catName = 'dwsd';
EXEC spInsertCategory @catName = 'sdsss';


--Question 2
CREATE FUNCTION fnDiscountPrice(@itemID int)
RETURNS MONEY
BEGIN
	RETURN (SELECT  ItemPrice - DiscountAmount as  discountPrice FROM OrderItems WHERE @itemID = ItemID )
END;

print convert(varchar,dbo.fnDiscountPrice(5));





--Question 3
CREATE FUNCTION fnItemTotal(@itemID int) 
RETURNS MONEY
BEGIN
	
	RETURN (SELECT dbo.fnDiscountPrice(@itemID) * Quantity FROM OrderItems where @itemID =ItemID);
END;

PRINT convert(varchar,dbo.fnItemTotal(5));





--Question 4
ALTER PROC spInsertProduct
	@catID int,
	@proCode int,
	@proName varchar(40),
	@lsPrice money,
	@discPercent decimal(3,2)
	
	

AS
IF (@lsPrice < 0 OR @discPercent <0 )
	THROW 50001, 'Enter a postive number for list price and discount Percent',1;
ELSE
	INSERT Products 
	VALUES (@catID, @proCode, @proName,'', @lsPrice, @discPercent,  GETDATE());

-EXEC spInsertProduct @catID = 11111, @proCode=11415, @proName='plire', @lsPrice=505.90, @discPercent=10 ;
EXEC spInsertProduct @catID = 11111, @proCode=114435, @proName='thyme', @lsPrice=100.90, @discPercent=20 ;




--Question 5
CREATE PROC spUpdateProductDiscount 
	@prodID int,
	@discpercent int
AS

if (@discpercent <0)
	THROW 50001, 'Discount Percent must be a positive number',1;
ELSE
UPDATE Products
	SET DiscountPercent = @discpercent
	where ProductID = @prodID; 
	
EXEC spUpdateProductDiscount @prodID = 199, @discpercent = 100;
EXEC spUpdateProductDiscount @prodID = 299, @discpercent = 75;



--Question 6
CREATE TRIGGER Products_UPDATE
ON Products
AFTER UPDATE

AS
IF ((SELECT DiscountPercent FROM inserted)>100 
		OR (SELECT DiscountPercent FROM INSERTED) <0)
		BEGIN
		;
	THROW 50001, 'Discount Percent must be a number between 1 and 100',1;
	END;

IF ((SELECT DiscountPercent FROM inserted)>0
		AND (SELECT DiscountPercent FROM inserted) <1)
		BEGIN
		;
			UPDATE Products
			SET DiscountPercent = DiscountPercent*100
			WHERE  ProductID IN (Select ProductID From inserted)
		END;

UPDATE Products
SET DiscountPercent = .02
WHERE ProductID = 199;
	


--Question 7
CREATE TRIGGER Products_INSERT
ON Products
AFTER INSERT

AS
UPDATE Products
SET DateAdded = GETDATE()
			WHERE  ProductID IN (Select ProductID From inserted);

INSERT  Products 
VALUES (11111,112111, 'sd','ax', 11.2, 2, null);


--Question 8


CREATE TABLE ProductsAudit
(AuditID INT NOT NULL PRIMARY KEY Identity,
ProductID INT NOT NULL REFERENCES Products(ProductID),
CategoryID INT NOT NULL REFERENCES Categories(CategoryID),
ProductCode varchar(10) NOT NULL,
ProductName varchar(255)NOT NULL,
ListPrice money NOT NULL,
DiscountPercent Money NOT NULL,
DateUpdated datetime null);



CREATE TRIGGER Products_UPDATE2
ON Products
AFTER UPDATE
AS

	INSERT INTO ProductsAudit(ProductID, CategoryID,ProductCode, ProductName, ListPrice, DiscountPercent, DateUpdated)
		SELECT ProductID, CategoryID, ProductCode, ProductName, ListPrice, DiscountPercent, DateAdded
		FROM deleted
		WHERE ProductID in (SELECT ProductID FROM inserted);

UPDATE products
 set listprice = 02.2
 WHERE ProductID = 299

SELECT * 
from ProductsAudit;
SELECT * 
from Products;
