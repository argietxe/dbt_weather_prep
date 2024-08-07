SELECT 
	city
	,MIN(sunlight) as shortest_day
	,MAX(sunlight) AS longest_day
	,AVG(sunlight) AS avg_daytime
FROM mart_astro_forecast_day
GROUP BY city
ORDER BY shortest_day


/* Let's find in what date this happens


SELECT 
    date, city, sunlight
FROM 
    astro_forecast_day
WHERE 
    (city = 'Reykjavik' AND sunlight IN ('04:06:00', '21:09:00'))
    OR (city = 'Berlin' AND sunlight IN ('07:39:00', '16:51:00'))
    OR (city = 'Vancouver' AND sunlight IN ('08:11:00', '16:15:00'))
    OR (city = 'Biarritz' AND sunlight IN ('08:57:00', '15:26:00'))
    OR (city = 'Auckland' AND sunlight IN ('09:37:00', '14:42:00'));

*/