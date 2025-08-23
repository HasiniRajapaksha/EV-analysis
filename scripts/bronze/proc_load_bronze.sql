print'==================================================================='
print'Loading data to bronze layer'
print'==================================================================='

exec bronze.load_bronze;


create or alter procedure bronze.load_bronze as 
begin
    declare @start_time datetime, @end_time datetime, @batch_end_time datetime, @batch_start_time datetime;
	begin try
	     
		set @batch_start_time = getdate();

	    set @start_time = getdate();
		truncate table bronze.vm_sales_warranty;
		bulk insert bronze.vm_sales_warranty
		from 'D:\hmr\Projects\EV_analysis\datasets\vehicle_market\sales_warranty.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print'Load duration: '+ cast(datediff(second,@start_time,@end_time) as nvarchar) + 'sec';






	    set @start_time = getdate();
		truncate table bronze.vs_battery;
		bulk insert bronze.vs_battery
		from 'D:\hmr\Projects\EV_analysis\datasets\vehicle_specs\battery_charging.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print'Load duration: '+ cast(datediff(second,@start_time,@end_time) as nvarchar) + 'sec';






	    set @start_time = getdate();
		truncate table bronze.vs_performance;
		bulk insert bronze.vs_performance
		from 'D:\hmr\Projects\EV_analysis\datasets\vehicle_specs\performance_environment.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);

		set @end_time = getdate();
		print'Load duration: '+ cast(datediff(second,@start_time,@end_time) as nvarchar) + 'sec';






		set @start_time = getdate();
		truncate table bronze.vs_vehicle_info;
		bulk insert bronze.vs_vehicle_info
		from 'D:\hmr\Projects\EV_analysis\datasets\vehicle_specs\vehicle_info.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print'Load duration: '+ cast(datediff(second,@start_time, @end_time) as nvarchar) + 'sec';



		set @batch_end_time = getdate();
		print'==================================================================='
		print'Total time spend on loading: ' + cast(datediff(second, @batch_end_time, @batch_start_time) as nvarchar) + 'sec';
		print'==================================================================='

	end try

	begin catch
		print'==================================================================='
		print'Error occoured  during loading ';
		print'==================================================================='
	end catch

end;
