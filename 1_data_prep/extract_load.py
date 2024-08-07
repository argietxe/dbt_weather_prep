# Production file for extracting data from weather api
# Locations : Berlin, Reykjavik, Biarritz, Auckland, Vancouver
# Timeframe : 04-11-2023 -- 04-10-2024


# to run the file on the terminal, writing ' python extract_load.py'

# for the api key
from sqlalchemy_utils import database_exists, create_database
from sqlalchemy import create_engine, types

# for call api url
import json
import requests
import pprint # https://docs.python.org/3/library/pprint.html
import pandas as pd
import datetime
import os

from dotenv import load_dotenv
load_dotenv()
api_key = os.getenv('WEATHER_API')

# for call api url
import json
import requests
import pprint # https://docs.python.org/3/library/pprint.html
import pandas as pd
import datetime

# setting up the credentials
username = os.getenv('POSTGRES_USER')
password = os.getenv('POSTGRES_PW')
host = os.getenv('POSTGRES_HOST')
port = os.getenv('POSTGRES_PORT')
database = os.getenv('DB_CLIMATE')

# setting up the postgresql engine
url = f'postgresql://{username}:{password}@{host}:{port}/{database}'
engine = create_engine(url)

if not database_exists(engine.url):
    create_database(engine.url)


# calling data from weather api
locations = ['Berlin','Reykjavik','Biarritz','Auckland','Vancouver']

weather_dict = {'extracted_at':[], 'extracted_data':[]}

for city in locations:
     for day in pd.date_range(start='04/12/2023', end='04/11/2024'):
         requested_day = day.date()
         api_url = f'http://api.weatherapi.com/v1/history.json?key={api_key}&q={city}&dt={requested_day}'
         response = requests.request("GET", api_url)
         weather_dict['extracted_at'].append(datetime.datetime.now())
         weather_dict['extracted_data'].append(json.loads(response.text))
         if response.status_code == 200:
             print(f'attempt for {day.date()} in {city} resulted in {response.status_code}', end='\r')
         else:
             print(f'for date: {day.date()} and city: {locations} status code {response.status_code} -> research error')

# from dictionary to dataframe             
weather_dict = pd.DataFrame(weather_dict)

# from dataframe to sql using pandas
dtype_dict = {'extracted_at':types.DateTime, 'extracted_data':postgres_json}
weather_dict.to_sql('weather_raw_year', engine, if_exists='replace', dtype=dtype_dict)