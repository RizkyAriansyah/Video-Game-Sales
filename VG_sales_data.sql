-- Data Cleaning

-- 1. Remove Duplicate
-- 2. Standardized the Data
-- 3. Null values or blank values
-- 4. Remove Any unecessary Coloums

-- DUPLICATE table
SELECT *
FROM vgchartz_2024;

CREATE TABLE VG_sales_2024
LIKE vgchartz_2024
;

INSERT VG_sales_2024
SELECT *
FROM vgchartz_2024
;
-- 1. Remove Duplicate
-- Checking If there're any duplicates

WITH duplicates_cte AS
(SELECT *,
ROW_NUMBER() OVER(PARTITION BY 
img, title, 
console, genre, 
publisher, developer, 
critic_score, total_sales, 
na_sales, jp_sales, 
pal_sales, other_sales, 
release_date, last_update) AS duplicates
FROM vg_sales_2024
)
SELECT duplicates_cte.duplicates
FROM duplicates_cte
where duplicates_cte.duplicates > 1
;


-- 2. Standardized the Data
SELECT DISTINCT jp_sales
FROM vg_sales_2024
;

SELECT *
FROM vg_sales_2024
;

-- 3. blank values and null

-- look for blank or null
SELECT release_date 
FROM vg_sales_2024 
WHERE release_date = '' 
   OR release_date IS NULL 
 ;
 
 SELECT last_update
FROM vg_sales_2024 
WHERE last_update = '' 
  OR last_update IS NULL
   ;
   
-- Convert empty strings to NULL
UPDATE vg_sales_2024
SET release_date = NULL 
WHERE release_date = ''
;

UPDATE vg_sales_2024
SET last_update = NULL 
WHERE last_update = ''
;

-- Alter data format from text to date
ALTER TABLE vg_sales_2024
MODIFY COLUMN `release_date` DATE;

ALTER TABLE vg_sales_2024
MODIFY COLUMN `last_update` DATE;

SELECT *
FROM vg_sales_2024
;
