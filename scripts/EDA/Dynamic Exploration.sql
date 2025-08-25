print'==================================================================='
print'Dynamic Exploration'
print'==================================================================='

-- Get all distinct autonomous levels from dim_safety, sorted ascending
select distinct autonomous_level
from gold.dim_safety
order by autonomous_level;


-- Get all distinct safety ratings from dim_safety, sorted ascending
select distinct safety_rating
from gold.dim_safety
order by safety_rating;



-- Get all distinct combinations of safety rating and autonomous level, sorted by safety rating
select distinct safety_rating, autonomous_level
from gold.dim_safety
order by safety_rating;



-- Count how many distinct battery types exist in dim_summary
select count(*) as distinct_batteries
from(
	select distinct battery_type
	from gold.dim_summary
) as distinct_batteries;



-- Get all distinct charging types from dim_summary
select distinct charging_type
from gold.dim_summary;



-- Get distinct combinations of battery capacity and range, sorted by battery capacity
select distinct battery_capacity_kwh, range_km
from gold.dim_summary
order by battery_capacity_kwh;



-- Get all rows of battery capacity and range, sorted by battery capacity (may include duplicates)
select battery_capacity_kwh, range_km
from gold.dim_summary
order by battery_capacity_kwh;



-- Get all distinct battery capacities from dim_summary, sorted ascending
select distinct battery_capacity_kwh
from gold.dim_summary
order by battery_capacity_kwh;
