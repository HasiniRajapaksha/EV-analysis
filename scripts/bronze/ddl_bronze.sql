if object_id ('bronze.vm_sales_warranty', 'u') is not null
drop table bronze.vm_sales_warranty;
create table bronze.vm_sales_warranty(
	Vehicle_ID int,
	Price_USD decimal(9, 2),
	Units_Sold_2024	int,
	Warranty_Years int
);

if object_id ('bronze.vs_battery', 'u') is not null
drop table bronze.vs_battery;
create table bronze.vs_battery(
	Vehicle_ID int,
	Battery_Type nvarchar(50),	
	Battery_Capacity_kWh decimal(5,2),	
	Range_km int,	
	Charging_Type nvarchar(50),	
	Charge_Time_hr decimal(5,2)
);

if object_id ('bronze.vs_performance', 'u') is not null
drop table bronze.vs_performance;
create table bronze.vs_performance(
	Vehicle_ID int,	
	Autonomous_Level int,	
	CO2_Emissions_g_per_km int,	
	Safety_Rating int

);

if object_id ('bronze.vs_vehicle_info', 'u') is not null
drop table bronze.vs_vehicle_info;
create table bronze.vs_vehicle_info(
	Vehicle_ID int,	
	Manufacturer nvarchar(50),	
	Model nvarchar (50),	
	Year int,
	Country_of_Manufacture nvarchar(50),	
	Color nvarchar(50)
);
