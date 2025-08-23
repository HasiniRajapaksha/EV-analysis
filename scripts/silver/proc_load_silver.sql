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

exec silver.load_silver;

create or alter procedure silver.load_silver as
begin
    declare @start_time datetime, @end_time datetime, @batch_end_time datetime, @batch_start_time datetime;
	begin try
	     
		set @batch_start_time = getdate();

		print'==================================================================='
		print'Loading data to silver layer'
		print'==================================================================='

		set @start_time = getdate();
		truncate table silver.vm_sales_warranty
		insert into silver.vm_sales_warranty(
			Vehicle_ID,
			Price_USD,
			Units_Sold_2024,
			Warranty_Years
		)
		select 
		Vehicle_ID,
		Price_USD,
		Units_Sold_2024,
		Warranty_Years
		from bronze.vm_sales_warranty;
		set @end_time = getdate();
		print'Load duration: '+ cast(datediff(second,@start_time,@end_time) as nvarchar) + 'sec';



		set @start_time = getdate();
		truncate table silver.vs_battery
		insert into silver.vs_battery(
			Vehicle_ID,
			Battery_Type,	
			Battery_Capacity_kWh,
			Range_km,	
			Charging_Type,
			Charge_Time_hr
		)
		select 
			Vehicle_ID,
			Battery_Type,	
			Battery_Capacity_kWh,
			Range_km,	
			Charging_Type,
			Charge_Time_hr
		from bronze.vs_battery;
		set @end_time = getdate();
		print'Load duration: '+ cast(datediff(second,@start_time,@end_time) as nvarchar) + 'sec';



		set @start_time = getdate();
		truncate table silver.vs_performance
		-- autonums null value convert 0
		update bronze.vs_performance
		set Autonomous_Level = 0
		where Autonomous_Level is null;

		update bronze.vs_performance
		set Safety_Rating = 0
		where Safety_Rating is null;

		insert into silver.vs_performance(
			Vehicle_ID,	
			Autonomous_Level,	
			CO2_Emissions_g_per_km,	
			Safety_Rating
		)

		select 
			Vehicle_ID,	
			Autonomous_Level,	
			CO2_Emissions_g_per_km,	
			Safety_Rating
		from bronze.vs_performance;
		set @end_time = getdate();
		print'Load duration: '+ cast(datediff(second,@start_time,@end_time) as nvarchar) + 'sec';




		set @start_time = getdate();
		truncate table silver.vs_vehicle_info
		insert into silver.vs_vehicle_info(
			Vehicle_ID,	
			Manufacturer,	
			Model,	
			Year,
			Country_of_Manufacture,	
			Color
		)

		select 
			Vehicle_ID,	
			Manufacturer,	
			Model,	
			Year,
			Country_of_Manufacture,	
			Color
		from bronze.vs_vehicle_info;
		set @end_time = getdate();
		print'Load duration: '+ cast(datediff(second,@start_time,@end_time) as nvarchar) + 'sec';

		set @batch_end_time = getdate();
		print'==================================================================='
		print'Total time spend on loading: ' + cast(datediff(second, @batch_end_time, @batch_start_time) as nvarchar) + 'sec';
		print'==================================================================='

	end try

	begin catch
		print'==================================================================='
		print'Error occoured  during loading ';
		print'Error Message:'+ ERROR_MESSAGE();
		print'==================================================================='
	end catch

end;
