-- create the call centre database and import the data

CREATE DATABASE callcentredb;

USE callcentredb;
CREATE TABLE callcentre(
		ID CHAR(255),
        cust_name CHAR(255),
        sentiment CHAR(255),
        csat_score CHAR(255),
        call_timestamp CHAR(255),
        reason CHAR(255),
        city CHAR(255),
        state CHAR(255),
        channel CHAR(255),
        response_time CHAR(255),
        call_duration_minutes CHAR(255),
        call_centre CHAR(255));
        
SELECT * 
FROM callcentre;

--------------------------------------------------------------------------------

-- Cleaning the Data
-- Update the date (call_timestamp) to ISO format
-- Update the missing csat_score to null
-- Update call_duration_minutes to INT

SET SQL_SAFE_UPDATES = 0;

UPDATE callcentre SET call_timestamp = str_to_date(call_timestamp, "%m/%d/%Y");

UPDATE callcentre SET csat_score = NULL WHERE csat_score = 0;

SELECT CAST(call_duration_minutes AS UNSIGNED) AS call_duration_minutes FROM callcentre;

SET SQL_SAFE_UPDATES = 1;


---------------------------------------------------------------------------

-- Exploring the data
-- Finding the number of rowns and columns

SELECT COUNT(*) AS row_num from callcentre;   
-- 32941
SELECT COUNT(*) AS col_num from information_schema.columns where table_name = 'callcentre';
-- 12

-- Distinct values for come columns

SELECT DISTINCT sentiment FROM callcentre;
SELECT DISTINCT reason FROM callcentre;
SELECT DISTINCT city FROM callcentre;
SELECT DISTINCT state FROM callcentre;
SELECT DISTINCT channel FROM callcentre;
SELECT DISTINCT response_time FROM callcentre;
SELECT DISTINCT call_centre FROM callcentre;


-- Count and percentage of each distinct value 

SELECT sentiment, count(*) AS count, ROUND((count(*)/(SELECT count(*) FROM callcentre))*100, 2) AS pct FROM callcentre GROUP BY 1 ORDER BY 3 DESC;

SELECT reason, count(*) AS count, ROUND((count(*)/(SELECT count(*) FROM callcentre))*100, 2) AS pct FROM callcentre GROUP BY 1 ORDER BY 3 DESC;

SELECT city, count(*) AS count, ROUND((count(*)/(SELECT count(*) FROM callcentre))*100, 2) AS pct FROM callcentre GROUP BY 1 ORDER BY 3 DESC;

SELECT state, count(*) AS count, ROUND((count(*)/(SELECT count(*) FROM callcentre))*100, 2) AS pct FROM callcentre GROUP BY 1 ORDER BY 3 DESC;

SELECT channel, count(*) AS count, ROUND((count(*)/(SELECT count(*) FROM callcentre))*100, 2) AS pct FROM callcentre GROUP BY 1 ORDER BY 3 DESC;

SELECT response_time, count(*) AS count, ROUND((count(*)/(SELECT count(*) FROM callcentre))*100, 2) AS pct FROM callcentre GROUP BY 1 ORDER BY 3 DESC;

SELECT call_centre, count(*) AS count, ROUND((count(*)/(SELECT count(*) FROM callcentre))*100, 2) AS pct FROM callcentre GROUP BY 1 ORDER BY 3 DESC;


-- Day with the most calls

SELECT DAYNAME(call_timestamp) AS day, count(*) AS count FROM callcentre GROUP BY 1 ORDER BY 2 DESC;


-- Aggregations

SELECT MIN(csat_score) AS min_score,  MAX(csat_score) AS max_score, ROUND(AVG(csat_score),2) AS avg_score FROM callcentre;

SELECT MIN(call_timestamp) AS earliest_date, MAX(call_timestamp) AS most_recent FROM callcentre;

SELECT MIN(call_duration_minutes) AS min_duration, MAX(call_duration_minutes) AS max_duration, ROUND(AVG(call_duration_minutes),2) AS avg_duration FROM callcentre;

SELECT call_centre, response_time, count(*) AS count FROM callcentre GROUP BY 1,2 ORDER BY 1,3 DESC;

SELECT call_centre, ROUND(AVG(call_duration_minutes),2) AS avg_call_duration FROM callcentre GROUP BY 1 ORDER BY 2 DESC;

SELECT channel, ROUND(AVG(call_duration_minutes),2) AS avg_call_duration FROM callcentre GROUP BY 1 ORDER BY 2 DESC;

SELECT state, count(*) AS call_count FROM callcentre GROUP BY 1 ORDER BY 2 DESC;

SELECT state, reason, count(*) AS call_count FROM callcentre GROUP BY 1, 2 ORDER BY 1, 3 DESC;

SELECT state, sentiment, count(*) AS call_count FROM callcentre GROUP BY 1, 2 ORDER BY 1, 3 DESC;

SELECT state, ROUND(AVG(csat_score),2) AS avg_csat_score FROM callcentre GROUP BY 1 ORDER BY 2 DESC;

SELECT sentiment, ROUND(AVG(call_duration_minutes),2) AS avg_csat_score FROM callcentre GROUP BY 1 ORDER BY 2 DESC;



