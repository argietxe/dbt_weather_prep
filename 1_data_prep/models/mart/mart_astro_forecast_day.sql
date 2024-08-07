-- creating a new table for astro, adding daytime column
WITH daytime_forecast_day AS (
    SELECT 
        date,
        city,
        region,
        country,
        sunrise,
        sunset,
        moonrise,
        moonset,
        moon_phase,
        moon_illumination,
        CASE 
            WHEN sunset ~ '\d{2}:\d{2} [AP]M' THEN CAST(sunset AS time) - CAST(sunrise AS time)
            ELSE NULL 	-- when the line is 'no sunset' in Iceland
        END AS daytime
    FROM staging_forecast_day
),
mart_astro_forecast_day AS(
		SELECT
		date,
		city,
		region,
        country,
        sunrise,
        sunset,
        moonrise,
        moonset,
        moon_phase,
        moon_illumination,
    		(daytime::time + INTERVAL '24 hour') as sunlight
		FROM daytime_forecast_day)
SELECT * FROM mart_astro_forecast_day