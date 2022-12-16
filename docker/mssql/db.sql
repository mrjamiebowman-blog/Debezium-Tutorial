/*.........................................................................................
//...SSSSSSS.......QQQQQQQ....LLLL....................CCCCCCC....DDDDDDDDD......CCCCCCC....
//..SSSSSSSSS....QQQQQQQQQQ...LLLL...................CCCCCCCCC...DDDDDDDDDD....CCCCCCCCC...
//..SSSSSSSSSS..QQQQQQQQQQQQ..LLLL..................CCCCCCCCCCC..DDDDDDDDDDD..CCCCCCCCCCC..
//.SSSSS..SSSS..QQQQQ..QQQQQ..LLLL.......::::.......CCCC...CCCCC.DDDD...DDDD..CCCC...CCCC..
//.SSSSS.......SQQQQ.....QQQQ.LLLL.......::::......CCCC.....CCC..DDDD....DDDDCCCC.....CCC..
//..SSSSSSS....SQQQ......QQQQ.LLLL.......::::......CCCC..........DDDD....DDDDCCCC..........
//...SSSSSSSSS.SQQQ......QQQQ.LLLL.................CCCC..........DDDD....DDDDCCCC..........
//.....SSSSSSS.SQQQ..QQQ.QQQQ.LLLL.................CCCC..........DDDD....DDDDCCCC..........
//........SSSSSSQQQQ.QQQQQQQQ.LLLL.................CCCC.....CCC..DDDD....DDDDCCCC.....CCC..
//.SSSS....SSSS.QQQQQ.QQQQQQ..LLLL..................CCCC...CCCCC.DDDD...DDDDD.CCCC...CCCC..
//.SSSSSSSSSSSS.QQQQQQQQQQQQ..LLLLLLLLLL.::::.......CCCCCCCCCCC..DDDDDDDDDDD..CCCCCCCCCCC..
//..SSSSSSSSSS...QQQQQQQQQQQ..LLLLLLLLLL.::::........CCCCCCCCCC..DDDDDDDDDD....CCCCCCCCCC..
//...SSSSSSSS......QQQQQQQQQQ.LLLLLLLLLL.::::.........CCCCCCC....DDDDDDDDD......CCCCCCC....
//........................QQQ..............................................................
//.......................................................................................*/


/*************************************************/
/*                    [SETUP]                    */
/*************************************************/

USE master
GO

CREATE LOGIN debezium WITH PASSWORD = 'EE5F5Z2UKSAtJKAM'
GO

CREATE DATABASE Customers
GO

CREATE DATABASE Orders
GO

CREATE DATABASE Products
GO

/*************************************************/
/*             [Database: Customers]             */
/*************************************************/

USE Customers
GO

CREATE USER debezium FOR LOGIN debezium
GO

CREATE ROLE debezium_role AUTHORIZATION debezium
GO

EXEC sp_addrolemember 'db_datareader', 'debezium_role'
GO

EXEC sp_addrolemember 'debezium_role', 'debezium'
GO

EXEC sys.sp_cdc_enable_db
GO

/*************************************************/
/*                   [Tables]                    */
/*************************************************/

CREATE TABLE [dbo].[Customers](
	[CustomerId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](100) NULL,
	[LastName] [varchar](100) NULL,
	[Email] [varchar](255) NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/*************************************************/
/*             [Database: Orders]                */
/*************************************************/

USE Orders
GO

CREATE USER debezium FOR LOGIN debezium
GO

CREATE ROLE debezium_role AUTHORIZATION debezium
GO

EXEC sp_addrolemember 'db_datareader', 'debezium_role'
GO

EXEC sp_addrolemember 'debezium_role', 'debezium'
GO

EXEC sys.sp_cdc_enable_db
GO

/*************************************************/
/*                   [Tables]                    */
/*************************************************/

CREATE TABLE [dbo].[Orders](
	[OrdersId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [nchar](10) NOT NULL,
	[Taxes] [decimal](18, 0) NOT NULL,
	[Subtotal] [decimal](18, 0) NOT NULL,
	[Total] [decimal](18, 0) NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Transactions] PRIMARY KEY CLUSTERED 
(
	[OrdersId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[OrdersLineItems](
	[OrdersLineItemId] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[Productid] [int] NOT NULL,
	[Product] [varchar](200) NOT NULL,
	[Quantity] [int] NOT NULL,
	[Total] [decimal](18, 0) NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_OrdersLineItems] PRIMARY KEY CLUSTERED 
(
	[OrdersLineItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[OrdersLineItems]  WITH CHECK ADD  CONSTRAINT [FK_OrdersLineItems_Orders] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Orders] ([OrdersId])
GO

ALTER TABLE [dbo].[OrdersLineItems] CHECK CONSTRAINT [FK_OrdersLineItems_Orders]
GO

/*************************************************/
/*                [DEBEZIUM]                     */
/*************************************************/

CREATE TABLE debezium_signal (id VARCHAR(42) PRIMARY KEY, type VARCHAR(32) NOT NULL, data VARCHAR(2048) NULL);
GO


/*************************************************/
/*                  [SPROCS]                     */
/*************************************************/


/*************************************************/
/*                    [CDC]                      */
/*************************************************/

-- EXECUTE sys.sp_cdc_enable_table  
--     @source_schema = N'dbo'  
--   , @source_name = N'Transactions'  
--   , @role_name = N'debezium_role'
--   , @column_lists = NULL;  
-- GO  


/*************************************************/
/*             [Database: Products]              */
/*************************************************/

USE Products
GO

CREATE USER debezium FOR LOGIN debezium
GO

CREATE ROLE debezium_role AUTHORIZATION debezium
GO

EXEC sp_addrolemember 'db_datareader', 'debezium_role'
GO

EXEC sp_addrolemember 'debezium_role', 'debezium'
GO

EXEC sys.sp_cdc_enable_db
GO

/*************************************************/
/*                   [Tables]                    */
/*************************************************/

CREATE TABLE [dbo].[Products](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NOT NULL,
	[Description] [varchar](500) NOT NULL,
	[Price] [decimal](18, 0) NOT NULL,
	[DateCreated] [datetime2](7) NOT NULL,
	[DateModified] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/*************************************************/
/*               [CDC - DISABLE]                 */
/*************************************************/

-- EXEC sys.sp_cdc_disable_table N'dbo'


/*************************************************/
/*           	[DATA: CUSTOMERS]       	     */
/*************************************************/

INSERT INTO [dbo].[Customers] ([FirstName], [LastName],[Email]) VALUES ('Jamie', 'Bowman', 'noreply@mrjamiebowman.com')
GO


/*************************************************/
/*           	[DATA: PRODUCTS]       	         */
/*************************************************/


/*************************************************/
/*           	[DATA: ORDERS]          	     */
/*************************************************/



/*************************************************/
/*           	[DATA: ORDER ITEMS]       	     */
/*************************************************/



