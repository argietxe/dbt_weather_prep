
\COPY weather_dict FROM 'extracted_data_s.csv' DELIMITER ',' CSV HEADER;
--psql -U postgres -h 34.159.78.51 -p 5432 -d climate -f load_table_weather_dict.sql