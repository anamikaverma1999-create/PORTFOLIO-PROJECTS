Select *
From PortfolioProject..CovidDeaths
where continent is not null
Order By 3,4

--Select *
--From PortfolioProject..CovidVaccination
--Order By 3,4

-- Select Data that we are going to be using

Select Location, date, total_cases, new_cases,total_deaths,population 
From PortfolioProject..CovidDeaths
Order By 1,2

-- Looking at Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country
Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage 
From PortfolioProject..CovidDeaths
Where location like '%india%'
And continent is not null
Order By 1,2


-- Looking at the Total Cases vs Population
-- Shows what percentage of population got Covid

Select Location, date, population, total_cases, (total_cases/population)*100 as DeathPercentage 
From PortfolioProject..CovidDeaths
--Where location like '%india%'
Order By 1,2

-- Looking at Countries with Highest Infection Rate compared to Population

Select location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PopulationPercentInfected
From PortfolioProject..CovidDeaths
--Where location like '%india%'
Group By location, population
Order By PopulationPercentInfected desc

-- Showing Countries with death count per Population

Select Location, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
--Where location like '%india%'
Where continent is not null
Group By location
Order By TotalDeathCount desc


-- LET'S BREAK THINGS DOWN BY CONTINENT

Select location, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
--Where location like '%india%'
Where continent is null
Group By location
Order By TotalDeathCount desc

-- Showing continent with the highest death count per population

Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
--Where location like '%india%'
Where continent is NOT null
Group By continent
Order By TotalDeathCount desc

-- Global Numbers

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
--Where location like '%india%'
Where continent is not null
--Group by date
Order By 1,2
