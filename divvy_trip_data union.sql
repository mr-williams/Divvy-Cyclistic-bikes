/*

This is the SQL script used to import, compile, clean and analyse the Case Study(Cyclystic Bike Share)
for the Capstone Project of the Google Data Analytics Professional Certificate.

The Database used was Microsoft SQL Server Management Studio.

The data was gotten from (https://divvy-tripdata.s3.amazonaws.com/index.html)

The following steps done:
1. Download the various CSV documents
2. Import the data into serparate tables 
3. Combining all tables into a singular table
4. Inspect Table for irregularities
5. Create Queries to Analyse and produce Data Visualisations


The code below begins from step 3.

*/

-------Step 3: Combining all the data acquired into a single table----------

SELECT *
	INTO divvy_tripsdata
FROM
(
	SELECT *
	FROM dbo.[202010-divvy-tripdata]
	UNION

SELECT*
FROM dbo.[202011-divvy-tripdata]
UNION

SELECT *
FROM dbo.[202012-divvy-tripdata]
UNION

SELECT*
FROM dbo.[202101-divvy-tripdata]
UNION

SELECT *
FROM dbo.[202102-divvy-tripdata]
UNION

SELECT *
FROM dbo.[202103-divvy-tripdata]
UNION 

SELECT *
FROM dbo.[202104-divvy-tripdata]
UNION

SELECT *
FROM dbo.[202105-divvy-tripdata]
UNION

SELECT*
FROM dbo.[202106-divvy-tripdata]
UNION

SELECT*
FROM dbo.[202107-divvy-tripdata]
UNION

SELECT*
FROM dbo.[202108-divvy-tripdata]
UNION

SELECT*
FROM dbo.[202109-divvy-tripdata]
) divvy;


------Step 4: Inspect Table for irregularities----------
/* To check for Duplicates */

SELECT  DISTINCT *
FROM  divvy_tripsdata;

/*   To check for Null values in the newly joint created table    */


SELECT *
FROM divvy_tripsdata
WHERE started_at is NULL AND ended_at is NULL;


SELECT *
FROM divvy_tripsdata
WHERE rideable_type is NULL;

/* This calculates the minimum & maximum, start & end longitudes and latitudes*/ 
SELECT MIN (end_lng) AS min_end_lag, 
MAX(end_lng) AS max_end_lag, 
MIN (end_lat) AS min_end_lat, 
MAX(end_lat) AS max_end_lat, 
MIN (start_lng) AS min_start_lng, 
MAX(start_lng) AS max_start_lng, 
MIN (start_lat) AS min_start_lat, 
MAX(start_lat) AS max_start_lat
FROM divvy_tripsdata;



-------Step 5: Create Queries to Analyse and produce Data Visualisations------------

/*This counts the total number of rides per day of the week for members and casuals seperately*/
SELECT DATENAME(dw,started_at) AS day_of_week, COUNT(DATEPART(dw,started_at)) AS Member_rides_TOTAL
FROM divvy_tripsdata
WHERE member_casual = 'member'
GROUP BY DATENAME(dw,started_at)
ORDER BY 
     CASE
          WHEN DATENAME(dw,started_at) = 'Sunday' THEN 1
          WHEN DATENAME(dw,started_at) = 'Monday' THEN 2
          WHEN DATENAME(dw,started_at) = 'Tuesday' THEN 3
          WHEN DATENAME(dw,started_at) = 'Wednesday' THEN 4
          WHEN DATENAME(dw,started_at) = 'Thursday' THEN 5
          WHEN DATENAME(dw,started_at) = 'Friday' THEN 6
          WHEN DATENAME(dw,started_at) = 'Saturday' THEN 7
     END ASC;

