use AirTraffic;
############ Question 1 ############

#Question1-1
#How many flights were there in 2018 and 2019 separately?

SELECT  COUNT(*) As 2018Flights
FROM flights
WHERE YEAR(FlightDate) = 2018;

/** Number of flights in 2018 was 3218653 **/

SELECT  COUNT(*) as 2019Flights
FROM flights
WHERE YEAR(FlightDate) = 2019;
/** Number of flight in 2019 was 3302708  **/
/** The increased number of flights from 2018 to 2019 provides valuable information for the fund managers.
 It allows them to understand the overall demand for air travel and assess the performance and
 growth of the airlines. By comparing the flight counts between the two years, they can evaluate
 the revenue potential and market share of the airlines they are considering for investment. **/

#Question1-2 
#In total, how many flights were cancelled or departed late over both years?

SELECT
   COUNT(*) 
   FROM flights 
   WHERE cancelled = 1 OR DepDelay > 0;
   
   /** The result is '2633237'
 This information is significant for the fund managers as it highlights the potential operational
   challenges faced by the airlines. A high number of cancelled or delayed flights may indicate issues such
   as mechanical problems,weather condition etc.. **/
    
    
#Question 3-1
#Show the number of flights that were cancelled broken down by the reason for cancellation.

SELECT 
    CancellationReason, COUNT(*)
FROM
    flights 
WHERE Cancelled=1
GROUP BY CancellationReason;

/** 
Understanding the following distribution of cancellation reasons enables the fund managers to make informed investment decisions 
based on the airlines' operational strengths and potential risks associated with specific cancellation factors.
for example apart from weather factor , significant Carrier-related cancellations can occur due to various reasons, including maintenance issues,
 crew availability problems, or scheduling conflicts.It highlights potential areas where the airline 
 improve its processes to minimize disruptions.
 
'Weather','50225'
'Carrier','34141'
'National Air System','7962'
'Security','35' **/


#Question 4-1
#For each month in 2019, report both the total number of flights and percentage of flights cancelled.


SELECT
    MONTH(FlightDate) AS Month,
    COUNT(*) AS TotalFlights,
   Round( (COUNT(*) /(SELECT COUNT(*) FROM flights 
    WHERE YEAR(FlightDate) = 2019))* 100,2) AS PercentageCancelled
FROM
    flights
WHERE
    YEAR(FlightDate) = 2019
    AND cancelled = 1
GROUP BY
    MONTH(FlightDate)
    order by PercentageCancelled;
/** 
This result provides insights into the seasonal trends of flight cancellations and their potential impact on revenue.
The highest cancellation rates occur during the spring months of March, April, and May (Months 3, 4, and 5).
 These months experienced cancellation rates ranging from 0.21% to 0.22%. 
 It suggests that the airline faced significant disruptions and challenges during this period,
 leading to a higher percentage of flights being cancelled.

'12','1397','0.04'
'11','1580','0.05'
'10','2291','0.07'
'9','3318','0.10'
'8','3624','0.11'
'7','4523','0.14'
'2','5502','0.17'
'1','5788','0.18'
'6','6172','0.19'
'3','7079','0.21'
'5','6912','0.21'
'4','7429','0.22'
**/

############ Question 2 ############

#Question2-1
#Create two new tables, one for each year (2018 and 2019) showing the total miles traveled and number of flights broken down by airline.
DROP TABLE IF EXISTS Flights2018;
CREATE TABLE Flights2018 AS 
SELECT
    AirlineName,
    SUM(Distance) AS Total_Miles_Traveled,
    COUNT(*) AS Total_Flights
FROM flights
WHERE YEAR(FlightDate) = 2018
GROUP BY AirlineName;

/** 'Delta Air Lines Inc.','842409169','949283'
'American Airlines Inc.','933094276','916818'
'Southwest Airlines Co.','1012847097','1352552'
**/

DROP TABLE IF EXISTS Flights2019;
CREATE TABLE Flights2019 AS 

SELECT
    AirlineName,
    SUM(Distance) AS Total_Miles_Traveled,
    COUNT(*) AS Total_Flights
FROM flights
WHERE YEAR(FlightDate) = 2019
GROUP BY AirlineName;

/** 'Delta Air Lines Inc.','889277534','991986'
'American Airlines Inc.','938328443','946776'
'Southwest Airlines Co.','1011583832','1363946'
**/


#Question2-2
#Using your new tables, find the year-over-year percent change in total flights and miles traveled for each airline.

SELECT 
Flights2018.AirlineName ,
Flights2018.Total_flights AS 2018flights,
Flights2019.Total_flights AS 2019flights,
# below is the calculation the "Total flights" change percentage between 2018  and 2019
Round(((Flights2019.Total_flights - Flights2018.Total_flights)/Flights2018.Total_flights)*100,2) AS Totalflight_ChangePercentage ,

