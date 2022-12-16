# WORK IN PROGRESS (12/16/2022)

# Debezium (MSSQL) Kafka Tutorial
This Debezium tutorial will use SQL server in Docker to push to Kafka / Azure Event Hubs. I've included a sample consumer to display the data as it is picked up by Debezium and put onto the event bus.

## Get Started
After cloing the repository you will need to start `Debezium` which will expose `Kafka Connect`.

### Steps
* Setup .env file. Use .env.sample or rename to .env
* Start Docker Compose.
* Enable Change Data Capture (CDC) on the MSSQL Server.
* Enable capture tables.
* Use postman or Debezim UI to configure Kafka Connect.
* Use Azure Service Bus Explorer to receive CDC data or run the console application.

## Database Passwords
The administrative `sa` password is `RqrhWH5HmwGc6mEF`   

The `debezium` usser password is `EE5F5Z2UKSAtJKAM`   


## CDC Troubleshooting

```sql
/*************************************************/
/*               [CDC - STATUS]                  */
/*************************************************/


USE [Orders]
EXEC sp_cdc_help_change_data_capture
GO

USE [Customers]
EXEC sp_cdc_help_change_data_capture
GO

USE [Products]
EXEC sp_cdc_help_change_data_capture
GO


/*************************************************/
/*               [CDC - PURGE]                   */
/*************************************************/

DECLARE @max_lsn_binary(10) = sys.fn_cdc_get_max_lsn();

EXEC sys.sp_cdc_cleanup_change_table
    @capture_instance = N'dbo_orders',
    @low_water_mark = @max_lsn;
GO

/*************************************************/
/*               [CDC - DISABLE]                 */
/*************************************************/

EXEC sys.sp_cdc_disable_table N'dbo', N'orders'

```
