/*
Add columns for the year, month and week
Tip: Working with timestamps

Show average, highest and lowest temperature per week for each location
Tip: group by used date parts and location

Show max weekly average, highest and lowest temperatures per month for each location
Tip: group by used date parts and location

Join results from Step 1. and Step 2. to the original daily data.
Tip: In original table, add missing features on which the temporary named result sets will be join on */


select * from weather;

select city,
		date_part('week', date) as week,
		date_part('month', date) as month, 
		date_part('year', date) as year
		from weather
		group by city, week, month, year;
	
	
with weather_weekly as (
		select city,
		date_part('week', date) as week,
		round(avg(avgtemp_c),2) avg_temp_week, 
		round(max(maxtemp_c),2) max_temp_week, 
		round(min(mintemp_c),2) min_temp_week
		from weather
		group by city, week
		),
weather_monthly as (
		select city,
		date_part('month', date) as month,
		round(avg(avgtemp_c),2) avg_temp_month, 
		round(max(maxtemp_c),2) max_temp_month, 
		round(min(mintemp_c),2) min_temp_month
		from weather
		group by city, month
		),
final_join as (
		select *
		from weather
		left join weather_weekly
		on weather_weekly.city = weather.city
		left join weather_monthly
		on weather_monthly.city = weather.city
		)
select * from final_join;
		
		
		
		