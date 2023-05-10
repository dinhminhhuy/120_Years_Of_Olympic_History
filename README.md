
# 120 Years Of Olympic History Data analysis With SQL 





## 1. Dataset Introduce

### 1.1 About Dataset
This is a historical dataset on the modern Olympic Games, including all the Games from Athens 1896 to Rio 2016.

Olympic History Dataset is consisted of two file:

- Athlete_events.csv
- noc_regions.csv  

Link to Kaggle Dataset: https://www.kaggle.com/datasets/heesoo37/120-years-of-olympic-history-athletes-and-results
### 1.2 MetaData
The file athlete_events.csv contains 271116 rows and 15 columns. Each row corresponds to an individual athlete competing in an individual Olympic event (athlete-events). The columns are:
- ID - Unique number for each athlete
- Name - Athlete's name
- Sex - M or F
- Age - Integer
- Height - In centimeters
- Weight - In kilograms
- Team - Team name
- NOC - National Olympic Committee 3-letter code
- Games - Year and season
- Year - Integer
- Season - Summer or Winter
- City - Host city
- Sport - Sport
- Event - Event
- Medal - Gold, Silver, Bronze, or NA

The file noc_regions.csv contains 230 rows and 3 columns:
- NOC - National Olympic Committee 3-letter code
- Region - matches with regions in map_data("world")
- Note

## 2. Import, Connect to PostgreSQL 15
When importing athlete_events.csv files into PostgreSQL, you may get an error like the below screenshot shown:

![alt text](https://github.com/dinhminhhuy/120_Years_Of_Olympic_History/blob/main/Importing_Error.png?raw=true)

ERROR: unterminated CSV quoted field. So you should revise this record by deleting the quoted field in "Besik'".



