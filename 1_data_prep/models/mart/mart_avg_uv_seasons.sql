SELECT season_name, city, round(avg(uv),2) uv_avg
FROM prep_forecast_day
GROUP BY city, season_name
ORDER BY season_name, uv_avg DESC