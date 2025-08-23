print'==================================================================='
print 'Creating view for gold layer'
print'==================================================================='

create view gold.fa_vehicle_market as
	select
		vi.vehicle_id,
		vi.manufacturer,
		vi.model,
		vi.country_of_manufacture,
		vi.color,
		sw.warranty_years,
		vi.year,
		sw.units_sold_2024,
		sw.price_usd
	from silver.vs_vehicle_info vi
	left join silver.vm_sales_warranty sw on vi.vehicle_id = sw.vehicle_id;


create view gold.dim_summary as
	select
		vi.vehicle_id,
		b.battery_type,
		b.charging_type,
		b.charge_time_hr,
		b.range_km,
		b.battery_capacity_kwh
	from silver.vs_vehicle_info vi
	left join silver.vs_battery b on vi.vehicle_id = b.vehicle_id;


create view gold.dim_safety as
select
    vi.vehicle_id,
    p.autonomous_level,
    p.safety_rating
from silver.vs_vehicle_info vi
left join silver.vs_performance p on vi.vehicle_id = p.vehicle_id;
