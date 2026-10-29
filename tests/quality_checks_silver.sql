/*
-----------------------------------------------------
Quality checks
-----------------------------------------------------
Script Purpose:
    This script performs various quality checks for data consistency, accuracy and 
    standardization across the silver schemas. 
    It includes checks for:
      - Null or Duplicate primary keys.
      - Unwanted spaces in sting fields.
      - Data standardization and Consistency.
      - Invalid date ranges and orders.
      - Data Consistency between related fields.
Usage Notes:
      - Run these checks after data loading Silver Layer.
      - Investigate and resolve any discrepancies found during the checks
-----------------------------------------------------
*/
--**********************************************************
-- checking 'silver.crm_cust_info'
----**********************************************************

SELECT
prd_id,
COUNT(*)
FROM bronze.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL

-- Check for unwanted spaces in string values
SELECT cst_firstname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)

SELECT cst_lastname
FROM silver.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname)

--Data Standardization & Consistency
SELECT DISTINCT cst_gndr
FROM silver.crm_cust_info

--prd table
SELECT
prd_id,
COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL

SELECT prd_id,prd_key, prd_nm, prd_start_dt,prd_end_dt,
LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt)-1 prd_end_dt_test
FROM bronze.crm_prd_info WHERE prd_key IN ('AC-HE-HL-U509-R', 'AC-HE-HL-U509')

--check for invalid date orders
SELECT *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt

--SELECT * FROM silver.crm_prd_info

--sales table
--check for invalid dates sales table
SELECT 
NULLIF(sls_order_dt,0) AS sls_order_dt
FROM silver.crm_sales_details
WHERE sls_order_dt <= 0 OR LEN(sls_order_dt) != 8

--check for invalid date orders
SELECT *
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt

--check data consistency: between sales, Quamtity and price
--> Sales = Quantity * Price
--> Values must not be NULL,Zero or negative
SELECT DISTINCT
sls_sales AS sls_sales_old,
sls_quantity, 
sls_price AS sls_price_old,
CASE WHEN sls_sales IS NULL OR sls_sales <=0 OR sls_sales != sls_quantity * ABS(sls_price)
		THEN sls_quantity * ABS(sls_price)
	 ELSE  sls_sales
END AS sls_sales,
CASE WHEN sls_price IS NULL OR sls_price <= 0
		THEN sls_sales / NULLIF(sls_quantity ,0)
	 ELSE sls_price
END AS sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price

--SELECT * FROM silver.crm_sales_details

--Identify Out of range dates
SELECT DISTINCT 
bdate
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01' OR bdate >  GETDATE()

--Data Standardization & Consistency
SELECT DISTINCT 
CASE WHEN UPPER(TRIM(gen)) IN ('F', 'FEMALE') THEN 'Female'
	 WHEN UPPER(TRIM(gen)) IN ('M', 'MALE') THEN 'Male'
	 ELSE 'N/A'
END AS gen
FROM silver.erp_cust_az12

--SELECT * FROM silver.erp_cust_az12
SELECT DISTINCT cntry,
CASE WHEN TRIM(cntry) = 'DE' THEN 'Germany'
	 WHEN TRIM(cntry) IN ('US','USA') THEN 'United States'
	 WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'N/A'
	 ELSE TRIM(cntry)
END AS cntry
FROM bronze.erp_loc_a101

--SELECT * FROM silver.erp_loc_a101

--check for unwanted spaces
SELECT * FROM bronze.erp_px_cat_g1v2
WHERE cat != TRIM(cat)

--Data Standardization & Consistency
SELECT DISTINCT cat FROM bronze.erp_px_cat_g1v2
SELECT DISTINCT subcat FROM bronze.erp_px_cat_g1v2
SELECT DISTINCT maintenance FROM bronze.erp_px_cat_g1v2

--SELECT * FROM silver.erp_px_cat_g1v2
/* Quality check - A primary key must be unique and not null 
Check the consistency of values in low cardinality(few possible values) columns 
Expectation: No Result
*/
