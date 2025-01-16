--- select the data

SELECT *
FROM dbo.marketing_table

--- Identify duplicate values.There were no duplicate values and the query returned 2,240 unique rows

SELECT *,
ROW_NUMBER () OVER (
                   PARTITION BY
				   ID,
				   Year_Birth,
				   Dt_Customer
				   ORDER BY ID
				   ) row_num
FROM dbo.marketing_table
Order by ID

--- Delete duplicate values 

WITH CTE AS(
SELECT *,
ROW_NUMBER () OVER (
                   PARTITION BY
				   ID,
				   Year_Birth,
				   Dt_Customer
				   ORDER BY ID
				   ) row_num
FROM dbo.marketing_table
Order by ID
)
DELETE FROM CTE
WHERE row_num > 1;

Make the data consistent in the marital-status column

--- Query 1 

SELECT Marital_Status
FROM dbo.marketing_table
WHERE Marital_Status IN ('YOLO', 'ABSURD')

--- Query 2 

UPDATE dbo.marketing_table
SET Marital_Status = 'Null' 
WHERE Marital_Status= 'YOLO'

UPDATE dbo.marketing_table
SET Marital_Status = 'Null' 
WHERE Marital_Status= 'ABSURD'

--- Query 3

SELECT Marital_Status AS Marital_Status
 ,   CASE When Marital_Status= 'Alone' Then 'Single'
	     When Marital_Status= 'Together' Then 'Married'
		 Else Marital_Status
		 END
FROM dbo.marketing_table

UPDATE dbo.marketing_table
SET Marital_Status = 'Single' 
WHERE Marital_Status= 'Alone'

UPDATE dbo.marketing_table
SET Marital_Status = 'Married' 
WHERE Marital_Status= 'Together'

--Getting rid of null values in the Expenditure Column

--- Query 1 

SELECT ID, [ Expenditure]
FROM dbo.marketing_table
WHERE [ Expenditure] = ' '

UPDATE dbo.marketing_table
SET [ Expenditure]= 0
WHERE [ Expenditure]=''
Data type conversion 

--Convert Expenditure column to dollar currency 

SELECT 
	ID,
	Year_Birth,
	Dt_Customer,
	FORMAT ([Expenditure], ‘C’,’en-US’)  
	AS Expenditure_Currency			   
FROM dbo.marketing_table;

--Convert year of birth to date type

SELECT
TRY_CAST(Year_Birth AS DATE)) AS Birth_Year,
FROM dbo.marketing_table;

UPDATE dbo.marketing_table
SET Birth_Year = TRY_CAST(Year_Birth AS DATE);

ALTER TABLE dbo.marketing_table
ALTER COLUMN Year_Birth DATE;

--Convert enrollment year of customer to date type

ALTER TABLE dbo.marketing_table
ALTER COLUMN Dt_Customer DATE;

--Convert Expenditure and Number of wesite visits columns to INT type

UPDATE dbo.marketing_table
SET Expenditure = TRY_CAST([Expenditure] AS INT),
NumWebVisit = TRY_CAST(NumWebVisitsMonth AS INT);

-- Rename Columns

EXEC sp_rename 'dbo.marketing_table.MntWines', 'Wine', 'COLUMN';
EXEC sp_rename 'dbo.marketing_table.MntFruits', 'Fruits', 'COLUMN';
EXEC sp_rename 'dbo.marketing_table.MntMeatProducts', 'Meat', 'COLUMN';
EXEC sp_rename 'dbo.marketing_table.MntFishProducts', 'Fish', 'COLUMN';
EXEC sp_rename 'dbo.marketing_table.MntSweetProducts', 'Sweets', 'COLUMN';
EXEC sp_rename 'dbo.marketing_table.MntGoldProducts', 'Gold', 'COLUMN';

-- Change data types to INT
ALTER TABLE dbo.marketing_table
ALTER COLUMN NumDealsPurchases INT;

ALTER TABLE dbo.marketing_table
ALTER COLUMN NumStorePurchases INT;

ALTER TABLE dbo.marketing_table
ALTER COLUMN NumCatalogPurchases INT;

ALTER TABLE dbo.marketing_table
ALTER COLUMN AcceptedCmp1 AS INT;

ALTER TABLE dbo.marketing_table
ALTER COLUMN AcceptedCmp2 AS INT;

ALTER TABLE dbo.marketing_table
ALTER COLUMN AcceptedCmp3 AS INT;

ALTER TABLE dbo.marketing_table
ALTER COLUMN AcceptedCmp4 AS INT;

ALTER TABLE dbo.marketing_table
ALTER COLUMN AcceptedCmp5 AS INT;

ALTER TABLE dbo.marketing_table
ALTER COLUMN Wine INT;

ALTER TABLE dbo.marketing_table
ALTER COLUMN Fruits INT;

ALTER TABLE dbo.marketing_table
ALTER COLUMN Meat INT;

ALTER TABLE dbo.marketing_table
ALTER COLUMN Fish INT;

