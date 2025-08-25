===============================================================================
Change Over Time Analysis
===============================================================================

-- Year-over-Year Change in Average EV Price

with avg_price_by_year as (
    select 
        year,
        avg(price_usd) as avg_price
    from gold.fa_vehicle_market
    group by year
)
select 
    year,
    avg_price,
    lag(avg_price) over (order by year) as prev_year_price,
    case 
        when lag(avg_price) over (order by year) is null then null
        else round(((avg_price - lag(avg_price) over (order by year)) * 100.0) 
                   / lag(avg_price) over (order by year), 2)
    end as yoy_pct_change
from avg_price_by_year
order by year;


-- Year-over-Year % Change in Manufacturer Sales Volume

with sales_by_year_manu as (
    select 
        year,
        manufacturer,
        sum(units_sold_2024) as total_units_sold
    from gold.fa_vehicle_market
    group by year, manufacturer
)
select 
    year,
    manufacturer,
    total_units_sold,
    lag(total_units_sold) over (partition by manufacturer order by year) as prev_year_sales,
    case 
        when lag(total_units_sold) over (partition by manufacturer order by year) is null then null
        else round(((total_units_sold - lag(total_units_sold) over (partition by manufacturer order by year)) * 100.0) 
                   / lag(total_units_sold) over (partition by manufacturer order by year), 2)
    end as yoy_sales_pct_change
from sales_by_year_manu
order by manufacturer, year;


-- Trend of Average Warranty Period Over Time

select
    datepart(year, cast(concat(year, '-01-01') as date)) as year,
    avg(warranty_years) as avg_warranty_years
from gold.fa_vehicle_market
group by datepart(year, cast(concat(year, '-01-01') as date))
order by year;


-- Average Charging Time Trend

select
    datetrunc(year, cast(concat(vm.year, '-01-01') as date)) as year_start,
    avg(ds.charge_time_hr) as avg_charge_time_hr
from gold.fa_vehicle_market vm
join gold.dim_summary ds on vm.vehicle_id = ds.vehicle_id
group by datetrunc(year, cast(concat(vm.year, '-01-01') as date))
order by year_start;

-- Cumulative Sales Over Time

select
    year,
    sum(units_sold_2024) as yearly_sales,
    sum(sum(units_sold_2024)) over (order by year rows between unbounded preceding and current row) as cumulative_sales
from gold.fa_vehicle_market
group by year
order by year;

