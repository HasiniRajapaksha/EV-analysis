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
