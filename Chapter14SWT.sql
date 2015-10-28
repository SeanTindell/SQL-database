/*
Sean Tindell
Chapter 14 Assignment
07/22/2015
*/


--Question 1
DECLARE @productCount int;
SET @productCount = (SELECT COUNT(*) FROM Products);
IF @productCount >= 7
	PRINT 'The number of products is greater than or equal to 7';
ELSE
	PRINT 'The number of products is less than 7';

--Question 2
DECLARE @productCount2 int, @avgListPrice money;
SET @productCount2 = (SELECT COUNT(*) FROM Products);
SET @avgListPrice = (SELECT AVG(ListPrice) FROM Products);

IF @productCount2 >= 7
	BEGIN
		PRINT 'Number of Products: ' + CONVERT(varchar,@productCount2);  
		PRINT 'Average: ' + CONVERT(VARCHAR,@avgListPrice);
	END;
ELSE
	PRINT 'The number of products is less than 7';
	
--Question 3
DECLARE @i int, @commonFactor int;
SET @i = 1;
PRINT 'Common factors of 10 and 20';
WHILE @i<20
	BEGIN

	IF (10%@i= 0 AND 20%@i =0)
		BEGIN
			SET @commonFactor = @i;
			PRINT CONVERT(VARCHAR, @commonFactor);
		END;

		SET @i = @i +1;
	END;

		
--Question 4
BEGIN TRY
	INSERT INTO Categories
		VALUES ('Guitars');
		PRINT 'SUCCESS: Record was inserted.';
	END TRY
	BEGIN CATCH
		PRINT 'FAILURE: Record was not inserted.';
		PRINT 'Error ' + CONVERT(varchar, ERROR_NUMBER(),1) 
							+ ': ' +ERROR_MESSAGE();
	END CATCH;

		
--Question 5

--I think this is what was being asked for

DECLARE @dynamicSQL varchar(8000);

SET @dynamicSQL = 'SELECT COUNT(sys.tables.name) AS TotalTable 
					FROM sys.tables
					where name IN
					(SELECT name
					FROM sys.tables
					WHERE name NOT IN (''dtproperties'', ''sysdiagrams'') )
					;';
SET @dynamicSQL = @dynamicSQL +';'; 
EXEC (@dynamicSQL);



