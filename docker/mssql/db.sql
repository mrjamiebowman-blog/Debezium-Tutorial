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
/*                    [USER]                     */
/*************************************************/

USE master
GO

CREATE LOGIN debezium WITH PASSWORD = 'EE5F5Z2UKSAtJKAM'
GO

CREATE DATABASE TransactionsDb
GO

USE TransactionsDb
GO

/*************************************************/
/*                    [SQL]                      */
/*************************************************/

-- CREATE TABLE [dbo].[Transactions](
--     [ID] [int] IDENTITY(1,1) NOT NULL,
--     [Amount] [decimal](18, 2) NULL
-- )

/*************************************************/
/*                  [SPROC]                      */
/*************************************************/

/*************************************************/
/*                [SIGNALING]                    */
/*************************************************/

CREATE TABLE debezium_signal (id VARCHAR(42) PRIMARY KEY, type VARCHAR(32) NOT NULL, data VARCHAR(2048) NULL);
GO

/*************************************************/
/*              [TransactionsDb]                 */
/*************************************************/

USE TransactionsDb
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
/*                    [CDC]                      */
/*************************************************/

EXEC sys.sp_cdc_enable_table


/*************************************************/
/*               [CDC - DISABLE]                 */
/*************************************************/

EXEC sys.sp_cdc_disable_table N'dbo'