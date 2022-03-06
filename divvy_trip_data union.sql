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