/**/

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
) divvy

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
     END ASC

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
     END ASC


/*This query calculates the total Hours spent riding*/
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
     END ASC


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
     END ASC

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
     END ASC
/* This query is for the counting how many users for the year between members & casuals as well as the minimum,maximum and average length of rides in minutes*/
SELECT member_casual, 
	   COUNT(rideable_type) Bike_usage,
	   MIN(DATEDIFF(MI,started_at,ended_at)) AS MIN_ride_length_in_minutes, 
	   MAX(DATEDIFF(MI,started_at,ended_at)) AS MAX_ride_length_in_minutes,
	   AVG(DATEDIFF(MI,started_at,ended_at)) AS Average_ride_length_in_minutes
FROM divvy_tripsdata
WHERE started_at < ended_at
GROUP BY member_casual;
