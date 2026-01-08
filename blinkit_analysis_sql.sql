use blinkitdb;


select * from blinkit_data;

select count(*) from blinkit_data;

SHOW COLUMNS FROM blinkit_data;

UPDATE `blinkit_data`
SET `Item Fat Content` = CASE
    WHEN `Item Fat Content` IN ('LF', 'Low fat') THEN 'Low Fat'
    WHEN `Item Fat Content` = 'reg' THEN 'Regular'
    ELSE `Item Fat Content`
END;



select distinct(`Item Fat Content`)
from blinkit_data;

-- KPI's Requirement

-- total sales

select cast(sum(Sales)/1000000 as decimal(10,2)) as Total_Sales_Millions
from blinkit_data
where `Outlet Establishment Year` = 2022;

-- average sales

select cast(avg(Sales) as decimal(10,1)) as Avg_Sales 
from blinkit_data
where `Outlet Establishment Year` = 2022;

-- count the items

select count(*) as No_Of_Items 
from blinkit_data
where `Outlet Establishment Year` = 2022;

-- avg rating

select cast(avg(Rating) as decimal(10,2)) as  Avg_Rating 
from blinkit_data;

-- Granular Requirement

-- Total sales by fat content

SELECT 
    `Item Fat Content`, 
    CAST(SUM(`Sales`) / 1000 AS DECIMAL(10,2)) AS Total_Sales_Thousands,
    CAST(AVG(`Sales`) AS DECIMAL(10,1)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(`Rating`) AS DECIMAL(10,2)) AS Avg_Rating
FROM `blinkit_data`
GROUP BY `Item Fat Content`
ORDER BY Total_Sales_Thousands DESC;

-- total sales by item type

SELECT 
    `Item Type`, 
    CAST(SUM(`Sales`) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(AVG(`Sales`) AS DECIMAL(10,1)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(`Rating`) AS DECIMAL(10,2)) AS Avg_Rating
FROM `blinkit_data`
GROUP BY `Item Type`
ORDER BY Total_Sales ASC
LIMIT 5;


-- fat content by outlet for total sales
SELECT 
    `Outlet Location Type`,
    CAST(SUM(CASE WHEN `Item Fat Content` = 'Low Fat' THEN Sales ELSE 0 END) AS DECIMAL(10,2)) AS Low_Fat,
    CAST(SUM(CASE WHEN `Item Fat Content` = 'Regular' THEN Sales ELSE 0 END) AS DECIMAL(10,2)) AS Regular
FROM blinkit_data
GROUP BY `Outlet Location Type`
ORDER BY `Outlet Location Type`;


-- total sales  by outlet establishment

SELECT 
    `Outlet Establishment Year`,
    CAST(SUM(`Sales`) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(AVG(`Sales`) AS DECIMAL(10,2)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(`Rating`) AS DECIMAL(10,2)) AS Avg_Rating
FROM `blinkit_data`
GROUP BY `Outlet Establishment Year`
ORDER BY Total_Sales DESC;



-- chart's requirement

-- percentage of sales by outlet size

SELECT 
    `Outlet Size`,
    CAST(SUM(`Sales`) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(SUM(`Sales`) * 100.0 / SUM(SUM(`Sales`)) OVER () AS DECIMAL(10,2)) AS Sales_Percentage
FROM `blinkit_data`
GROUP BY `Outlet Size`
ORDER BY Total_Sales DESC;


-- sales by outlet location

SELECT 
    `Outlet Location Type`,
    CAST(SUM(`Sales`) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(SUM(`Sales`) * 100.0 / SUM(SUM(`Sales`)) OVER () AS DECIMAL(10,2)) AS Sales_Percentage,
    CAST(AVG(`Sales`) AS DECIMAL(10,2)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(`Rating`) AS DECIMAL(10,2)) AS Avg_Rating
FROM `blinkit_data`
WHERE `Outlet Establishment Year` = 2020
GROUP BY `Outlet Location Type`
ORDER BY Total_Sales DESC;


-- all metrics by outlet type

SELECT 
    `Outlet Type`,
    CAST(SUM(`Sales`) AS DECIMAL(10,2)) AS Total_Sales,
    CAST(SUM(`Sales`) * 100.0 / SUM(SUM(`Sales`)) OVER () AS DECIMAL(10,2)) AS Sales_Percentage,
    CAST(AVG(`Sales`) AS DECIMAL(10,2)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(`Rating`) AS DECIMAL(10,2)) AS Avg_Rating
FROM `blinkit_data`
GROUP BY `Outlet Type`
ORDER BY Total_Sales DESC;