SELECT DATENAME(dw,started_at) AS day_of_week, COUNT(DATEPART(dw,started_at)) AS Member_rides_TOTAL
FROM divvy_tripsdata
WHERE member_casual = 'casual'
GROUP BY DATENAME(dw,started_at) 
ORDER BY 
     CASE
          WHEN DATENAME(dw,started_at) = 'Sunday' THEN 1
          WHEN DATENAME(dw,started_at) = 'Monday' THEN 2
          WHEN DATENAME(dw,started_at) = 'Tuesday' THEN 3
          WHEN DATENAME(dw,started_at) = 'Wednesday' THEN 4
          WHEN DATENAME(dw,started_at) = 'Thursday' THEN 5
          WHEN DATENAME(dw,started_at) = 'Friday' THEN 6
          WHEN DATENAME(dw,started_at) = 'Saturday' THEN 7
     END ASC;


/*    This query calculates the total Daily Hours spent riding bikes per day of the week for Members, Casual and Both Combined for the Year.  */
SELECT DATENAME(dw,started_at) AS day_of_week,SUM(DATEDIFF(HH,started_at,ended_at)) AS ride_length_in_Hours_Member
FROM divvy_tripsdata
WHERE member_casual = 'member' AND  started_at < ended_at
GROUP BY DATENAME(dw,started_at)
ORDER BY 
     CASE
          WHEN DATENAME(dw,started_at) = 'Sunday' THEN 1
          WHEN DATENAME(dw,started_at) = 'Monday' THEN 2
          WHEN DATENAME(dw,started_at) = 'Tuesday' THEN 3
          WHEN DATENAME(dw,started_at) = 'Wednesday' THEN 4
          WHEN DATENAME(dw,started_at) = 'Thursday' THEN 5
          WHEN DATENAME(dw,started_at) = 'Friday' THEN 6
          WHEN DATENAME(dw,started_at) = 'Saturday' THEN 7
     END ASC;


SELECT DATENAME(dw,started_at) AS day_of_week,SUM(DATEDIFF(HH,started_at,ended_at)) AS ride_length_in_Hours_Casual
FROM divvy_tripsdata
WHERE member_casual = 'Casual' AND started_at < ended_at
GROUP BY DATENAME(dw,started_at)
ORDER BY 
     CASE
          WHEN DATENAME(dw,started_at) = 'Sunday' THEN 1
          WHEN DATENAME(dw,started_at) = 'Monday' THEN 2
          WHEN DATENAME(dw,started_at) = 'Tuesday' THEN 3
          WHEN DATENAME(dw,started_at) = 'Wednesday' THEN 4
          WHEN DATENAME(dw,started_at) = 'Thursday' THEN 5
          WHEN DATENAME(dw,started_at) = 'Friday' THEN 6
          WHEN DATENAME(dw,started_at) = 'Saturday' THEN 7
     END ASC;

SELECT DATENAME(dw,started_at) AS day_of_week,SUM(DATEDIFF(HH,started_at,ended_at)) AS ride_length_Total
FROM divvy_tripsdata
WHERE started_at < ended_at
GROUP BY DATENAME(dw,started_at)
ORDER BY 
     CASE
          WHEN DATENAME(dw,started_at) = 'Sunday' THEN 1
          WHEN DATENAME(dw,started_at) = 'Monday' THEN 2
          WHEN DATENAME(dw,started_at) = 'Tuesday' THEN 3
          WHEN DATENAME(dw,started_at) = 'Wednesday' THEN 4
          WHEN DATENAME(dw,started_at) = 'Thursday' THEN 5
          WHEN DATENAME(dw,started_at) = 'Friday' THEN 6
          WHEN DATENAME(dw,started_at) = 'Saturday' THEN 7
     END ASC;



/*  This query is for the counting how many users for the year between members & casuals as well as the minimum,maximum and average length of rides in minutes   */
SELECT member_casual, 
	   COUNT(rideable_type) Bike_usage,
	   MIN(DATEDIFF(MI,started_at,ended_at)) AS MIN_ride_length_in_minutes, 
	   MAX(DATEDIFF(MI,started_at,ended_at)) AS MAX_ride_length_in_minutes,
	   AVG(DATEDIFF(MI,started_at,ended_at)) AS Average_ride_length_in_minutes