Flights2018.Total_Miles_Traveled AS 2018Miles_Traveled,
Flights2019.Total_Miles_Traveled AS 2019Miles_Traveled,

# calculation the "Total Miles Traveled" change percentage between 2018  and 2019
ROUND(((Flights2019.Total_Miles_Traveled - Flights2018.Total_Miles_Traveled)/Flights2018.Total_Miles_Traveled)*100,2) AS TotalMiles_ChangePercentage 

from Flights2018
Join Flights2019 on Flights2018.AirlineName=Flights2019.AirlineName;

/** Based on the provided results, it would be advisable for the fund managers 
to consider investing in Delta Air Lines, which exhibited consistent growth 
in both flight volume and miles traveled. American Airlines also demonstrated
 positive growth, although at a relatively smaller scale. Southwest Airlines ,
 on the other hand, showed less growth and a slight decline in miles traveled.

AirlineName,2018flights,2019flights,Totalflight_ChangePercentage,2018Miles_Traveled,2019Miles_Traveled,TotalMiles_ChangePercentage
'Delta Air Lines Inc.','949283','991986','4.50','842409169','889277534','5.56'
'American Airlines Inc.','916818','946776','3.27','933094276','938328443','0.56'
'Southwest Airlines Co.','1352552','1363946','0.84','1012847097','1011583832','-0.12'
**/

############ Question 3 ############
#Question 3-1
#What are the names of the 10 most popular destination airports overall? For this question, generate a SQL query that first joins flights and airports then does the necessary aggregation.

# This query performs the join operation directly without utilizing a subquery

SELECT  flights.DestAirportID, Count(*) AS AirportCount, airports.AirportName
FROM flights
JOIN airports ON airports.AirportID=flights.DestAirportID
GROUP BY flights.DestAirportID , airports.AirportName
ORDER BY AirportCount DESC
LIMIT 10;

#Question 3-2
#Answer the same question but using a subquery to aggregate & limit the flight data before
# your join with the airport information, hence optimizing your query runtime.

SELECT  dest_flights.DestAirportID, dest_flights.AirportCount, airports.AirportName
FROM (
    SELECT DestAirportID, COUNT(*) AS AirportCount
    FROM flights
    GROUP BY DestAirportID
) AS dest_flights
JOIN airports ON airports.AirportID = dest_flights.DestAirportID
ORDER BY dest_flights.AirportCount DESC
LIMIT 10; 

/** The first query has a runtime of 1.427, while the second query has a runtime of 10.643. 
This significant difference in runtime demonstrates the superiority of using a subquery
thats because subquery reduces the number of rows involved in the join operation between flights and airports. **/


############ Question 4 ############
#Question 4-1
#What is the number of unique aircraft each airline operated in total over 2018-2019

SELECT 
AirlineName , 
COUNT(DISTINCT Tail_Number) AS UniqueAircraftCount
FROM flights
GROUP BY AirlineName
ORDER BY UniqueAircraftCount DESC;

/** the result below indicates that American Airlines and Delta Air Lines ,
 with their larger Number of planes, may have higher operating costs due to 
 maintenance, crew,etc. 
 
 'American Airlines Inc.','993'
'Delta Air Lines Inc.','988'
'Southwest Airlines Co.','754'
 **/
 
# Question4-2
# What is the average distance traveled per aircraft for each of the three airlines?

Select AirlineName, Round(Sum(Distance)/COUNT(DISTINCT Tail_Number)) As Avg_Distance_Per_Aircraft 
FROM 
flights
GROUP BY AirlineName
ORDER BY Avg_Distance_Per_Aircraft Desc;

/** the result below indicates that 
Southwest Airlines with its higher average distance traveled per aircraft,
 may have higher fuel costs compared to American Airlines  and Delta Air Lines 
 Additionally, it may also incur higher equipment costs due to maintance and repairing aircraft from longer flights
 
'Southwest Airlines Co.','2684922'
'American Airlines Inc.','1884615'
'Delta Air Lines Inc.','1752719'
**/

############ Question 5 ############

#Question 5-1
# Find the average departure delay for each time-of-day across 
#the whole data set. Can you explain the pattern you see?

SELECT 

CASE
    WHEN HOUR(CRSDepTime) BETWEEN 7 AND 11 THEN "1-morning"
    WHEN HOUR(CRSDepTime) BETWEEN 12 AND 16 THEN "2-afternoon"
    WHEN HOUR(CRSDepTime) BETWEEN 17 AND 21 THEN "3-evening"
    ELSE "4-night"
END AS "time_of_day", 
AVG(IF(DepDelay<0,0,DepDelay))As AvgDepDelay
FROM flights
GROUP BY time_of_day;

