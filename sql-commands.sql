
USE [Orders]

DECLARE @AMOUNT DECIMAL = CONVERT( DECIMAL(13, 2), 10 + (30-10) * RAND(CHECKSUM(NEWID())))

UPDATE [dbo].[Orders] SET Total = @AMOUNT WHERE OrdersId = 1

SELECT * FROM [dbo].[Orders]