FROM divvy_tripsdata
WHERE started_at < ended_at
GROUP BY member_casual;



/*      This Query shows the top 25 stations that were mostly used over the year for Casual, Members & Combined Riders   */
SELECT start_station_name,COUNT(start_station_name) AS Number_usedMember
FROM divvy_tripsdata
WHERE member_casual = 'member'
GROUP BY start_station_name
ORDER BY Number_usedMember DESC
OFFSET 0 ROWS FETCH FIRST 25 ROWS ONLY;

SELECT start_station_name,COUNT(start_station_name) AS Number_usedCasual
FROM divvy_tripsdata
WHERE member_casual = 'casual'
GROUP BY start_station_name
ORDER BY Number_usedCasual DESC
OFFSET 0 ROWS FETCH FIRST 25 ROWS ONLY;

SELECT start_station_name,COUNT(start_station_name) AS Number_used
FROM divvy_tripsdata
GROUP BY start_station_name
ORDER BY Number_used DESC
OFFSET 0 ROWS FETCH FIRST 25 ROWS ONLY;

/*  This Query Shows which bike type was used and how many times it was used over the year  */
SELECT rideable_type,COUNT(rideable_type) AS Member_Bike_usage
FROM divvy_tripsdata
WHERE member_casual ='member'
GROUP BY rideable_type;

SELECT rideable_type,COUNT(rideable_type) AS Casual_Bike_usage
FROM divvy_tripsdata
WHERE member_casual ='casual'
GROUP BY rideable_type;

SELECT rideable_type,COUNT(rideable_type) AS Casual_Bike_usage
FROM divvy_tripsdata
GROUP BY rideable_type*;



----Quarterly Breakdown of data analysis------

         /* Q1 Breakdown  */
/*This Query Shows the Complete Table for this Quarter*/
SELECT *
FROM divvy_tripsdata
WHERE started_at BETWEEN '2020-10-01' AND '2020-12-31'
ORDER BY started_at ASC


/*This Query is for the Daily Total number of rides between Member & Casual Riders in this Quarter*/
SELECT DATEPART(dw,started_at) AS day_of_week, COUNT(DATEPART(dw,started_at)) AS Member_rides_TOTAL
FROM divvy_tripsdata
WHERE member_casual = 'member' AND (started_at BETWEEN '2020-10-01' AND '2020-12-31')
GROUP BY DATEPART(dw,started_at) 
ORDER BY DATEPART(dw,started_at)

SELECT DATEPART(dw,started_at) AS day_of_week, COUNT(DATEPART(dw,started_at)) AS Casual_rides_TOTAL
FROM divvy_tripsdata
WHERE member_casual = 'casual' AND (started_at BETWEEN '2020-10-01' AND '2020-12-31')
GROUP BY DATEPART(dw,started_at) 
ORDER BY DATEPART(dw,started_at)

/*This Query Shows which bike type was used and how many times it was used over the Quarter*/
SELECT rideable_type,COUNT(rideable_type) AS Member_Bike_usage
FROM divvy_tripsdata
WHERE member_casual ='member' AND (started_at BETWEEN '2020-10-01' AND '2020-12-31')
GROUP BY rideable_type

SELECT rideable_type,COUNT(rideable_type) AS Casual_Bike_usage
FROM divvy_tripsdata
WHERE member_casual ='casual' AND (started_at BETWEEN '2020-10-01' AND '2020-12-31')
GROUP BY rideable_type

/*This query is for the total ride hours per day of week*/
SELECT DATENAME(dw,started_at) AS day_of_week, SUM(DATEDIFF(HH,started_at,ended_at)) AS Ride_Hours_Casual
FROM divvy_tripsdata
WHERE member_casual = 'casual' AND (started_at BETWEEN '2020-10-01' AND '2020-12-31') AND started_at <= ended_at
GROUP BY DATENAME(dw,started_at)
ORDER BY CASE
          WHEN DATENAME(dw,started_at) = 'Sunday' THEN 1
          WHEN DATENAME(dw,started_at) = 'Monday' THEN 2
          WHEN DATENAME(dw,started_at) = 'Tuesday' THEN 3
          WHEN DATENAME(dw,started_at) = 'Wednesday' THEN 4
          WHEN DATENAME(dw,started_at) = 'Thursday' THEN 5
          WHEN DATENAME(dw,started_at) = 'Friday' THEN 6
          WHEN DATENAME(dw,started_at) = 'Saturday' THEN 7
     END ASC;

