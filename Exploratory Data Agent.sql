-- Databricks notebook source


 --Retrieving all the the data in the dataset
SELECT *
 FROM `retail`.`sales`.`retail_sales_dataset_data_agent`
 LIMIT 100;


-- Units sold by gender for ages 35-44 and 55-64
-- Table: retail.sales.retail_sales_dataset_data_agent

WITH categorized_data AS (
    SELECT
        Gender,
        Quantity,
        CASE
            WHEN Age BETWEEN 35 AND 44 THEN '35-44'
            WHEN Age BETWEEN 55 AND 64 THEN '55-64'
        END AS age_group
    FROM retail.sales.retail_sales_dataset_data_agent
    WHERE Gender IN ('Male', 'Female')
      AND (
            Age BETWEEN 35 AND 44
            OR Age BETWEEN 55 AND 64
          )
)

SELECT
    Gender,
    age_group,
    SUM(Quantity) AS total_units_sold
FROM categorized_data
GROUP BY
    Gender,
    age_group
ORDER BY
    Gender,
    age_group;



    -- Monthly trend of Average Transaction Value by Gender
-- Table: retail.sales.retail_sales_dataset_data_agent

SELECT
    DATE_TRUNC('MONTH', Date) AS month,
    Gender,
    ROUND(AVG(`Total Amount`), 2) AS avg_transaction_value
FROM retail.sales.retail_sales_dataset_data_agent
WHERE Gender IN ('Male', 'Female')
GROUP BY
    DATE_TRUNC('MONTH', Date),
    Gender
ORDER BY
    month,
    Gender;
 
