select count(*)
from(
	select Vehicle_ID, count(*) as cnt
	from bronze.vm_sales_warranty
	group by Vehicle_ID
	having count(*) = 1
)one_time_vehicles;


-- check wherether unwanted sapace in between
select  count(*)
from bronze.vs_battery
where Battery_Type != trim( Battery_Type);
