This flow includes the work after having downloaded the kaggle dataset and connected the postgres application to the Tableau desktop application.
The dataset link can be found from the readme file.

------------------------------------------------------------------
1. Introduction
------------------------------------------------------------------
This dataset contains data about the total number of the population at different periods of time between 1970 and 2022.
The table includes information about;
the country name, 
its capitals,
the continent they are in, 
the total area of the countries,
the population density for each country,
the growth rate and the total percentage of each country's population compared to the whole.
We first create the table naming "world_population" by using the pgadmin interface.
------------------------------------------------------------------
2. Data Import, Cleaning and Analysis
------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public."world_population"
(
    "Rank" integer primary key,
    "CCA3" VARCHAR(50),
    "Country" VARCHAR(50),
    "Capital" VARCHAR(50),
    "Continent" VARCHAR(50),
    "2022_Population" integer,
    "2020_Population" integer,
    "2015_Population" integer,
    "2010_Population" integer,
    "2000_Population" integer,
    "1990_Population" integer,
    "1980_Population" integer,
    "1970_Population" integer,
    "Area_km2" integer,
    "Density_per_km2" DECIMAL(10,4),
    "Growth_Rate" DECIMAL(7,4),
    "World_Population_Percentage" DECIMAL(5,2)
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS public."world_population"
    OWNER to postgres;
    
-----------------------------
At this point, you can proceed to get the data from the file by choosing one among three options. I've chosen to get it with the copy function.
If face any trouble with file reading authorisation, you need to grant authorisation to everyone for the relevant file that you download from the Kaggle.

-----------------------------

COPY public."world_population"("Rank","CCA3","Country","Capital","Continent","2022_Population","2020_Population","2015_Population","2010_Population","2000_Population","1990_Population","1980_Population","1970_Population","Area_km2","Density_per_km2","Growth_Rate","World_Population_Percentage") 
FROM 'C:\Users\90537\Downloads\world_population.csv' 
DELIMITER ',' 
CSV HEADER;

-----------------------------
/* For further action, we take a copy of the main table in the same database. */

SELECT * 
INTO world_population2
FROM world_population;

-----------------------------
/* Checking for any NULL field */

SELECT * 
FROM world_population2
WHERE 
	"Rank" is null OR
    "CCA3" is null OR
    "Country" is null OR
    "Capital" is NULL OR
    "Continent" is null OR
    "2022_Population" is null OR
    "2020_Population" is null OR
    "2015_Population" is null OR
    "2010_Population" is null OR
    "2000_Population" is null OR
    "1990_Population" is null OR
    "1980_Population" is null OR
    "1970_Population" is null OR
    "Area_km2" is null OR
    "Density_per_km2" is null OR
    "Growth_Rate" is null OR
    "World_Population_Percentage" is null;

-----------------------------
/* See the total number of countries and continents respectively. */

SELECT 
    COUNT(DISTINCT "Country") AS total_country, 
    COUNT(DISTINCT "Continent") AS total_continent
FROM world_population2;
-----------------------------
/* See how many countries each continent covers */

SELECT "Continent", COUNT("Country")
FROM world_population2
GROUP BY "Continent"
ORDER BY COUNT("Country") DESC;
-----------------------------
/* See which continent has the most crowded countries in. Half of them are located in Asia. */

SELECT "Country", "2022_Population", "Continent"
FROM world_population2
ORDER BY "2022_Population" DESC
LIMIT 10;

-----------------------------

/* The total number of population each continent has */

CREATE TABLE "en_kalabalik_kita_2022" AS
SELECT "Continent", SUM("2022_Population")
FROM world_population2
GROUP BY "Continent"
ORDER BY SUM("2022_Population") DESC;


-----------------------------

/* The countries that are the most crowded and have the highest density per km2 rate. */

SELECT "Rank", "Country", "Density_per_km2", "World_Population_Percentage"
FROM world_population2
WHERE "World_Population_Percentage" > 1.5
ORDER BY "Density_per_km2" DESC;

-----------------------------

/* For both 2 and 7 year population increase by number difference show that India is in the 1st place with a 10 million and 60 million gap respectively (Between India and Nigeria).
CREATE TABLE "7_year_gap_by_number" AS
SELECT "Country","2022_Population" - "2020_Population" AS "2_year_gap", "2022_Population" - "2015_Population" AS "7_year_gap", "Growth_Rate"
FROM world_population2
ORDER BY "7_year_gap" DESC;
-----------------------------
/* Countries having the highest gap by rate in the population increase */

CREATE TABLE "increase_by_rate_in_52_years" AS
SELECT "Rank","Country", "1970_Population", "2022_Population", "2022_Population" - "1970_Population" AS "52_year_gap", ("2022_Population" - "1970_Population") / "1970_Population" AS "gap_by_rate"
FROM world_population2
ORDER BY "gap_by_rate" DESC
LIMIT 5;

-----------------------------
/* The continent total population for each time period */

CREATE TABLE "kita_nüfus_1970_2022" AS
SELECT "Continent", SUM("1970_Population") AS "1970_total", SUM("1980_Population") AS "1980_total", SUM("1990_Population") AS "1990_total", SUM("2000_Population") AS "2000_total", SUM("2010_Population") AS "2010_total", SUM("2015_Population") AS "2015_total", SUM("2020_Population") AS "2020_total", SUM("2022_Population") AS "2022_total"
FROM world_population2
GROUP BY "Continent"
ORDER BY "2022_total" DESC;

-----------------------------
CREATE TABLE "density_population_correlation" AS
SELECT "Rank","Country", "Density_per_km2"
FROM world_population2
ORDER BY "Density_per_km2" DESC
LIMIT 10;


-----------------------------
Some important insight from the data:
-----------------------------
    - There are total of 234 countries and no missing values for any of fields in the table.
    - The list has information for 6 different continents.
    - There are 8 different columns showing the population number from different years between this period (1970 - 2022).
    - Asia is always at the first place among other continents regarding the total population number.
    - 5 of the all first 10 most crowded countries are from Asia.
    - United Arab Emirates' population is currently 30 times bigger than its number in 1970, which is the biggest rate of increase among other countries.
------------------------------------------------------------------
3. Data Visualisation
------------------------------------------------------------------
The rest of the project is to be done and displayed through the link below. The visualisation is completed thanks to the Tableau desktop application.
Link: https://public.tableau.com/app/profile/cemkurt/viz/Dashboard_16640559210870/Dashboard1?publish=yes
