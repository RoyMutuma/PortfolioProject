USE ciafactbook;

-- View entire table

Select * from factsbook;

-- Return the minimum population
Select *
from factsbook 
order by population asc
limit 1;

-- Return the maximum population
Select * 
from factsbook 
order by population desc
limit 1;

-- Return the minimum population growth
Select *
from factsbook 
order by population_growth asc
limit 1;

-- Return the maximum population growth
Select *
from factsbook 
order by population_growth desc
limit 1;

-- Return the average population
Select avg(population) 
from factsbook;

-- Return the average area
Select avg(area) 
from factsbook;

-- Return countries having a population above the average population
Select * 
from factsbook
where population > (select avg(population) from factsbook)
order by population desc;

-- Return countries having an area below the average area
Select * 
from factsbook
where area < (select avg(area) from factsbook)
order by area desc;

-- Return country with the most people and the country with the highest growth rate
Select *
from factsbook 
where population = (select max(population) from factsbook)
UNION
Select *
from factsbook 
where population_growth = (select max(population_growth) from factsbook);

-- Return the countries with the highest ratios of water to land? Which countries have more water than land?
Select *, area_water/area_land as water_to_land_ratio
from factsbook
order by water_to_land_ratio desc;

-- Return countries that will add the most people to their populations next year
Select *, round(population * population_growth/100) as population_added_next_year
from factsbook
order by population_added_next_year desc;

-- Return countries that have a higher death rate than birth rate
Select * 
from factsbook
where death_rate > birth_rate;

-- Return  countries that have the highest population/area ratio
Select *, round(population/area)
from factsbook
order by population/area  desc;

