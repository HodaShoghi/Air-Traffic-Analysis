# Air Traffic Data Analysis Project

## Overview
This data analysis project explores air traffic data from 2018 and 2019, providing valuable insights for investment decisions regarding three major airline stocks. The project utilizes SQL queries for initial data analysis (Part 1) and Tableau for data visualization and interactive exploration (Part 2). The goal is to provide actionable insights for potential investors while presenting the analysis in a professional and informative manner.

## Data Description

The project uses two main tables: flights and airports. Here's a brief overview of the data:

flights table contains flight information, including flight date, airline details, departure and arrival information, and flight performance metrics.
airports table contains data about airports, including their names, locations, and other relevant details.

#### Table 1: flights

| Column                     | Type          | Description                                     |
| -------------------------- | ------------- | ----------------------------------------------- |
| FlightID                   | int           | Unique ID number for each flight (Primary Key)  |
| FlightDate                 | date          | Date of flight departure                        |
| ReportingAirline           | string        | DOT Unique Carrier Code                         |
| TailNumber                 | string        | FAA Tail number identifying flight             |
| FlightNumberReportingAirline | string      | Public flight number                            |
| OriginAirportID           | int           | Origin / departure airport code                 |
| DestAirportID             | int           | Destination / arrival airport code             |
| CRSDepTime                | string        | Scheduled local departure time                  |
| DepTime                   | string        | Actual local departure time                     |
| DepDelay                  | int           | Difference in minutes between scheduled and actual departure time |
| TaxiOut                   | int           | Taxi out time, in minutes                       |
| WheelsOff                 | string        | Wheels off in local time                        |
| WheelsOn                  | string        | Wheels on in local time                         |
| TaxiIn                    | int           | Taxi in time, in minutes                         |
| CRSArrTime                | string        | Scheduled arrival time                           |
| ArrTime                   | string        | Actual arrival time                              |
| ArrDelay                  | int           | Difference in minutes between scheduled and actual arrival |
| Cancelled                 | int           | Cancelled indicator                              |
| Diverted                  | int           | Diverted indicator                               |
| AirTime                   | int           | Flight time (total time in the air) in minutes  |
| Distance                  | float         | Distance between airports in miles              |
| AirlineName               | string        | DOT full airline name                            |
| CancellationReason        | string        | Reason for cancellation                         |

#### Table 2: airports

| Column       | Type    | Description              |
| ------------ | ------- | ------------------------ |
| AirportID    | int     | Unique airport code (Primary Key) |
| AirportName  | string  | Full name of airport      |
| City         | string  | Airport city             |
| Country      | string  | Airport country          |
| State        | string  | Airport state            |
| Latitude     | float   | Latitude of airport      |
| Longitude    | float   | Longitude of airport     |



## Part 1: Data Analysis in SQL 
The first part of the project involved SQL queries to answer specific business questions. Below are the questions addressed in Part 1:

### Key Insights from Part 1
- Total number of flights in 2018 and 2019.
- Number of canceled or delayed flights over both years.
- Reasons for flight cancellations.
- Monthly flight data for 2019, including cancellation percentages.



## Part 2: Visual Analytics in Tableau 
The second part of the project focuses on data visualization using Tableau to provide interactive insights. Below are the questions addressed in Part 2:

### Key Insights from Part 2
- Comparison of the three carriers in terms of total flights.
- Monthly flight trends for each carrier.
- Utilization of origin airports and distribution among carriers.
- On-time vs. delayed departures.
- Average departure delay by state.
- Departure delay patterns across states.
- Cancellation reasons and trends.

###  Carrier Comparison

#### Tableau Visualization 1: Total Flights Comparison

#### Tableau Visualization 2: Monthly Flight Trends

###  On-Time Performance

#### Tableau Visualization 3: On-Time vs. Delayed Departures (2019)

#### Tableau Visualization 4: Average Departure Delay by State

###  Fleet and Distance Analysis

#### Tableau Visualization 5: Flight Times vs. Distances

####  Year-over-Year Comparison

###  Interactive Dashboard

#### Tableau Dashboard: Departure Delays and Cancellations
###  Tableau Story


## Conclusion
The project provides comprehensive insights into the air traffic data, including flight performance, on-time performance, fleet analysis, and more. The Tableau visualizations enhance the understanding of the data and support investment decisions.

