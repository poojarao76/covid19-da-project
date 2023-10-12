SELECT 
    location, date, total_cases, total_deaths
FROM
    coviddeaths
WHERE
    continent IS NOT NULL
ORDER BY location , date;

/* 
Calculate daily percentage of death in the india
Likelihood to die from COVID-19 
*/

SELECT 
    location,
    date,
    total_cases,
    total_deaths,
    (total_deaths / total_cases) * 100 AS death_percentage
FROM
    coviddeaths
WHERE
    continent IS NOT NULL
	AND location LIKE 'india'
ORDER BY location , date;

/* total percentage of population got covid */

SELECT 
    location,
    date,
    total_cases,
    population,
    (total_cases / population) * 100 AS per_popul_infected
FROM
    coviddeaths
WHERE
    continent IS NOT NULL
ORDER BY location , date;

/* countries with highest infection rate compared to population */

SELECT 
    location,
    population,
    MAX(total_cases) AS highest_infection_count,
    MAX((total_cases / population)) * 100 AS max_percentage_infected_popul
FROM
    coviddeaths
WHERE
    continent IS NOT NULL
GROUP BY location , population
ORDER BY max_percentage_infected_popul DESC;

/* countries with highest death count per population */

SELECT 
    location, MAX(total_deaths) AS total_death_count
FROM
    coviddeaths
WHERE
    continent IS NOT NULL
        AND location NOT LIKE '%world%'
        AND location NOT LIKE '%high income%'
        AND location NOT LIKE '%upper middle income%'
        AND location NOT LIKE '%low income%'
        AND location NOT LIKE '%lower middle income%'
GROUP BY location
ORDER BY total_death_count DESC; 

/* continents with highest death count per population */

SELECT 
    continent, MAX(total_deaths) AS total_death_count
FROM
    coviddeaths
WHERE
    continent IS NOT NULL
        AND continent != ''
GROUP BY continent
ORDER BY total_death_count DESC; 


/* Highest death counts for each country in each continent */

SELECT continent, location, MAX(total_deaths) AS HighestDeathCount
FROM CovidDeaths
WHERE continent IS NOT NULL AND continent != ''
GROUP BY continent, location
ORDER BY continent, HighestDeathCount DESC, location;

/* Total cases and deaths and death percentage per year and month */

SELECT 
    YEAR(date) AS years,
    monthname(date) as month_name,
    SUM(new_cases) AS total_case,
    SUM(new_deaths) AS total_death,
    (SUM(new_deaths) / SUM(new_cases)) * 100 AS death_percentage
FROM
    coviddeaths
WHERE
    continent IS NOT NULL
        AND continent != ''
GROUP BY years, month_name
order by years, total_case;
        
/* join coviddeaths table and covidvaccinations table */

SELECT 
    *
FROM
    coviddeaths AS cd
        JOIN
    covidvaccinations AS cv ON cd.id = cv.id;
        
/* number of people vaccinated vs people in india */

SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations, cv.total_vaccinations, 
	(cv.total_vaccinations/cd.population)*100 AS Percent_vaccinated
FROM coviddeaths AS cd
JOIN covidvaccinations AS cv
ON cd.id= cv.id
WHERE cd.continent IS NOT NULL and cd.continent != ''and cd.location = 'india'
ORDER BY cd.location, cd.date;


/* Calculate total vaccinations from new vaccinations column using OVER and PARTITION BY */

SELECT 
    cd.continent,
    cd.location,
    cd.date,
    cd.population,
    cv.new_vaccinations, 
    SUM(cv.new_vaccinations) OVER (PARTITION BY cd.location order by cd.location, cd.date) AS people_vaccinated
FROM
    coviddeaths AS cd
        JOIN
    covidvaccinations AS cv ON cd.id = cv.id
WHERE
    cd.continent IS NOT NULL
        AND cd.continent != '' 
ORDER BY cd.continent , cd.location , cd.date;

/* calulate total vaccinations using CTE AND TEMP TABLE */

-- use CTE 

with populationVsVacciantion (continent, location, date, population, new_vaccinations, people_vaccinated) as
    ( select cd.continent,
    cd.location,
    cd.date,
    cd.population,
    cv.new_vaccinations, 
    SUM(cv.new_vaccinations) OVER (PARTITION BY cd.location order by cd.location, cd.date) AS people_vaccinated
FROM
    coviddeaths AS cd
        JOIN
    covidvaccinations AS cv ON cd.id = cv.id
WHERE
    cd.continent IS NOT NULL
        AND cd.continent != '' 
ORDER BY cd.continent , cd.location , cd.date
)
SELECT 
    *, (people_vaccinated/population) *100 as percent_vaccinated
FROM
    populationVsVacciantion;
    
-- use TEMP TABLE 

DROP TABLE if exists PercentPopulationVaccianted;
Create TABLE PercentPopulationVaccianted (
 continent nvarchar(255), 
 location nvarchar(255),
 date datetime,
 population numeric,
 new_vaccinations numeric,
 people_vaccinated numeric);
	
insert into PercentPopulationVaccianted
SELECT 
    cd.continent,
    cd.location,
    cd.date,
    cd.population,
    cv.new_vaccinations, 
    SUM(cv.new_vaccinations) OVER (PARTITION BY cd.location order by cd.location, cd.date) AS people_vaccinated
FROM
    coviddeaths AS cd
        JOIN
    covidvaccinations AS cv ON cd.id = cv.id
WHERE
    cd.continent IS NOT NULL
        AND cd.continent != '' 
ORDER BY cd.continent , cd.location , cd.date;

SELECT 
    *, (people_vaccinated / population) * 100 AS percent_vaccinated
FROM
    percentpopulationvaccianted
WHERE
    location = 'india'
ORDER BY location , date;
