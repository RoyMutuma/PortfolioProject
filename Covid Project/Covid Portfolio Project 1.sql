SELECT * FROM covidproject.covidvaccinations;

SELECT * FROM covidproject.coviddeaths
where continent !='';

SELECT location, date, total_cases, new_cases, total_deaths, population 
FROM covidproject.coviddeaths where continent !='';

-- Looking at Total Cases vs Total Deaths
-- Shows the likelihood of dying if you contract covid for sleected country

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage 
FROM covidproject.coviddeaths
where continent !='';

-- Looking at the Total Cases vs Population
-- Shows what percentage of the population has got covid for selected country

SELECT location, date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected 
FROM covidproject.coviddeaths
where continent !='';

-- Looking at countries with highest infection rates compared to population

SELECT location, population, max(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PercentPopulationInfected 
FROM covidproject.coviddeaths
where continent !=''
group by location, population
order by PercentPopulationInfected desc;

-- Lokking at population of people that died from covid per country
-- Showing countries with the highest death count per population

SELECT location, population, max(cast(total_deaths as unsigned)) as TotalDeathCount 
FROM covidproject.coviddeaths
where continent !=''
group by location
order by totaldeathcount desc;

-- LETS BREAK THINGS DOWN BY CONTINENT

-- Showing the continents with the highest death counts

SELECT continent, max(cast(total_deaths as unsigned)) as TotalDeathCount 
FROM covidproject.coviddeaths
where continent !=''
group by continent
order by totaldeathcount desc;


-- GLOBAL NUMBERS
-- Showing the total deaths as a percentage of total cases per day
SELECT date, sum(new_cases) as TotalCases, sum(cast(new_deaths as unsigned)) as TotalDeaths, sum(cast(new_deaths as unsigned))/sum(new_cases) * 100 
as DeathPercentage
FROM covidproject.coviddeaths
where continent !=''
group by date;

-- Showing the total deaths as a percentage of total cases 
SELECT sum(new_cases) as TotalCases, sum(cast(new_deaths as unsigned)) as TotalDeaths, sum(cast(new_deaths as unsigned))/sum(new_cases) * 100 
as DeathPercentage
FROM covidproject.coviddeaths
where continent !='';

-- Looking at total population vs vaccinations
SELECT death.continent, death.location, death.date, death.population, vaccine.new_vaccinations, 
sum(cast(vaccine.new_vaccinations as unsigned)) over (partition by death.location order by death.location, death.date) as RollingPeopleVaccinated
FROM covidproject.covidvaccinations vaccine
join covidproject.coviddeaths death
	on vaccine.location = death.location
    and vaccine.date = death.date
where death.continent != ''
order by 2,3;

-- USE CTE

With PopvsVac (Continent, Location, Date, Population, new_vaccinations, RollingPeopleVaccinated)
as
(SELECT death.continent, death.location, death.date, death.population, vaccine.new_vaccinations, 
sum(cast(vaccine.new_vaccinations as unsigned)) over (partition by death.location order by death.location, death.date) as RollingPeopleVaccinated
FROM covidproject.covidvaccinations vaccine
join covidproject.coviddeaths death
	on vaccine.location = death.location
    and vaccine.date = death.date
where death.continent != '')
Select *, (RollingPeopleVaccinated/Population)*100
from PopvsVac;

