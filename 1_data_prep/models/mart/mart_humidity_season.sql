SELECT city
		,season_name		
		,round(avg(avg_humidity),2) as avg_humidity
		,sum(daily_will_it_rain) as total_rainy_days
		,sum(total_precip_mm) as total_precip_mm
		,sum(daily_will_it_snow) as total_snowy_days
		,sum(total_snow_cm) as total_snow_cm
FROM prep_forecast_day
GROUP BY city, season_name
ORDER BY season_name ASC



-- daily_will_it_rain 0 or 1
-- total_precip_mm


-- daily_will_it_snow 0 or 1
-- total_snow_cm


-- avg_humidity

-- max_wind

-- min_temp_c
-- max_temp_c
-- avg_temp_c

