# Debezium (MSSQL) Kafka Tutorial
This Debezium tutorial will use SQL server in Docker to push to Kafka / Azure Event Hubs. I've included a sample consumer to display the data as it is picked up by Debezium and put onto the event bus.

## Get Started
After cloing the repository you will need to start `Debezium` which will expose `Kafka Connect`.

### Steps
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

```

```sql

/*************************************************/
/*               [CDC - DISABLE]                 */
/*************************************************/

EXEC sys.sp_cdc_disable_table N'dbo', N'orders'

```