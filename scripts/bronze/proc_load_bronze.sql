/*
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
STORED PROCEDURE: LOAD BRONZE LAYER (SOURCE --> BRONZE)
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
SCRIPT PURPOSE:
    This stored procedure loads data into the 'bronze' schema from external csv files.
    It performs the following actions:
      - Truncates the bronze tables before loading data.
      - Uses the "BULK INSERT" command to load data from csv files to bronze tables.
USAGE EXAMPLE: 
    EXEC bronze.load_bronze;
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME; --DECLARING THE VARIABLES
	BEGIN TRY
		SET @batch_start_time = GETDATE(); --setting the start time for whole bronze layer
		PRINT '**********************************************';
		PRINT 'Loading Bronze Layer';
		PRINT '**********************************************';

		PRINT '---------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '---------------------------------------------';

		SET @start_time = GETDATE();  --SETTING THE START TIME for each table
		TRUNCATE TABLE bronze.crm_cust_info; -- Truncating the table
		PRINT '>> Inserting Data Into:bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'D:\warehouse\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
		   FIRSTROW = 2,   --VALUES START FROM 2ND ROW OF THE FILE
		   FIELDTERMINATOR = ',',   -- DELIMITER(SEPARTOR) OF THIS CSV FILE
		   TABLOCK        -- LOCKS THE WHOLE TABLE WHILE LOADING
		);		--SELECT count(*) FROM bronze.crm_cust_info -- Quality checks

		SET @end_time =GETDATE();  --SETTING THE END TIME
		PRINT'>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'SECONDS'; -- CALUCALUTES THE DIFFERENCE BETWEEN START AND END TIME
		PRINT '----------X----------';

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_prd_info;
		PRINT '>> Inserting Data Into:bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'D:\warehouse\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
		   FIRSTROW = 2,   
		   FIELDTERMINATOR = ',',  
		   TABLOCK        
		);
		SET @end_time =GETDATE();  
		PRINT'>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'SECONDS'; 
		PRINT '----------X----------';

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT '>> Inserting Data Into:bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\warehouse\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
		   FIRSTROW = 2,   
		   FIELDTERMINATOR = ',',  
		   TABLOCK        
		);
		SET @end_time =GETDATE();  
		PRINT'>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'SECONDS'; 
		PRINT '----------X----------';

		PRINT '---------------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '---------------------------------------------';

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_cust_az12;
		PRINT '>> Inserting Data Into:bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'D:\warehouse\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
		   FIRSTROW = 2,   
		   FIELDTERMINATOR = ',',   
		   TABLOCK        
		);
		SET @end_time =GETDATE();  
		PRINT'>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'SECONDS'; 
		PRINT '----------X----------';

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_loc_a101;
		PRINT '>> Inserting Data Into:bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'D:\warehouse\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
		   FIRSTROW = 2,   
		   FIELDTERMINATOR = ',',   
		   TABLOCK        
		);
		SET @end_time =GETDATE();  
		PRINT'>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'SECONDS'; 
		PRINT '----------X----------';

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		PRINT '>> Inserting Data Into:bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'D:\warehouse\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
		   FIRSTROW = 2,   
		   FIELDTERMINATOR = ',',  
		   TABLOCK       
		);
		SET @end_time =GETDATE();  
		PRINT'>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'SECONDS'; 
		PRINT '----------X----------';

		SET @batch_end_time = GETDATE();  
		PRINT 'X==========X==========X';
		PRINT '>> Total Load Duration for whole batch (Bronze Layer): ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + 'SECONDS'; 
		PRINT 'X==========X==========X';
	END TRY
	BEGIN CATCH
		PRINT '-------------------------------------';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
		PRINT 'ERROR MESSAGE' + CAST(ERROR_NUMBER() AS NVARCHAR); --TYPE CAST TO STRING SINCE NUMBER IS AN INTEGER
		PRINT 'ERROR MESSAGE' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '-------------------------------------';
	END CATCH
END
