--COMPLETE CANADIAN FARM SQL SCRIPT
--DONE Feb 13,2026

--first import the .csv file into this database titled 'CanadianFarmProject' 


select *
from CanadianFarmProject.dbo.enhanced_canadian_farm_production_dataset


--1. Top crops by average yield per province:
Select province,crop_type, avg(average_yield_kg_per_hectare) as avg_yield 
from enhanced_canadian_farm_production_dataset
group by province, crop_type
order by province, avg_yield desc

--2. revenue trends over time
select year, sum(total_farm_value_dollars) as total_value  
from enhanced_canadian_farm_production_dataset
group by year
order by year

--3. impact of irrigation on yield:
select irrigation_used, avg(average_yield_kg_per_hectare) as avg_yield_total 
from enhanced_canadian_farm_production_dataset
group by irrigation_used
order by avg_yield_total desc

--4. how much organic vs non-organic produces
select organic_farming, avg(total_production_tonnes) as avg_production_tonnes 
from enhanced_canadian_farm_production_dataset
group by organic_farming
order by avg_production_tonnes desc

--check
select farm_size_category
from enhanced_canadian_farm_production_dataset
where farm_size_category is null

--5. farm size vs revenue per hectare
select farm_size_category, avg(total_farm_value_dollars/seeded_area_hectares) as avg_revenue_per_hectare
from enhanced_canadian_farm_production_dataset
group by farm_size_category
order by avg_revenue_per_hectare desc

--6. climate zone trends
select climate_zone, AVG(average_yield_kg_per_hectare) as avg_yield_in_kg_per_hectare
from enhanced_canadian_farm_production_dataset
group by climate_zone
order by avg_yield_in_kg_per_hectare desc

--7. top 5 provinces by total production in the latest year (2024).
select TOP 5 province, sum(total_production_tonnes) as total_production
from enhanced_canadian_farm_production_dataset
where year = 2024
group by province
order by total_production desc

--8 average farm price vs average yield per crop
select crop_type,cast(avg(average_farm_price_per_tonne) as decimal(10,2)) as avg_price_tonne, avg(average_yield_kg_per_hectare) as avg_yield_kg_per_hectare
from enhanced_canadian_farm_production_dataset
group by crop_type
order by avg_yield_kg_per_hectare desc


--9. Tractor adoption impact on average_yield
--check
select distinct technology_adoption_year
from enhanced_canadian_farm_production_dataset

SELECT 
    CASE 
        WHEN technology_adoption_year LIKE '%Tractors%' THEN 'Adopted Tractors'
        ELSE 'No Tractors'
    END AS tractors_adoption,
    AVG(average_yield_kg_per_hectare) AS avg_yield
FROM enhanced_canadian_farm_production_dataset
GROUP BY 
    CASE 
        WHEN technology_adoption_year LIKE '%Tractors%' THEN 'Adopted Tractors'
        ELSE 'No Tractors'
    END
ORDER BY avg_yield DESC



--10 policy change impact on avg yield
--check
select distinct policy_change_impact  from enhanced_canadian_farm_production_dataset

SELECT policy_change_impact,AVG(CAST(average_yield_kg_per_hectare AS DECIMAL(15,2))) AS avg_yield
FROM enhanced_canadian_farm_production_dataset
GROUP BY policy_change_impact
ORDER BY avg_yield DESC;



