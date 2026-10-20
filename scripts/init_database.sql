/*
--------------------------------------------------
Create Database and Schemas
--------------------------------------------------
Script Purpose:
This script creates a new database named 'DataWarehouse' after checking if it already exists.
If the database exists it is dropped and recreated. 
Additionally, the script set up three schemas within the database:'bronze', 'silver', 'gold'.

Warning:
Running this scriptt will drop the entire 'DataWarehouse' database if it exists.
All data in the database will be permanently deleted. Proceed with caution and ensure 
you have proper backups before running this script.
*/

USE master;
GO

--Check for existence: Drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = ' DataWarehouse')
BEGIN
  ALTER DATABASE DataWarehouse SET SINGLE_USEr WITH ROLLBACK IMMEDIATE;
  DROP DATABASE DataWarehouse;
END;
GO
  
--CREATE database 'DataWarehouse'
CREATE DATABASE DataWarehouse;
GO
  
USE DataWarehouse;
GO

--Creation of Schemas
CREATE SCHEMA bronze;
GO
  
CREATE SCHEMA silver;
GO
  
CREATE SCHEMA gold;
GO
