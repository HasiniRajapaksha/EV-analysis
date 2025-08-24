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







print'==================================================================='
print'Date Exploration'
print'==================================================================='

-- Get for each year: max, min, and total units sold
select year, max(units_sold_2024) as max_units_sold, min(units_sold_2024) as min_units_sold, sum(units_sold_2024) as total_units_sold
from gold.fa_vehicle_market
group by year
order by year;



-- Get max units sold per year grouped by manufacturer and year
select 
    year, 
    max(units_sold_2024) as max_units,
	manufacturer
from gold.fa_vehicle_market
group by year, manufacturer;



-- Get details of vehicle(s) with maximum units sold per year (including model and country)
select 
	vm.year,
	vm.manufacturer,
	vm.units_sold_2024,
	vm.model,
	vm.country_of_manufacture
from gold.fa_vehicle_market vm
inner join(
	select 
		year, 
		max(units_sold_2024) as max_units
	from gold.fa_vehicle_market
	group by year
) as max_per_year
	on vm.year = max_per_year.year 
	and vm.units_sold_2024 = max_per_year.max_units
order by max_units desc;



-- Get all vehicle details with the highest units_sold_2024 overall
select *
from gold.fa_vehicle_market
where units_sold_2024 = (
    select max(units_sold_2024) 
    from gold.fa_vehicle_market
);

select manufacturer, year
from gold.fa_vehicle_market
where year in (
	select max(year) 
	from gold.fa_vehicle_market
	union
	select min(year) 
	from gold.fa_vehicle_market
);



print'==================================================================='
print'Measures Exploration'
print'==================================================================='

-- Which vehicle models are generating the highest revenue in 2024
select top 5
    model,
    manufacturer,
    year,
    units_sold_2024,
    price_usd,
    cast(units_sold_2024 * price_usd / 1000000000.0 as decimal(10,2)) as revenue_billion_usd
from gold.fa_vehicle_market
order by revenue_billion_usd desc;

-- What is the average warranty period offered by different manufacturers, and does it influence sales

select manufacturer,
	avg(warranty_years) as avg_warranty_years,
	avg(units_sold_2024) as avg_units_sold
from gold.fa_vehicle_market
group by manufacturer
order by avg_units_sold desc;

-- Which battery types are most common in high-range EVs (>400 km)?

select 
    battery_type,
    count(*) as count_high_range_ev
from gold.dim_summary
where range_km > 400
group by battery_type
order by count_high_range_ev desc;


-- What is the correlation between charging time and sales performance

select 
    ds.charge_time_hr,
    sum(vm.units_sold_2024) as total_units_sold
from gold.dim_summary ds
join gold.fa_vehicle_market vm 
    on ds.vehicle_id = vm.vehicle_id
where ds.charge_time_hr is not null
group by ds.charge_time_hr
order by ds.charge_time_hr;


-- Do higher safety ratings lead to higher sales volumes


select distinct
    ds.safety_rating,
    sum(vm.units_sold_2024) over (partition by ds.safety_rating) as total_units_sold
from gold.dim_safety ds
join gold.fa_vehicle_market vm
    on ds.vehicle_id = vm.vehicle_id
order by total_units_sold desc;



-- Which countries are producing the best-selling EVs in 2024?
           
select distinct top 5
    country_of_manufacture,
    sum(units_sold_2024) over (partition by country_of_manufacture) as total_sold
from gold.fa_vehicle_market
order by total_sold desc;


-- Is there a trend where higher autonomous levels correspond to higher vehicle prices?

select 
    ds.autonomous_level,
    cast(avg(vm.price_usd) over(partition by ds.autonomous_level) / 1000.0 as decimal(10,2)) as avg_price_K
from gold.dim_safety ds
join gold.fa_vehicle_market vm
    on ds.vehicle_id = vm.vehicle_id
order by avg_price_k desc;