SELECT DATENAME(dw,started_at) AS day_of_week, SUM(DATEDIFF(HH,started_at,ended_at)) AS Ride_Hours_Member
FROM divvy_tripsdata
WHERE member_casual = 'member' AND (started_at BETWEEN '2020-10-01' AND '2020-12-31') AND started_at <= ended_at
GROUP BY DATENAME(dw,started_at)
ORDER BY CASE
          WHEN DATENAME(dw,started_at) = 'Sunday' THEN 1
          WHEN DATENAME(dw,started_at) = 'Monday' THEN 2
          WHEN DATENAME(dw,started_at) = 'Tuesday' THEN 3
          WHEN DATENAME(dw,started_at) = 'Wednesday' THEN 4
          WHEN DATENAME(dw,started_at) = 'Thursday' THEN 5
          WHEN DATENAME(dw,started_at) = 'Friday' THEN 6
          WHEN DATENAME(dw,started_at) = 'Saturday' THEN 7
     END ASC;


/* This Query Shows the Bike Usage Count, Minimum, Maximum and Average Ride length in minutes Between Members & Casual Riders*/
SELECT member_casual, 
	   COUNT(rideable_type) Bike_usage,
	   MIN(DATEDIFF(MI,started_at,ended_at)) AS MIN_ride_length_in_minutes, 
	   MAX(DATEDIFF(MI,started_at,ended_at)) AS MAX_ride_length_in_minutes,
	   AVG(DATEDIFF(MI,started_at,ended_at)) AS Average_ride_length_in_minutes
FROM divvy_tripsdata
WHERE member_casual ='member' AND (started_at BETWEEN '2020-10-01' AND '2020-12-31') AND started_at <= ended_at
GROUP BY member_casual
UNION

SELECT member_casual, 
	   COUNT(rideable_type) Bike_usage,
	   MIN(DATEDIFF(MI,started_at,ended_at)) AS MIN_ride_length_in_minutes, 
	   MAX(DATEDIFF(MI,started_at,ended_at)) AS MAX_ride_length_in_minutes,
	   AVG(DATEDIFF(MI,started_at,ended_at)) AS Average_ride_length_in_minutes
FROM divvy_tripsdata
WHERE member_casual ='casual' AND (started_at BETWEEN '2020-10-01' AND '2020-12-31') AND started_at <= ended_at
GROUP BY member_casual


/* Top 25 Most Used Stations in this quarter*/
SELECT start_station_name,COUNT(start_station_name) AS number_of_Times_Used
FROM divvy_tripsdata
WHERE started_at BETWEEN '2020-10-01' AND '2020-12-31'
GROUP BY start_station_name
ORDER BY number_of_Times_Used DESC
OFFSET 0 ROWS FETCH FIRST 25 ROWS ONLY



/*    Q2 Breakdown     */
/*This Query Shows the Complete Table for this Quarter*/
SELECT *
FROM divvy_tripsdata
WHERE started_at BETWEEN '2021-01-01' AND '2021-03-31'
ORDER BY started_at ASC


/*This Query is for the Daily Total number of rides between Member & Casual Riders in this Quarter*/
SELECT DATEPART(dw,started_at) AS day_of_week, COUNT(DATEPART(dw,started_at)) AS Member_rides_Q2
FROM divvy_tripsdata
WHERE member_casual = 'member' AND (started_at BETWEEN '2021-01-01' AND '2021-03-31')
GROUP BY DATEPART(dw,started_at) 
ORDER BY DATEPART(dw,started_at)

