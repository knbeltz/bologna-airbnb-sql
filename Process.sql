-- Data Cleaning 

SELECT * 
FROM listings; 

-- 1. Remove duplicates
-- 2. Standardize the data 
-- 3. Null values 
-- 4. Remove any columns 

-- Create staging table 

CREATE TABLE listings_staging 
LIKE listings; 

SELECT *
FROM listings_staging;

INSERT listings_staging
SELECT *
FROM listings;

SELECT *
FROM listings_staging;

ALTER TABLE listings_staging
CHANGE ï»¿id id bigint; 

SELECT *
FROM listings_staging;

-- 1. Identify Duplicates

SELECT *,
ROW_NUMBER() OVER(
PARTITION BY id, host_name, neighbourhood_cleansed, latitude, longitude, property_type, room_type) AS row_num
FROM listings_staging;

WITH duplicate_cte AS 
(SELECT *,
ROW_NUMBER() OVER(
PARTITION BY id, host_name, neighbourhood_cleansed, latitude, longitude, property_type, room_type) AS row_num
FROM listings_staging
)
SELECT *
FROM duplicate_cte 
WHERE row_num > 1;

WITH duplicate_cte AS 
(SELECT *,
ROW_NUMBER() OVER(
PARTITION BY id, host_name, neighbourhood_cleansed, latitude, longitude, property_type, room_type) AS row_num
FROM listings_staging
)
DELETE
FROM duplicate_cte 
WHERE row_num > 1;

CREATE TABLE `listings_staging2` (
  `id` bigint DEFAULT NULL,
  `host_name` text,
  `neighbourhood_cleansed` text,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `property_type` text,
  `room_type` text,
  `accommodates` int DEFAULT NULL,
  `bathrooms` double DEFAULT NULL,
  `bedrooms` int DEFAULT NULL,
  `beds` int DEFAULT NULL,
  `price` int DEFAULT NULL,
  `minimum_nights` int DEFAULT NULL,
  `maximum_nights` int DEFAULT NULL,
  `minimum_minimum_nights` int DEFAULT NULL,
  `maximum_minimum_nights` int DEFAULT NULL,
  `minimum_maximum_nights` int DEFAULT NULL,
  `maximum_maximum_nights` int DEFAULT NULL,
  `minimum_nights_avg_ntm` int DEFAULT NULL,
  `maximum_nights_avg_ntm` int DEFAULT NULL,
  `number_of_reviews` int DEFAULT NULL,
  `number_of_reviews_ltm` int DEFAULT NULL,
  `number_of_reviews_l30d` int DEFAULT NULL,
  `review_scores_rating` double DEFAULT NULL,
  `review_scores_value` double DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM listings_staging2;

INSERT INTO listings_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY id, host_name, neighbourhood_cleansed, latitude, longitude, property_type, room_type) AS row_num
FROM listings_staging;

SELECT *
FROM listings_staging2
WHERE row_num > 1;

DELETE
FROM listings_staging2
WHERE row_num > 1;

SELECT *
FROM listings_staging2
WHERE row_num > 1;

SELECT * 
FROM listings_staging2;

-- 2. Standardizing the data 

SELECT host_name, TRIM(host_name)
FROM listings_staging2;

UPDATE listings_staging2
SET 
	host_name = TRIM(host_name),
    property_type = TRIM(property_type);
        
SELECT DISTINCT neighbourhood_cleansed
FROM listings_staging2;

SELECT DISTINCT property_type
FROM listings_staging2
ORDER BY 1;

SELECT DISTINCT room_type
FROM listings_staging2
ORDER BY 1;

SELECT *
FROM listings_staging2;

SELECT property_type
FROM listings_staging2
WHERE room_type = 'Entire home/apt' 
GROUP BY property_type;

SELECT *
FROM listings_staging2
WHERE property_type = 'Entire vacation home';

SELECT *
FROM listings_staging2
WHERE property_type = 'Tiny home';


-- 3. Null values

SELECT *
FROM listings_staging2
WHERE host_name IS NULL;

SELECT *
FROM listings_staging2
WHERE neighbourhood_cleansed IS NULL;

SELECT *
FROM listings_staging2
WHERE latitude IS NULL;

SELECT *
FROM listings_staging2
WHERE property_type IS NULL;

SELECT *
FROM listings_staging2
WHERE accommodates IS NULL;

SELECT *
FROM listings_staging2
WHERE price IS NULL;

-- Delete Values 

ALTER TABLE listings_staging2
DROP COLUMN row_num;

SELECT *
FROM listings_staging2;

