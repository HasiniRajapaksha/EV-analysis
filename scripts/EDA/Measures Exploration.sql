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
