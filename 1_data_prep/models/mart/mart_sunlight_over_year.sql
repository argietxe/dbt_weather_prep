WITH auckland as (
	SELECT date, sunlight as Auckland
	FROM mart_astro_forecast_day
	WHERE city = 'Auckland'
),
berlin as (
	SELECT date, sunlight as Berlin
	FROM mart_astro_forecast_day
	WHERE city = 'Berlin'
),
biarritz as (
	SELECT date, sunlight as Biarritz
	FROM mart_astro_forecast_day
	WHERE city = 'Biarritz'
),
reykjavik as (
	SELECT date, sunlight as Reykjavik
	FROM mart_astro_forecast_day
	WHERE city = 'Reykjavik'
),
vancouver as (
	SELECT date, sunlight as Vancouver
	FROM mart_astro_forecast_day
	WHERE city = 'Vancouver'
)
SELECT auckland.date
		,auckland.Auckland
		,berlin.Berlin
		,biarritz.Biarritz
		,reykjavik.Reykjavik
		,vancouver.Vancouver
	FROM auckland
	JOIN berlin
	ON auckland.date = berlin.date
	JOIN biarritz
	ON auckland.date = biarritz.date
	JOIN reykjavik
	ON auckland.date = reykjavik.date
	JOIN vancouver
	ON auckland.date = vancouver.date
	