SELECT DATEPART(dw,started_at) AS day_of_week, COUNT(DATEPART(dw,started_at)) AS Casual_rides_Q2
FROM divvy_tripsdata
WHERE member_casual = 'casual' AND (started_at BETWEEN '2021-01-01' AND '2021-03-31')
GROUP BY DATEPART(dw,started_at) 
ORDER BY DATEPART(dw,started_at)


/*This query is for the total ride hours per day of week*/
SELECT DATENAME(dw,started_at) AS day_of_week, SUM(DATEDIFF(HH,started_at,ended_at)) AS Ride_Hours_Casual
FROM divvy_tripsdata
WHERE member_casual = 'casual' AND (started_at BETWEEN '2021-01-01' AND '2021-03-31')AND started_at <= ended_at
GROUP BY DATENAME(dw,started_at)
ORDER BY CASE
          WHEN DATENAME(dw,started_at) = 'Sunday' THEN 1
          WHEN DATENAME(dw,started_at) = 'Monday' THEN 2
          WHEN DATENAME(dw,started_at) = 'Tuesday' THEN 3
          WHEN DATENAME(dw,started_at) = 'Wednesday' THEN 4
          WHEN DATENAME(dw,started_at) = 'Thursday' THEN 5
          WHEN DATENAME(dw,started_at) = 'Friday' THEN 6
          WHEN DATENAME(dw,started_at) = 'Saturday' THEN 7
     END ASC;

SELECT DATENAME(dw,started_at) AS day_of_week, SUM(DATEDIFF(HH,started_at,ended_at)) AS Ride_Hours_Member
FROM divvy_tripsdata
WHERE member_casual = 'member' AND (started_at BETWEEN '2021-01-01' AND '2021-03-31') AND started_at <= ended_at
GROUP BY DATENAME(dw,started_at)
ORDER BY CASE
          WHEN DATENAME(dw,started_at) = 'Sunday' THEN 1
          WHEN DATENAME(dw,started_at) = 'Monday' THEN 2
          WHEN DATENAME(dw,started_at) = 'Tuesday' THEN 3
          WHEN DATENAME(dw,started_at) = 'Wednesday' THEN 4
          WHEN DATENAME(dw,started_at) = 'Thursday' THEN 5
          WHEN DATENAME(dw,started_at) = 'Friday' THEN 6
          WHEN DATENAME(dw,started_at) = 'Saturday' THEN 7
     END ASC;


/* This Query Shows the Bike Usage Count, Minimum, Maximum and Average Ride length in minutes Between Members & Casual Riders*/
SELECT member_casual,
	   COUNT(rideable_type) Bike_usage,
	   MIN(DATEDIFF(MI,started_at,ended_at)) AS MIN_ride_length_in_minutes, 
	   MAX(DATEDIFF(MI,started_at,ended_at)) AS MAX_ride_length_in_minutes,
	   AVG(DATEDIFF(MI,started_at,ended_at)) AS Average_ride_length_in_minutes
FROM divvy_tripsdata
WHERE member_casual = 'member' AND (started_at BETWEEN '2021-01-01' AND '2021-03-31') AND started_at <= ended_at
GROUP BY member_casual
UNION

SELECT  member_casual,
	   COUNT(rideable_type) Bike_usage,
	   MIN(DATEDIFF(MI,started_at,ended_at)) AS MIN_ride_length_in_minutes, 
	   MAX(DATEDIFF(MI,started_at,ended_at)) AS MAX_ride_length_in_minutes,
	   AVG(DATEDIFF(MI,started_at,ended_at)) AS Average_ride_length_in_minutes
FROM divvy_tripsdata
WHERE member_casual = 'casual' AND (started_at BETWEEN '2021-01-01' AND '2021-03-31') AND started_at <= ended_at
GROUP BY member_casual

