SELECT city, season_name,
	sum(CASE WHEN condition_text = 'Sunny' THEN 1 ELSE 0 END) AS sunny_days,
	sum(CASE WHEN condition_text IN ('Moderate snow',
								'Patchy heavy snow',
								'Light snow',
								'Moderate or heavy snow showers',
								'Blizzard',
								'Light snow showers',
								'Patchy moderate snow',
								'Heavy snow',
								'Blowing snow',
								'Patchy light snow with thunder',
								'Patchy light snow',
								'Moderate or heavy snow with thunder')
						THEN 1 ELSE 0 END) AS snowy_days,
	sum(CASE WHEN condition_text IN ('Heavy rain at times'
								'Moderate rain',
								'Patchy rain possible',
								'Light drizzle',
								'Heavy rain',
								'Moderate or heavy rain shower',
								'Light rain',
								'Patchy light drizzle',
								'Light freezing rain',
								'Patchy light rain with thunder',
								'Moderate rain at times',
								'Patchy light rain',
								'Moderate or heavy sleet',
								'Light rain shower',
								'Moderate or heavy rain with thunder',
								'Light sleet showers',
								'Light sleet')
						THEN 1 ELSE 0 END) AS rainy_days,
	sum(CASE WHEN condition_text IN ('Fog',
								'Mist',
								'Partly cloudy',
								'Cloudy',
								'Overcast')
						THEN 1 ELSE 0 END) AS cloudy_days,
	sum(CASE WHEN condition_text IN ('Blizzard',
								'Patchy light snow with thunder',
								'Moderate or heavy snow with thunder',
								'Patchy light rain with thunder',
								'Moderate or heavy rain with thunder')
						THEN 1 ELSE 0 END) AS stormy_days
	FROM prep_forecast_day
GROUP BY city, season_name
ORDER BY season_name ASC
