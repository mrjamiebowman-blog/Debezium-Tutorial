USE [Orders]

DECLARE @OrderId INT = 1
DECLARE @AMOUNT DECIMAL = CONVERT( DECIMAL(13, 2), 10 + (30-10) * RAND(CHECKSUM(NEWID())))

UPDATE [Orders].[dbo].[Orders] SET Total = @AMOUNT WHERE OrderId = @OrderId
UPDATE  [Orders].[dbo].[OrdersLineItems] SET Total = @AMOUNT WHERE OrderId = @OrderId

SELECT * FROM [dbo].[Orders]
SELECT * FROM [dbo].[OrdersLineItems]