/* Top 25 Most Used Stations in this quarter*/
SELECT start_station_name,COUNT(start_station_name) AS number_of_Times_Used
FROM divvy_tripsdata
WHERE started_at BETWEEN '2021-01-01' AND '2021-03-31'
GROUP BY start_station_name
ORDER BY number_of_Times_Used DESC
OFFSET 0 ROWS FETCH FIRST 25 ROWS ONLY;

/*This Query Shows which bike type was used and how many times it was used over the Quarter*/
SELECT rideable_type,COUNT(rideable_type) AS Member_Bike_usage
FROM divvy_tripsdata
WHERE member_casual ='member' AND (started_at BETWEEN '2021-01-01' AND '2021-03-31')
GROUP BY rideable_type

SELECT rideable_type,COUNT(rideable_type) AS Casual_Bike_usage
FROM divvy_tripsdata
WHERE member_casual ='casual' AND (started_at BETWEEN '2021-01-01' AND '2021-03-31')
GROUP BY rideable_type



/*   Q3 Breakdwon  */
/*This Query Shows the Complete Table for this Quarter*/
SELECT *
FROM divvy_tripsdata
WHERE started_at BETWEEN '2021-04-01' AND '2021-06-30'
ORDER BY started_at ASC

/*This Query is for the Daily Total number of rides between Member & Casual Riders in this Quarter*/
SELECT DATEPART(dw,started_at) AS day_of_week, COUNT(DATEPART(dw,started_at)) AS Member_rides_TOTAL
FROM divvy_tripsdata
WHERE member_casual = 'member' AND (started_at BETWEEN '2021-04-01' AND '2021-06-30')
GROUP BY DATEPART(dw,started_at) 
ORDER BY DATEPART(dw,started_at)


SELECT DATEPART(dw,started_at) AS day_of_week, COUNT(DATEPART(dw,started_at)) AS Casual_rides_TOTAL
FROM divvy_tripsdata
WHERE member_casual = 'casual' AND (started_at BETWEEN '2021-04-01' AND '2021-06-30')
GROUP BY DATEPART(dw,started_at) 
ORDER BY DATEPART(dw,started_at)


/*This Query Shows which bike type was used and how many times it was used over the Quarter*/
SELECT rideable_type,COUNT(rideable_type) AS Member_Bike_usage
FROM divvy_tripsdata
WHERE member_casual ='member' AND (started_at BETWEEN '2021-04-01' AND '2021-06-30')
GROUP BY rideable_type

SELECT rideable_type,COUNT(rideable_type) AS Casual_Bike_usage
FROM divvy_tripsdata
WHERE member_casual ='casual' AND (started_at BETWEEN '2021-04-01' AND '2021-06-30')
GROUP BY rideable_type

/*This query is for the total ride hours per day of week*/
SELECT DATENAME(dw,started_at) AS day_of_week, SUM(DATEDIFF(HH,started_at,ended_at)) AS Ride_Hours_Casual
FROM divvy_tripsdata
WHERE member_casual = 'casual' AND (started_at BETWEEN '2021-04-01' AND '2021-06-30') AND started_at <= ended_at
GROUP BY DATENAME(dw,started_at)
ORDER BY CASE
          WHEN DATENAME(dw,started_at) = 'Sunday' THEN 1
          WHEN DATENAME(dw,started_at) = 'Monday' THEN 2
          WHEN DATENAME(dw,started_at) = 'Tuesday' THEN 3
          WHEN DATENAME(dw,started_at) = 'Wednesday' THEN 4
          WHEN DATENAME(dw,started_at) = 'Thursday' THEN 5
          WHEN DATENAME(dw,started_at) = 'Friday' THEN 6
          WHEN DATENAME(dw,started_at) = 'Saturday' THEN 7
     END ASC;

