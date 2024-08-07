-- Data Analysis 

SELECT *
FROM listings_staging2;

-- Price Exploratory Analysis 

SELECT *
FROM listings_staging2
WHERE price = (SELECT MAX(price) FROM listings_staging2);

SELECT *
FROM listings_staging2
WHERE price = (SELECT MIN(price) FROM listings_staging2);

SELECT *
FROM listings_staging2
ORDER BY price ASC;


-- Accomodates Exploratory Analysis 
SELECT *
FROM listings_staging2
WHERE accommodates = (SELECT MAX(accommodates) FROM listings_staging2);

-- Visualization of listings 

SELECT host_name, neighbourhood_cleansed, latitude, longitude, property_type, price, review_scores_rating
FROM listings_staging2;

-- Number by neighbourhood

SELECT neighbourhood_cleansed, COUNT(neighbourhood_cleansed) AS num_listings
FROM listings_staging2
GROUP BY neighbourhood_cleansed;

-- AVG Price by Neighbourhood 

SELECT neighbourhood_cleansed, AVG(price) AS avg_price
FROM listings_staging2
GROUP BY neighbourhood_cleansed
ORDER BY neighbourhood_cleansed ASC;

SELECT neighbourhood_cleansed, COUNT(*) AS num_of_listings
FROM listings_staging2
GROUP BY neighbourhood_cleansed
ORDER BY neighbourhood_cleansed ASC;

SELECT neighbourhood_cleansed, AVG(accommodates) AS avg_accomodates
FROM listings_staging2
GROUP BY neighbourhood_cleansed
ORDER BY neighbourhood_cleansed ASC;


-- Number by Property Type 

SELECT property_type, COUNT(property_type) as num_listings
FROM listings_staging2
GROUP BY property_type
ORDER BY num_listings DESC;

-- Average price by property type

SELECT property_type, COUNT(property_type) as num_listings, AVG(price) AS avg_price
FROM listings_staging2
GROUP BY property_type
ORDER BY num_listings DESC;

-- Average accommodates by property type

SELECT property_type, COUNT(property_type) as num_listings, AVG(accommodates)
FROM listings_staging2
GROUP BY property_type
ORDER BY num_listings DESC;

-- Average amenities (bedrooms and bathrooms by property type) 
SELECT property_type, COUNT(property_type) as num_listings, AVG(bathrooms) AS avg_bathrooms, AVG(bedrooms) AS avg_bedrooms
FROM listings_staging2
GROUP BY property_type
ORDER BY num_listings DESC;