ALTER TABLE dbo.marketing_table
ALTER COLUMN Sweets INT;

ALTER TABLE dbo.marketing_table
ALTER COLUMN Gold INT;

--Exploration and Analysis to Answer Business Questions

--Total Customers= 2240

SELECT COUNT (ID)
FROM  dbo.marketing_table

-- Customers Average Annual Salary= $51,687

SELECT AVG([ Expenditure])AS Average_Income
FROM dbo.marketing_table

-- Website visits in the last month

SELECT  NumWebVisits
FROM dbo.marketing_table

SELECT Customer_date
FROM dbo.marketing_table

--TOTAL NUMBER OF WEBSITES VISIT SINCE THE LAST MONTH = 335 visits
SELECT SUM(NumWebVisitsMonth)  AS Total_Visits
FROM dbo.marketing_table
WHERE Dt_Customer >= '2014-06-01'

--Number of Discounted Purchses = 5208

SELECT SUM(NumDealsPurchases) AS Discounted_Purchases
FROM dbo.marketing_table


-- Educational Status of Customers

SELECT Education, COUNT (*) As Number_of_People
FROM dbo.marketing_table
WHERE Education IN ('PhD', 'Master','Graduation','2n Cycle')
GROUP BY Education
ORDER BY Number_of_People ASC

--Location By Customers

SELECT Country, COUNT (*) As Number_of_People
FROM dbo.marketing_table
WHERE Country IN ('Australia', 'Canada','Germany','India', 'Mexico','Saudi Arabia','Spain','USA')
GROUP BY Country
ORDER BY Number_of_People ASC


--Enrollment Year By Customers 

 SELECT
    YEAR(Dt_Customer) AS Enrollment_Year,
    COUNT(*) * 100.0 /(SELECT COUNT(*) FROM dbo.marketing_table)  AS Enrollment_Percentage
FROM dbo.marketing_table
    
WHERE
    YEAR(Dt_Customer) BETWEEN 2012 AND 2014
GROUP BY
    YEAR(Dt_Customer) 
ORDER BY
    Enrollment_Percentage;

 --Products By Total Revenue 

SELECT [Product], SUM(Total_Revenue) AS Total_Revenue
FROM
(
    SELECT 'Wine' AS [Product], AS Total_Revenue
    FROM dbo.marketing_table
    UNION ALL
    SELECT 'Fish' AS [Product], AS Total_Revenue
    FROM dbo.marketing_table
    UNION ALL
    SELECT 'Meat' AS [Product], AS Total_Revenue
    FROM dbo.marketing_table
    UNION ALL
    SELECT 'Fruits' AS [Product], AS Total_Revenue
    FROM dbo.marketing_table
    UNION ALL
    SELECT 'Sweets' AS [Product], AS Total_Revenue
    FROM dbo.marketing_table
    UNION ALL
    SELECT 'Gold' AS [Product], AS Total_Revenue
    FROM dbo.marketing_table
) AS subquery
GROUP BY [Product]
ORDER BY Total_Revenue ASC;

--Marketing Channels By Purchase

SELECT [Channel], SUM(Total_Purchase) AS Total_Purchase
FROM
(
    SELECT 'Website' AS [Channel], SUM(NumWebPurchases) AS Total_Purchase
    FROM dbo.marketing_table
    UNION ALL
    SELECT 'Catalog' AS [Channel], SUM(NumCatalogPurchases) AS Total_Purchase
    FROM dbo.marketing_table
	UNION ALL
    SELECT 'Store' AS [Channel], SUM(NumStorePurchases) AS Total_Purchase
    FROM dbo.marketing_table
) AS subquery
GROUP BY [Channel]
ORDER BY Total_Purchase ASC;

--Marital Status By Customers

SELECT Marital_Status, COUNT (*) As Number_of_People
FROM dbo.marketing_table
WHERE Marital_Status IN ('Married', 'Single','Divorced','Widow')
GROUP BY Marital_Status
ORDER BY Number_of_People ASC

--Campaign By Customer Acceptance, 

SELECT
    campaign,
    SUM(accepted_response) AS accepted_count
FROM (
    SELECT
        'Campaign 1' AS campaign,
      AcceptedCmp1 AS accepted_response
    FROM dbo.marketing_table
    UNION ALL
    SELECT
        'Campaign 2' AS campaign,
        AcceptedCmp2 AS accepted_response
    FROM dbo.marketing_table
    UNION ALL
    SELECT
        'Campaign 3' AS campaign,
       AcceptedCmp3 AS accepted_response
    FROM dbo.marketing_table
    UNION ALL
    SELECT
        'Campaign 4' AS campaign,
        AcceptedCmp4 AS accepted_response
    FROM dbo.marketing_table
	UNION ALL
    SELECT
        'Campaign 5' AS campaign,
        AcceptedCmp5 AS accepted_response
    FROM dbo.marketing_table
) AS subquery
WHERE
    accepted_response = 1
GROUP BY
    campaign
ORDER BY
accepted_count;
