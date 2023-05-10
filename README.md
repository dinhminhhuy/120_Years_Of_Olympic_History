
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


## 3. List of SQL Query

I wrote 20 SQL Queries using this data. For each of these queries, you would find the screen shot of the expected output. 

List of all these 20 queries mentioned below:
#### 1. How many olympics games have been held?
#### Expect output: 
![alt text](https://github.com/dinhminhhuy/120_Years_Of_Olympic_History/blob/main/Importing_Error.png?raw=true)
#### 2. List down all Olympics games held so far.
#### Expect output: 
![alt text](https://github.com/dinhminhhuy/120_Years_Of_Olympic_History/blob/main/Importing_Error.png?raw=true)
#### 3. Mention the total no of nations who participated in each olympics game?
#### Expect output: 
![alt text](https://github.com/dinhminhhuy/120_Years_Of_Olympic_History/blob/main/Importing_Error.png?raw=true)
#### 4. Which year saw the highest and lowest no of countries participating in olympics?
#### Expect output: 
![alt text](https://github.com/dinhminhhuy/120_Years_Of_Olympic_History/blob/main/Importing_Error.png?raw=true)
#### 5. Which nation has participated in all of the olympic games?
#### Expect output: 
![alt text](https://github.com/dinhminhhuy/120_Years_Of_Olympic_History/blob/main/Importing_Error.png?raw=true)
#### 6. Identify the sport which was played in all summer olympics.
#### Expect output: 
![alt text](https://github.com/dinhminhhuy/120_Years_Of_Olympic_History/blob/main/Importing_Error.png?raw=true)
#### 7. Which Sports were just played only once in the olympics?
#### Expect output: 
![alt text](https://github.com/dinhminhhuy/120_Years_Of_Olympic_History/blob/main/Importing_Error.png?raw=true)
#### 8. Fetch the total no of sports played in each olympic games.
#### Expect output: 
![alt text](https://github.com/dinhminhhuy/120_Years_Of_Olympic_History/blob/main/Importing_Error.png?raw=true)
#### 9. Fetch details of the oldest athletes to win a gold medal.
#### Expect output: 
![alt text](https://github.com/dinhminhhuy/120_Years_Of_Olympic_History/blob/main/Importing_Error.png?raw=true)
#### 10 .Find the Ratio of male and female athletes participated in all olympic games.
#### Expect output: 
![alt text](https://github.com/dinhminhhuy/120_Years_Of_Olympic_History/blob/main/Importing_Error.png?raw=true)
#### 11. Fetch the top 5 athletes who have won the most gold medals.
#### Expect output: 
![alt text](https://github.com/dinhminhhuy/120_Years_Of_Olympic_History/blob/main/Importing_Error.png?raw=true)
#### 12. Fetch the top 5 athletes who have won the most medals (gold/silver/bronze).
#### Expect output: 
![alt text](https://github.com/dinhminhhuy/120_Years_Of_Olympic_History/blob/main/Importing_Error.png?raw=true)
#### 13. Fetch the top 5 most successful countries in olympics. Success is defined by no of medals won.
#### Expect output: 
![alt text](https://github.com/dinhminhhuy/120_Years_Of_Olympic_History/blob/main/Importing_Error.png?raw=true)
#### 14. List down total gold, silver and broze medals won by each country.
#### Expect output: 
![alt text](https://github.com/dinhminhhuy/120_Years_Of_Olympic_History/blob/main/Importing_Error.png?raw=true)
#### 15. List down total gold, silver and broze medals won by each country corresponding to each olympic games.
#### Expect output: 
![alt text](https://github.com/dinhminhhuy/120_Years_Of_Olympic_History/blob/main/Importing_Error.png?raw=true)
#### 16. Identify which country won the most gold, most silver and most bronze medals in each olympic games.
#### Expect output: 
![alt text](https://github.com/dinhminhhuy/120_Years_Of_Olympic_History/blob/main/Importing_Error.png?raw=true)
#### 17. Identify which country won the most gold, most silver, most bronze medals and the most medals in each olympic games.
#### Expect output: 
![alt text](https://github.com/dinhminhhuy/120_Years_Of_Olympic_History/blob/main/Importing_Error.png?raw=true)
#### 18. Which countries have never won gold medal but have won silver/bronze medals?
#### Expect output: 
![alt text](https://github.com/dinhminhhuy/120_Years_Of_Olympic_History/blob/main/Importing_Error.png?raw=true)
#### 19. In which Sport/event, China has won highest medals?
#### Expect output: 
![alt text](https://github.com/dinhminhhuy/120_Years_Of_Olympic_History/blob/main/Importing_Error.png?raw=true)
#### 20. Break down all olympic games where China won medal for Badminton and how many medals in each olympic games.
#### Expect output: 
![alt text](https://github.com/dinhminhhuy/120_Years_Of_Olympic_History/blob/main/Importing_Error.png?raw=true)