SELECT DATENAME(dw,started_at) AS day_of_week, SUM(DATEDIFF(HH,started_at,ended_at)) AS Ride_Hours_Member
FROM divvy_tripsdata
WHERE member_casual = 'member' AND (started_at BETWEEN '2021-04-01' AND '2021-06-30') AND started_at <= ended_at
GROUP BY DATENAME(dw,started_at)
ORDER BY CASE
          WHEN DATENAME(dw,started_at) = 'Sunday' THEN 1
          WHEN DATENAME(dw,started_at) = 'Monday' THEN 2
          WHEN DATENAME(dw,started_at) = 'Tuesday' THEN 3
          WHEN DATENAME(dw,started_at) = 'Wednesday' THEN 4
          WHEN DATENAME(dw,started_at) = 'Thursday' THEN 5
          WHEN DATENAME(dw,started_at) = 'Friday' THEN 6
          WHEN DATENAME(dw,started_at) = 'Saturday' THEN 7
     END ASC;


/* This Query Shows the Bike Usage Count, Minimum, Maximum and Average Ride length in minutes Between Members & Casual Riders*/
SELECT member_casual,
	   COUNT(rideable_type) Bike_usage,
	   MIN(DATEDIFF(MI,started_at,ended_at)) AS MIN_ride_length_in_minutes, 
	   MAX(DATEDIFF(MI,started_at,ended_at)) AS MAX_ride_length_in_minutes,
	   AVG(DATEDIFF(MI,started_at,ended_at)) AS Average_ride_length_in_minutes
FROM divvy_tripsdata
WHERE member_casual ='member' AND (started_at BETWEEN '2021-04-01' AND '2021-06-30') AND started_at <= ended_at
GROUP BY member_casual
UNION

SELECT  member_casual,
	   COUNT(rideable_type) Bike_usage,
	   MIN(DATEDIFF(MI,started_at,ended_at)) AS MIN_ride_length_in_minutes, 
	   MAX(DATEDIFF(MI,started_at,ended_at)) AS MAX_ride_length_in_minutes,
	   AVG(DATEDIFF(MI,started_at,ended_at)) AS Average_ride_length_in_minutes
FROM divvy_tripsdata
WHERE member_casual ='casual' AND (started_at BETWEEN '2021-04-01' AND '2021-06-30') AND started_at <= ended_at
GROUP BY member_casual


/* Top 25 Most Used Stations in this quarter*/
SELECT start_station_name,COUNT(start_station_name) AS number_of_Times_Used
FROM divvy_tripsdata
WHERE started_at BETWEEN '2021-04-01' AND '2021-06-30'
GROUP BY start_station_name
ORDER BY number_of_Times_Used DESC
OFFSET 0 ROWS FETCH FIRST 25 ROWS ONLY


/*   Q4 Breakdown   */
/*This Query Shows the Complete Table for this Quarter*/
SELECT *
FROM divvy_tripsdata
WHERE started_at BETWEEN '2021-07-01' AND '2021-09-30'
ORDER BY started_at ASC

/*This Query is for the Daily Total number of rides between Member & Casual Riders in this Quarter*/
SELECT DATEPART(dw,started_at) AS day_of_week, COUNT(DATEPART(dw,started_at)) AS Member_rides_TOTAL
FROM divvy_tripsdata
WHERE member_casual = 'member' AND (started_at BETWEEN '2021-07-01' AND '2021-09-30')
GROUP BY DATEPART(dw,started_at) 
ORDER BY DATEPART(dw,started_at)


SELECT DATEPART(dw,started_at) AS day_of_week, COUNT(DATEPART(dw,started_at)) AS Casual_rides_TOTAL
FROM divvy_tripsdata
WHERE member_casual = 'casual' AND (started_at BETWEEN '2021-07-01' AND '2021-09-30')
GROUP BY DATEPART(dw,started_at) 
ORDER BY DATEPART(dw,started_at)


/*This Query Shows which bike type was used and how many times it was used over the year*/
SELECT rideable_type,COUNT(rideable_type) AS Member_Bike_usage
FROM divvy_tripsdata
WHERE member_casual ='member' AND (started_at BETWEEN '2021-07-01' AND '2021-09-30')
GROUP BY rideable_type

