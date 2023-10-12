/* SQL Queries for PowerBI Visualization: */

-- 1. Global_TotalCases_TotalDeaths

SELECT 
	SUM(new_cases) AS total_cases, 
	SUM(new_deaths) AS total_deaths,
	(SUM(new_deaths)/SUM(new_cases))*100 AS death_percentage
FROM coviddeaths
WHERE continent IS NOT NULL AND continent != '';


-- 2. Countries_PercentPopulationInfected

SELECT location, MAX(total_cases) AS highest_case_count, population, MAX((total_cases/population))*100 AS percent_population_infected
FROM coviddeaths
WHERE continent IS NOT NULL AND continent != ''
GROUP BY location, population
ORDER BY highest_case_count DESC;


-- 3. Global_DeathPercentagePerMonth

SELECT 
	YEAR(date) AS year,
	MONTH(date) AS month, 
	SUM(new_cases) AS total_cases, 
	SUM(new_deaths) AS total_deaths,
	(SUM(new_deaths)/SUM(new_cases))*100 AS death_percentage
FROM coviddeaths
WHERE continent IS NOT NULL AND continent != ''
GROUP BY YEAR(date), MONTH(date)
ORDER BY year, month;

-- 4. Global_PercentPopulationVaccinated

WITH vaccinated_per_population (continent, location, date, population, new_vaccinations_smoothed, Cumulative_vaccinations)
AS (
SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations_smoothed,
	SUM(cv.new_vaccinations_smoothed) OVER (PARTITION BY cd.location ORDER BY cd.location, cd.date)
	AS Cumulative_vaccinations
FROM Coviddeaths AS cd
JOIN Covidvaccinations AS cv
ON cd.id = cv.id
WHERE cd.continent IS NOT NULL AND cd.continent != ''
)
SELECT 
    *,
    (Cumulative_vaccinations / population) * 100 AS Percent_vaccinated
FROM
    vaccinated_per_population
ORDER BY location , date;

/* COUNTRY-SPECIFIC QUERIES: */

-- 5. India_DeathPercentagePerMonth

SELECT 
	YEAR(date) AS year,
	MONTH(date) AS month, 
	SUM(new_cases) AS total_cases, 
	SUM(new_deaths) AS total_deaths,
	(SUM(new_deaths)/SUM(new_cases))*100 AS death_percentage
FROM coviddeaths
WHERE location = 'india' AND continent IS NOT NULL AND continent != ''
GROUP BY YEAR(date), MONTH(date)
ORDER BY year, month;

-- 6. India_PercentPopulationVaccinated

WITH vaccinated_per_population (continent, location, date, population, new_vaccinations_smoothed, Cumulative_vaccinations)
AS (
SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations_smoothed,
	SUM(cv.new_vaccinations_smoothed)
	OVER (PARTITION BY cd.location ORDER BY cd.location, cd.date) 
	AS Cumulative_vaccinations
FROM Coviddeaths AS cd
JOIN Covidvaccinations AS cv
ON cd.location = cv.location AND cd.date = cv.date
WHERE cd.continent IS NOT NULL AND cd.continent != ''
)

SELECT *, (Cumulative_vaccinations/population)*100 AS percent_vaccinated
FROM vaccinated_per_population
WHERE location = 'india'
ORDER BY location, date;