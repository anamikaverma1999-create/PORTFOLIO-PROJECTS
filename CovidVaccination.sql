Select *
From PortfolioProject..CovidVaccination


--JOIN

Select *
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccination vac
    On dea.location = vac.location
    and dea.date = vac.date


--Looking at Total Population vs Vaccination

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(convert(int, vac.new_vaccinations)) OVER(Partition by dea.location Order by dea.location, dea.date) as CumulativePeopleVaccinated
--, (CumulativePeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccination vac
    On dea.location = vac.location
    and dea.date = vac.date
Where dea.continent is not null
Order by 2,3

--USE CTE

With PopvsVac (Continent, location, date, Population, new_vaccinations, CumulativePeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(convert(int, vac.new_vaccinations)) OVER(Partition by dea.location Order by dea.location, dea.date) as CumulativePeopleVaccinated
--, (CumulativePeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccination vac
    On dea.location = vac.location
    and dea.date = vac.date
Where dea.continent is not null
--Order by 2,3
)
Select *, (CumulativePeopleVaccinated/population)*100
From PopvsVac


--TEMP TABLE

Drop Table if exists #PercertPopulationVaccinated
Create Table #PercertPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
CumulativePeopleVaccinated numeric
)

Insert into #PercertPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(convert(int, vac.new_vaccinations)) OVER(Partition by dea.location Order by dea.location, dea.date) as CumulativePeopleVaccinated
--, (CumulativePeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccination vac
    On dea.location = vac.location
    and dea.date = vac.date
--Where dea.continent is not null
--Order by 2,3

Select *, (CumulativePeopleVaccinated/population)*100
From #PercertPopulationVaccinated


--Creating View to store data for later visualizations
USE PortfolioProject;
Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(convert(int, vac.new_vaccinations)) OVER(Partition by dea.location Order by dea.location, dea.date) as CumulativePeopleVaccinated
--, (CumulativePeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccination vac
    On dea.location = vac.location
    and dea.date = vac.date
Where dea.continent is not null
--Order by 2,3


Select *
From PercentPopulationVaccinated
