USE Coviddd;

SELECT * FROM  CovidDeaths;

SELECT * FROM  CovidVaccinations;

--1.SELECT Date,Total_Cases,new_cases,total_deaths & population from covid death

SELECT date,total_cases,new_cases,total_deaths,population FROM CovidDeaths;


--2.ORDER the above query on the basis of 1 & 2nd column;

SELECT date,total_cases,new_cases,total_deaths,population FROM CovidDeaths ORDER BY date,total_cases ASC;
SELECT date,total_cases,new_cases,total_deaths,population FROM CovidDeaths ORDER BY 1,2 ASC;

--3.Write query for total cases vs total death 

SELECT location,total_cases,total_deaths FROM CovidDeaths;

--4.Get the percentage of table total cases vs total death

SELECT date,location,total_cases,total_deaths,
(cast(total_deaths as float)/cast(total_cases as float))*100
as PercentageDeath from CovidDeaths
Where total_deaths IS NOT NULL;

--5.Total Cases vs population query

SELECT location,total_cases,population FROM CovidDeaths;

--6.Also GET percentage For total Cases vs population query

SELECT location,total_cases,population,
(cast(total_cases as float)/cast(population as float))*100 AS PercenmtageCases
FROM CovidDeaths;

--7.Country with highest infection rate com. to population

SELECT location,population,total_cases FROM CovidDeaths
where location <> 'World' order by total_cases desc;

--8.Country with Highest death count

 select location, sum(cast(total_deaths as int)) as totalDeath from CovidDeaths group by location
 order by 2 desc;

--9.Continent with Highest death count

SELECT TOP 1 continent,sum(cast(total_deaths as int)) as Highestdeath FROM CovidDeaths
WHERE continent IS NOT NULL
group by continent 
ORDER BY Highestdeath DESC;

--10.Continent with highest death count per population

select continent, sum(cast(total_deaths as float))/sum(cast(population as float)) as deat_rate 
from CovidDeaths group by continent order by deat_rate;

--11. Total number of new cases per day globaly .
 
 SELECT continent,new_cases,(cast(new_cases as float)/365) AS daily_cases FROM CovidDeaths


--12 Total death per day globaly

SELECT continent,total_deaths,(cast(total_deaths as float)/365) AS daily_death FROM CovidDeaths
WHERE total_deaths IS NOT NULL;

--13.Maximum death in United State

SELECT top 1 location,total_deaths FROM CovidDeaths 
WHERE location = 'United States' AND total_deaths IS NOT NULL ORDER BY total_deaths desc;

--14.Total Cases in Afghanistan;

SELECT location,SUM(total_cases) as Total_afg_cases FROM CovidDeaths WHERE location = 'Afghanistan'
group by location;

--15.TOP 3 Country with most death count ;

SELECT top 3 location,sum(cast(total_deaths as float)) as death_count FROM CovidDeaths 
group by location order by death_count desc;

--16.Country with highest infection but lower death rate;

select location, sum(cast(total_cases as float)) as totalCase, 
sum(cast(total_deaths as float))/sum(cast(total_cases as float)) as deathRate from CovidDeaths 
where total_deaths is not null and total_cases is not null
group by location order by totalCase desc, deathRate asc;


--17. Country Wise Death Rate

SELECT location,sum(cast(total_deaths as float))/sum(cast(total_cases as float))
as deathrate  FROM CovidDeaths  WHERE total_deaths IS NOT NULL AND total_cases IS NOT NULL
group by location;

--18. Total Country Avg Death Rate

SELECT avg(cast(total_deaths as float)/cast(total_cases as float)) as deathRate FROM CovidDeaths;

 --19.Find all Country  Which death Rate higher than Avg Death Rate 

select location, avg((cast(total_deaths as float)/cast(total_cases as float))) from CovidDeaths
where (cast(total_deaths as float)/cast(total_cases as float)) >
(SELECT avg(cast(total_deaths as float)/cast(total_cases as float)) as deathRate FROM CovidDeaths)
group by location;

--20.Join both table on basis of location & date 

select * from CovidDeaths
join CovidVaccinations on CovidDeaths.location = CovidVaccinations.location and
CovidDeaths.date = CovidVaccinations.date;

--21.Find total population that vacinated. ???

SELECT CovidDeaths.location,CovidDeaths.population, CovidVaccinations.total_vaccinations
FROM CovidDeaths JOIN CovidVaccinations
ON CovidDeaths.location = CovidVaccinations.location;

--22.When canada stareted their first vacination

select location, date, total_vaccinations from CovidVaccinations
where total_vaccinations is not null and location = 'Canada';

--23.Get total vacination of albaria country ???

SELECT location,SUM(cast(total_vaccinations as int)) from CovidDeaths 
WHERE location = 'Algeria' and total_vaccinations IS NOT NULL group by location ;

--24.Percentage of people vacinated in Every Country ;

select CovidDeaths.location, CovidDeaths.population, CovidVaccinations.total_vaccinations,
cast(CovidVaccinations.total_vaccinations as float)/cast( CovidDeaths.population as float) as vacinationRate
from CovidDeaths join CovidVaccinations on CovidDeaths.location = CovidVaccinations.location
where CovidVaccinations.total_vaccinations is not null;