/** Based on the result, we can observe that flights during the afternoon and evening
 tend to experience higher average departure delays compared to the morning and night. 
 This could be attributed to various factors such as increased air traffic, congestion at airports,
 and potential cascading delays throughout the day.
 It may indicate that the operational efficiency and on-time performance of flights deteriorate as the day progresses, 
with the highest delays occurring in the evening. 

'2-afternoon','13.6596'
'3-evening','18.3138'
'1-morning','7.9055'
'4-night','7.7866'

**/


#Question5-2
#find the average departure delay for each airport and time-of-day combination.

# I incorporated a subquery into the following query. Additionally, later on,
# I implemented another query using a join operation.which gives same result.
SELECT  airports.AirportName,
CASE
    WHEN HOUR(CRSDepTime) BETWEEN 7 AND 11 THEN "1-morning"
    WHEN HOUR(CRSDepTime) BETWEEN 12 AND 16 THEN "2-afternoon"
    WHEN HOUR(CRSDepTime) BETWEEN 17 AND 21 THEN "3-evening"
    ELSE "4-night"
END AS "time_of_day" ,
AVG(IF(DepDelay<0,0,DepDelay))As AvgDepDelay
FROM 
(SELECT Flights.OriginAirportID,CRSDepTime,DepDelay
 FROM flights) AS DepAirportID
 JOIN airports ON airports.AirportID=DepAirportID.OriginAirportID 
GROUP BY time_of_day, airports.AirportName
ORDER BY airports.AirportName,time_of_day;

#Same query , utilising Join Operation. which is more readable!!
#Question 5-2

SELECT  airports.AirportName,
CASE
    WHEN HOUR(CRSDepTime) BETWEEN 7 AND 11 THEN "1-morning"
    WHEN HOUR(CRSDepTime) BETWEEN 12 AND 16 THEN "2-afternoon"
    WHEN HOUR(CRSDepTime) BETWEEN 17 AND 21 THEN "3-evening"
    ELSE "4-night"
END AS "time_of_day" ,
AVG(IF(DepDelay<0,0,DepDelay))As AvgDepDelay

 FROM flights 
 JOIN airports ON airports.AirportID=flights.OriginAirportID 
GROUP BY time_of_day, airports.AirportName
ORDER BY airports.AirportName,time_of_day;

#Question5-3
#limit your average departure delay analysis to morning delays and airports with at least 10,000 flights.

SELECT  airports.AirportName,
AVG(IF(DepDelay<0,0,DepDelay))As AvgMorningDelay
 FROM 
 flights
 JOIN airports ON airports.AirportID=flights.OriginAirportID 
 WHERE 
	HOUR(flights.CRSDepTime) BETWEEN 7 AND 11 
GROUP BY airports.AirportName
HAVING COUNT(OriginAirportID) >= 10000
ORDER BY AvgMorningDelay DESC;

/** Here are the average departure delay values for the top 10 airports with the highest average morning delay,
Airlines can use this information to assess the efficiency of their operations at different airports and identify 
potential areas for improvement to reduce delays and enhance customer satisfaction 

'San Francisco International','13.6068'
'Chicago O\'Hare International','11.5389'
'Dallas/Fort Worth International','11.4443'
'Los Angeles International','10.9616'
'Seattle/Tacoma International','10.1776'
'Chicago Midway International','10.1540'
'Logan International','8.9300'
'Raleigh-Durham International','8.7763'
'Denver International','8.7339'
'San Diego International','8.6609'
**/


#Question 5-4
#name the top-10 airports with the highest average morning delay. In what cities are these airports located?


SELECT  airports.AirportName, airports.city,
AVG(IF(DepDelay<0,0,DepDelay))As AvgMorningDelay
 FROM 
 flights
 JOIN airports ON airports.AirportID=flights.OriginAirportID 
 WHERE 
	HOUR(flights.CRSDepTime) BETWEEN 7 AND 11 
GROUP BY airports.AirportName, airports.city
HAVING COUNT(OriginAirportID) >= 10000
ORDER BY AvgMorningDelay DESC
Limit 10;

/** 
The city and state information provides insight into the geographical locations of these airports and highlights 
the influence of regional factors on their operations and on-time performance.
 It's worth considering the unique characteristics and challenges associated with each
 city and state when analyzing the average morning delay at these airports.
 
'San Francisco International','San Francisco, CA','13.6068'
'Chicago O\'Hare International','Chicago, IL','11.5389'
'Dallas/Fort Worth International','Dallas/Fort Worth, TX','11.4443'
'Los Angeles International','Los Angeles, CA','10.9616'
'Seattle/Tacoma International','Seattle, WA','10.1776'
'Chicago Midway International','Chicago, IL','10.1540'
'Logan International','Boston, MA','8.9300'
'Raleigh-Durham International','Raleigh/Durham, NC','8.7763'
'Denver International','Denver, CO','8.7339'
'San Diego International','San Diego, CA','8.6609' **/
