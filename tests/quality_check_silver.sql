--null check for vehicle_id in all bronze tables
select * from bronze.vm_sales_warranty where vehicle_id is null;
select * from bronze.vs_battery where vehicle_id is null;
select * from bronze.vs_performance where vehicle_id is null;
select * from bronze.vs_vehicle_info where vehicle_id is null;


-- check for duplicate vehicle_ids
select vehicle_id, count(*) as cnt
from bronze.vm_sales_warranty
group by vehicle_id
having count(*) > 1;

select vehicle_id, count(*) as cnt
from bronze.vs_battery
group by vehicle_id
having count(*) > 1;

select vehicle_id, count(*) as cnt
from bronze.vs_performance
group by vehicle_id
having count(*) > 1;

select vehicle_id, count(*) as cnt
from bronze.vs_vehicle_info
group by vehicle_id
having count(*) > 1;

-- check for negative or zero price or units sold
select *
from bronze.vm_sales_warranty
where price_usd <= 0 or units_sold_2024 < 0;


-- invalid warranty years
select *
from bronze.vm_sales_warranty
where warranty_years < 0 or warranty_years > 20;


-- future year check in vehicle info
select *
from bronze.vs_vehicle_info
where year > year(getdate());


-- null or blank manufacturer or model
select *
from bronze.vs_vehicle_info
where manufacturer is null or ltrim(rtrim(manufacturer)) = ''
   or model is null or ltrim(rtrim(model)) = '';


-- invalid battery capacity or charge time
select *
from bronze.vs_battery
where battery_capacity_kwh <= 0 or battery_capacity_kwh > 200
   or charge_time_hr < 0 or charge_time_hr > 24;


-- invalid safety rating (not 1 to 5)
select *
from bronze.vs_performance
where safety_rating not between 1 and 5;


-- invalid autonomous level (not 0 to 5)
select *
from bronze.vs_performance
where autonomous_level not between 0 and 5;


-- performance records without matching vehicle info
select p.*
from bronze.vs_performance p
left join bronze.vs_vehicle_info v on p.vehicle_id = v.vehicle_id
where v.vehicle_id is null;

