### SQL Server Data Warehouse and Analytics Project
# Project Overview
Designed and developed a modern SQL Server Data Warehouse to consolidate sales data from ERP and CRM source systems and transform raw datasets into structured, analysis-ready data. The project implements the Medallion Architecture (Bronze, Silver, and Gold) and covers the complete data warehousing process, including data ingestion, transformation, data quality validation, data integration, and dimensional modelling.

# Key Highlights:
Designed a data warehouse using a three-layer Medallion Architecture.
Integrated ERP and CRM data from CSV source files.
Developed SQL-based ETL pipelines using stored procedures and BULK INSERT.
Implemented data cleansing, standardization, and deduplication.
Designed a Star Schema with fact and dimension tables.
Developed analytical SQL queries for customer, product, and sales analysis.

# Data Architecture
The project follows the Medallion Architecture, organizing data into three layers:
- Bronze Layer – Raw Data
    Ingested raw ERP and CRM data from CSV files into SQL Server.
    Used BULK INSERT for data loading.
    Implemented stored procedures to manage data ingestion.
    Maintained source data in its original format.

- Silver Layer – Cleansed Data
    Performed data cleansing and standardization.
    Handled missing values, duplicates, and invalid records.
    Resolved inconsistencies across source systems.
    Integrated data from ERP and CRM datasets.
    Applied data quality checks to validate transformed records.

- Gold Layer – Business-Ready Data
    Designed a Star Schema for analytical reporting.
    Created fact and dimension tables.
    Structured integrated data for efficient analytical queries.
    Prepared business-ready datasets for customer, product, and sales analysis.

# ETL Pipeline Implementation
Developed SQL-based ETL workflows to move and transform data across the three warehouse layers.
ETL Process:
    Extract: Read data from ERP and CRM CSV files.
    Load: Import raw records into Bronze layer tables using BULK INSERT.
    Transform: Clean, standardize, and validate records in the Silver layer.
    Integrate: Combine data from multiple source systems.
    Model: Populate fact and dimension tables in the Gold layer.
    Analyze: Execute SQL queries to generate business insights.

# Data Quality and Transformation
Implemented data quality checks and transformation logic across the warehouse layers.
Key activities:
    Duplicate identification and removal.
    Handling missing and NULL values.
    Identification of invalid records.
    Data standardization and consistency checks.
    Validation of primary keys and relationships.
    Verification of transformed data across layers.

# Data Modelling
    Implemented a Star Schema in the Gold layer to support analytical reporting.
    Fact Tables: Store measurable business information, including sales-related metrics.
    Dimension Tables: Store descriptive attributes related to business entities such as customers and products.

#Key Skills Demonstrated
    SQL Server and T-SQL Development
    ETL Pipeline Development
    Data Ingestion and Integration
    SQL Stored Procedures and BULK INSERT
    Data Cleansing and Transformation
    Data Quality Validation
    Medallion Architecture
    Dimensional Modelling and Star Schema
    Analytical SQL and Business Reporting
    Data Architecture and Documentation
    Git and GitHub
    
---

# About Me
I'm Deepthi Sathish Kumar, a Computer Science Master's student at RPTU Kaiserslautern-Landau, Germany, interested in Data Engineering, Data Analytics, and Business Intelligence.
I enjoy building data-driven solutions, working with SQL and Python, and transforming raw data into meaningful insights.
Areas of Interest: Data Engineering | Data Warehousing | ETL Pipelines | SQL | Python | Data Analytics
    

The dimensional model simplifies analytical queries and supports reporting from different business perspectives.