SELECT rideable_type,COUNT(rideable_type) AS Casual_Bike_usage
FROM divvy_tripsdata
WHERE member_casual ='casual' AND (started_at BETWEEN '2021-07-01' AND '2021-09-30')
GROUP BY rideable_type

/*This query is for the total ride hours per day of week*/
SELECT DATENAME(dw,started_at) AS day_of_week, SUM(DATEDIFF(HH,started_at,ended_at)) AS Ride_Hours_Casual
FROM divvy_tripsdata
WHERE member_casual = 'casual' AND (started_at BETWEEN '2021-07-01' AND '2021-09-30') AND started_at <= ended_at
GROUP BY DATENAME(dw,started_at)
ORDER BY CASE
          WHEN DATENAME(dw,started_at) = 'Sunday' THEN 1
          WHEN DATENAME(dw,started_at) = 'Monday' THEN 2
          WHEN DATENAME(dw,started_at) = 'Tuesday' THEN 3
          WHEN DATENAME(dw,started_at) = 'Wednesday' THEN 4
          WHEN DATENAME(dw,started_at) = 'Thursday' THEN 5
          WHEN DATENAME(dw,started_at) = 'Friday' THEN 6
          WHEN DATENAME(dw,started_at) = 'Saturday' THEN 7
     END ASC;

SELECT DATENAME(dw,started_at) AS day_of_week, SUM(DATEDIFF(HH,started_at,ended_at)) AS Ride_Hours_Member
FROM divvy_tripsdata
WHERE member_casual = 'member' AND (started_at BETWEEN '2021-07-01' AND '2021-09-30') AND started_at <= ended_at
GROUP BY DATENAME(dw,started_at)
ORDER BY CASE
          WHEN DATENAME(dw,started_at) = 'Sunday' THEN 1
          WHEN DATENAME(dw,started_at) = 'Monday' THEN 2
          WHEN DATENAME(dw,started_at) = 'Tuesday' THEN 3
          WHEN DATENAME(dw,started_at) = 'Wednesday' THEN 4
          WHEN DATENAME(dw,started_at) = 'Thursday' THEN 5
          WHEN DATENAME(dw,started_at) = 'Friday' THEN 6
          WHEN DATENAME(dw,started_at) = 'Saturday' THEN 7
     END ASC;

/* This Query Shows the Bike Usage Count, Minimum, Maximum and Average Ride length in minutes Between Members & Casual Riders*/
SELECT member_casual, 
	   COUNT(rideable_type) Bike_usage,
	   MIN(DATEDIFF(MI,started_at,ended_at)) AS MIN_ride_length_in_minutes, 
	   MAX(DATEDIFF(MI,started_at,ended_at)) AS MAX_ride_length_in_minutes,
	   AVG(DATEDIFF(MI,started_at,ended_at)) AS Average_ride_length_in_minutes
FROM divvy_tripsdata
WHERE member_casual ='member' AND (started_at BETWEEN '2021-07-01' AND '2021-09-30') AND started_at <= ended_at
GROUP BY member_casual
UNION

SELECT member_casual, 
	   COUNT(rideable_type) Bike_usage,
	   MIN(DATEDIFF(MI,started_at,ended_at)) AS MIN_ride_length_in_minutes, 
	   MAX(DATEDIFF(MI,started_at,ended_at)) AS MAX_ride_length_in_minutes,
	   AVG(DATEDIFF(MI,started_at,ended_at)) AS Average_ride_length_in_minutes
FROM divvy_tripsdata
WHERE member_casual ='casual' AND (started_at BETWEEN '2021-07-01' AND '2021-09-30') AND started_at <= ended_at
GROUP BY member_casual

/* Top 25 Most Used Stations in this quarter*/
SELECT start_station_name,COUNT(start_station_name) AS number_of_Times_Used
FROM divvy_tripsdata
WHERE started_at BETWEEN '2021-07-01' AND '2021-09-30'
GROUP BY start_station_name
ORDER BY number_of_Times_Used DESC
OFFSET 0 ROWS FETCH FIRST 25 ROWS ONLY
