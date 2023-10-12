
# Covid 19 World Data Anaysis Project

## Overview

For this Project tools used are Python, SQL, Power BI visualization.

The dataset is downloaded from this website: https://ourworldindata.org/covid-deaths

In this Project I have used python pandas to divide covid-19 world data dataset in two (covidDeaths.csv, covidVaccinations.csv) csv file and imported this both files in SQL and used SQL queries to extract data and used that queries to make report in Power BI.

SQL queries used in this project are:
• Basic select statements (select, where, group by)
• Aggregate functions (sum)
• Joins
• CTE's and Temp table
• Over and Pertition by

### Steps for projects:

First I Divided the dataset of covid-19 world data in two files with the use of python.

The files are:
1. covidDeaths.csv
2. covidVaccinations.csv

Used SQL queries to extract data and made csv files to use them further in Power BI Visualization.

The csv files made using sql queries are:

1. Global_DeathPercentagePerMonth.csv
2. Global_PercentPopulationVaccinated.csv
3. Global_TotalCases_TotalDeaths.csv
4. India_DeathPercentagePerMonth.csv
5. India_PercentPopulationVaccinated.csv

Power BI dashboard:

I have used card visual to show the global numbers of Total cases, Total Deaths, Average death percentage. I have visually presented Global and India's Total cases and Total Deaths each year and month using Line chart visual. I have visually presented Globally People got Vaccinated by continent and each year using Line chart visual. I have visually presented India's people got vaccinated per month and year using Line chart visual. I have shown Map visual to show the overall picture of People got infected per country wise. 



-------------------------------------

# My COVID-19 World Data Analysis Project

## Overview

For my COVID-19 World Data Analysis Project, I harnessed the power of several essential tools, including Python, SQL, and Power BI visualization. My dataset was sourced from the Our World in Data website, specifically focusing on COVID-19 deaths and vaccinations. 
The dataset is downloaded from this website: https://ourworldindata.org/covid-deaths

Here's a breakdown of how I tackled this project:

## Data Preparation
My first step involved using Python's pandas library to meticulously divide the extensive COVID-19 world data dataset into two distinct CSV files: `covidDeaths.csv` and `covidVaccinations.csv`. This data segmentation set the stage for more refined analysis and visualization.

## SQL Data Extraction
SQL was instrumental in extracting the critical insights I needed from my dataset. I leveraged SQL queries that covered a wide range of essential concepts:

- **Basic Select Statements**: I employed these statements for data retrieval, including `SELECT`, `WHERE`, and `GROUP BY` clauses.
- **Aggregate Functions**: The trusty `SUM` function came in handy for aggregating data effectively.
- **Joins**: To combine data from multiple tables, I made strategic use of SQL joins.
- **CTEs and Temp Tables**: For tackling complex queries with ease, I utilized Common Table Expressions (CTEs) and temporary tables.
- **Window Functions (OVER and PARTITION BY)**: Advanced data analysis was made possible through the use of window functions like `OVER` and `PARTITION BY`.

## CSV Files Created
To facilitate further analysis within Power BI, I created several CSV files using SQL queries. These files acted as invaluable resources for in-depth exploration:

1. `Global_DeathPercentagePerMonth.csv`: This file provided a comprehensive overview of global death percentages per month.
2. `Global_PercentPopulationVaccinated.csv`: It contained crucial data regarding the global percentage of the population vaccinated.
3. `Global_TotalCases_TotalDeaths.csv`: This file showcased global totals for cases and deaths.
4. `India_DeathPercentagePerMonth.csv`: For a closer look at India, I compiled death percentages per month.
5. `India_PercentPopulationVaccinated.csv`: This file shed light on the percentage of the Indian population that received vaccinations.

## Power BI Dashboard
My Power BI dashboard was the visual representation of the insights I had gathered. It included various types of visuals to effectively communicate my findings:

- **Card Visuals**: These visuals succinctly displayed global total cases, total deaths, and the average death percentage.
- **Line Chart Visuals**: To provide a detailed view, I used line charts to present global and India's total cases and total deaths, both on an annual and monthly basis. Additionally, I visualized global vaccinations by continent and year, as well as India's vaccinations by month and year.
- **Map Visual**: A map visual was employed to offer a holistic view of the distribution of COVID-19 infections on a country-by-country basis.

By seamlessly combining Python, SQL, and Power BI, I conducted a comprehensive analysis and visualization of COVID-19 data. This project allowed me to gain valuable insights into global and India-specific trends in cases, deaths, and vaccinations.
