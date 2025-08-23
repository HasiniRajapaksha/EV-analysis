-- ============================================
-- Data Quality Checks for GOLD Layer
-- ============================================

-- check for NULL vehicle_id in gold.fa_vehicle_market
print 'Checking for NULL vehicle_id in gold.fa_vehicle_market...'
select *
from gold.fa_vehicle_market
where vehicle_id is null;

print 'NULL vehicle_id check complete.'
print '-----------------------------------'

-- check for invalid or NULL safety_rating in gold.dim_safety
print 'Checking for NULL or invalid safety_rating in gold.dim_safety...'
select *
from gold.dim_safety
where safety_rating is null or safety_rating not between 1 and 5;

print 'Safety rating validation complete.'
print '-----------------------------------'

-- check for duplicate vehicle_id in gold.dim_summary
print 'Checking for duplicate vehicle_id in gold.dim_summary...'
select vehicle_id, count(*) as duplicate_count
from gold.dim_summary
group by vehicle_id
having count(*) > 1;

print 'Duplicate vehicle_id check in dim_summary complete.'
print '==================================='
