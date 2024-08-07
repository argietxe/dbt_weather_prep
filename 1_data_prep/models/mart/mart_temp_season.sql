SELECT city
		,season_name		
		,min(min_temp_c) as min_temp_c
		,max(max_temp_c) as max_temp_c
		,round(avg(avg_temp_c),2) as avg_temp_c
FROM prep_forecast_day
GROUP BY city, season_name 
ORDER BY season_name ASC



-- max_wind

-- min_temp_c
-- max_temp_c
-- avg_temp_c

