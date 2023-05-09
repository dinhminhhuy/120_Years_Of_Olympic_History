DROP TABLE IF EXISTS OLYMPICS_HISTORY;
CREATE TABLE IF NOT EXISTS OLYMPICS_HISTORY
(
	id 			INT,
	name		VARCHAR,
	sex			VARCHAR,
	age			VARCHAR,
	height		VARCHAR,
	weight		VARCHAR,
	team 		VARCHAR,
	noc			VARCHAR,
	games		VARCHAR,
	year		INT,
	season		VARCHAR,
	city 		VARCHAR,
	sport		VARCHAR,
	event		VARCHAR,
	medal		VARCHAR
);
DROP TABLE IF EXISTS OLYMPICS_HISTORY_NOC_REGIONS;
CREATE TABLE IF NOT EXISTS OLYMPICS_HISTORY_NOC_REGIONS
(
	noc			VARCHAR,
	region		VARCHAR,
	note		VARCHAR
);

SELECT * FROM OLYMPICS_HISTORY;
SELECT * FROM OLYMPICS_HISTORY_NOC_REGIONS;

-- Question 1: How many olympics games have been held?
SELECT COUNT(DISTINCT games) AS total_olympic_games FROM OLYMPICS_HISTORY

-- Question 2: List down all Olympics games held so far.
SELECT distinct year, season, city
FROM OLYMPICS_HISTORY
ORDER BY year asc, season asc;

-- Question 3: Mention the total no of nations who participated in each olympics game?
    with all_countries as
        (select games, nr.region
        from olympics_history oh
        join olympics_history_noc_regions nr ON nr.noc = oh.noc
        group by games, nr.region)
    select games, count(1) as total_countries
    from all_countries
    group by games
    order by games;

-- Question 4: Which year saw the highest and lowest no of countries participating in olympics
    with all_countries as
              (select games, nr.region
              from olympics_history oh
              join olympics_history_noc_regions nr ON nr.noc=oh.noc
              group by games, nr.region),
          tot_countries as
              (select games, count(1) as total_countries
              from all_countries
              group by games)
      select distinct
      concat(first_value(games) over(order by total_countries)
      , ' - '
      , first_value(total_countries) over(order by total_countries)) as Lowest_Countries,
      concat(first_value(games) over(order by total_countries desc)
      , ' - '
      , first_value(total_countries) over(order by total_countries desc)) as Highest_Countries
      from tot_countries
      ;
	  
-- Question 5: Which nation has participated in all of the olympic games
   with tot_games as
              (select count(distinct games) as total_games
              from olympics_history),
          countries as
              (select games, nr.region as country
              from olympics_history oh
              join olympics_history_noc_regions nr ON nr.noc=oh.noc
              group by games, nr.region),
          countries_participated as
              (select country, count(1) as total_participated_games
              from countries
              group by country)
      select cp.*
      from countries_participated cp
      join tot_games tg on tg.total_games = cp.total_participated_games
      order by 1; 
	  
-- Question 6: Identify the sport which was played in all summer olympics.
/* 
1. find total no of summer olympic games
2. find for each sport, how many games where they played in
3. compare 1 & 2
*/
-- 1. find total no of summer olympic games
      with t1 as
          	(select count(distinct games) as total_games
          	from olympics_history where season = 'Summer'),

-- 2. find for each sport, how many games where they played in
         t2 as
          	(select distinct games, sport
          	from olympics_history where season = 'Summer'),
		 t3 as
          	(select sport, count(1) as no_of_games
          	from t2
          	group by sport)

-- 3. compare 1 & 2		
      select *
      from t3
      join t1 on t1.total_games = t3.no_of_games;
	  
-- Question 7: Which Sports were just played only once in the olympics.
      with t1 as
          	(select distinct games, sport
          	from olympics_history),
          t2 as
          	(select sport, count(1) as no_of_games
          	from t1
          	group by sport)
      select t2.*, t1.games
      from t2
      join t1 on t1.sport = t2.sport
      where t2.no_of_games = 1
      order by t1.sport;
	  
-- Question 8: Fetch the total no of sports played in each olympic games.
	with t1 as 
			(select distinct games, sport
			from olympics_history)
		, t2 as 
			(select games, count(1) as no_of_sports
			from t1
			group by games)
	select * from t2
	order by no_of_sports desc;

-- Question 9: Fetch oldest athletes to win a gold medal
	with t1 as 
		(select *
		from olympics_history
		where age <> 'NA' and medal = 'Gold'
		order by age desc)
	select * from t1 where age = (select max(age) from t1)

-- Question 10: Find the Ratio of male and female athletes participated in all olympic games.
	with t1 as
        	(select sex, count(1) as cnt
        	from olympics_history
        	group by sex),
        t2 as
        	(select *, row_number() over(order by cnt) as rn
        	 from t1),
        min_cnt as
        	(select cnt from t2	where rn = 1),
        max_cnt as
        	(select cnt from t2	where rn = 2)
    select concat('1 : ', round(max_cnt.cnt::decimal/min_cnt.cnt, 2)) as ratio
    from min_cnt, max_cnt;

-- Question 11: Fetch the top 5 athletes who have won the most gold medals
	with total_gold_medal as 
		(select name, team, count(medal) as total_gold_medals from olympics_history
		where medal = 'Gold'
		group by name,team)
		, rank_gold_medals as
		(select *, dense_rank() over (order by total_gold_medals desc) as ranking from total_gold_medal)
	select * from rank_gold_medals
	where ranking <= 5;

-- Question 12: Fetch the top 5 athletes who have won the most medals (gold/silver/bronze).
	with total_medal as 
		(select name, team, count(medal) as total_medals from olympics_history
		where medal <> 'NA'
		group by name,team)
	, rank_medals as
		(select *, dense_rank() over (order by total_medals desc) as ranking from total_medal)
	select name, team, total_medals from rank_medals
	where ranking <= 5

-- Question 13:  Fetch the top 5 most successful countries in olympics. Success is defined by no of medals won.
	with t1 as
		(select region, count(medal) as total_medals
		from olympics_history oh
		join olympics_history_noc_regions nr ON nr.noc=oh.noc
		where medal <> 'NA'
		group by region)
		, t2 as 
		(select *, rank() over (order by total_medals desc)
		from t1)
	select * from t2

-- Question 14: List down total gold, silver and bronze medals won by each country.
	with r1 as 
		(select region, medal
		from olympics_history
		join olympics_history_noc_regions ON olympics_history.noc = olympics_history_noc_regions.noc
		where medal <> 'NA')
	select region as country,
		count(case when medal = 'Gold' then region else null end) as gold,
		count(case when medal = 'Silver' then region else null end) as silver,
		count(case when medal = 'Bronze' then region else null end) as bronze
	from r1
	group by region
	order by gold desc, silver desc, bronze desc;

-- Question 15: List down total gold, silver and bronze medals won by each country corresponding to each olympic games.
	-- Cách 1:
	with r1 as 
		(select games, region, medal
		from olympics_history
		join olympics_history_noc_regions ON olympics_history.noc = olympics_history_noc_regions.noc
		where medal <> 'NA')
	select distinct games, region as country,
		count(case when medal = 'Gold' then region else null end) as gold,
		count(case when medal = 'Silver' then region else null end) as silver,
		count(case when medal = 'Bronze' then region else null end) as bronze
	from r1
	group by country, games
	order by games, country;
	
	-- Cách 2:
    SELECT substring(games,1,position(' - ' in games) - 1) as games
        , substring(games,position(' - ' in games) + 3) as country
        , coalesce(gold, 0) as gold
        , coalesce(silver, 0) as silver
        , coalesce(bronze, 0) as bronze
    FROM CROSSTAB('SELECT concat(games, '' - '', nr.region) as games
                , medal
                , count(1) as total_medals
                FROM olympics_history oh
                JOIN olympics_history_noc_regions nr ON nr.noc = oh.noc
                where medal <> ''NA''
                GROUP BY games,nr.region,medal
                order BY games,medal',
            'values (''Bronze''), (''Gold''), (''Silver'')')
    AS FINAL_RESULT(games text, bronze bigint, gold bigint, silver bigint);

-- Question 16: Identify which country won the most gold, most silver and most bronze medals in each olympic games.
CREATE EXTENSION TABLEFUNC;
    WITH temp as
    	(SELECT substring(games, 1, position(' - ' in games) - 1) as games
    	 	, substring(games, position(' - ' in games) + 3) as country
            , coalesce(gold, 0) as gold
            , coalesce(silver, 0) as silver
            , coalesce(bronze, 0) as bronze
    	FROM CROSSTAB('SELECT concat(games, '' - '', nr.region) as games
    					, medal
    				  	, count(1) as total_medals
    				  FROM olympics_history oh
    				  JOIN olympics_history_noc_regions nr ON nr.noc = oh.noc
    				  where medal <> ''NA''
    				  GROUP BY games,nr.region,medal
    				  order BY games,medal',
                  'values (''Bronze''), (''Gold''), (''Silver'')')
    			   AS FINAL_RESULT(games text, bronze bigint, gold bigint, silver bigint))
    select distinct games
    	, concat(first_value(country) over(partition by games order by gold desc)
    			, ' - '
    			, first_value(gold) over(partition by games order by gold desc)) as Max_Gold
    	, concat(first_value(country) over(partition by games order by silver desc)
    			, ' - '
    			, first_value(silver) over(partition by games order by silver desc)) as Max_Silver
    	, concat(first_value(country) over(partition by games order by bronze desc)
    			, ' - '
    			, first_value(bronze) over(partition by games order by bronze desc)) as Max_Bronze
    from temp
    order by games;
	
-- Question 17:
/*PIVOT
In Postgresql, we can use crosstab function to create pivot table.
crosstab function is part of a PostgreSQL extension called tablefunc.
To call the crosstab function, you must first enable the tablefunc extension by executing the following SQL command:*/

CREATE EXTENSION TABLEFUNC 
--(Nếu tạo ở trên rồi thì không cần tạo lại nữa);

--17. Identify which country won the most gold, most silver, most bronze medals and the most medals in each olympic games.

    with temp as
    	(SELECT substring(games, 1, position(' - ' in games) - 1) as games
    		, substring(games, position(' - ' in games) + 3) as country
    		, coalesce(gold, 0) as gold
    		, coalesce(silver, 0) as silver
    		, coalesce(bronze, 0) as bronze
    	FROM CROSSTAB('SELECT concat(games, '' - '', nr.region) as games
    					, medal
    					, count(1) as total_medals
    				  FROM olympics_history oh
    				  JOIN olympics_history_noc_regions nr ON nr.noc = oh.noc
    				  where medal <> ''NA''
    				  GROUP BY games,nr.region,medal
    				  order BY games,medal',
                  'values (''Bronze''), (''Gold''), (''Silver'')')
    			   AS FINAL_RESULT(games text, bronze bigint, gold bigint, silver bigint)) ,
    	tot_medals as
    		(SELECT games, nr.region as country, count(1) as total_medals
    		FROM olympics_history oh
    		JOIN olympics_history_noc_regions nr ON nr.noc = oh.noc
    		where medal <> 'NA'
    		GROUP BY games,nr.region order BY 1, 2)
    select distinct t.games
    	, concat(first_value(t.country) over(partition by t.games order by gold desc)
    			, ' - '
    			, first_value(t.gold) over(partition by t.games order by gold desc)) as Max_Gold
    	, concat(first_value(t.country) over(partition by t.games order by silver desc)
    			, ' - '
    			, first_value(t.silver) over(partition by t.games order by silver desc)) as Max_Silver
    	, concat(first_value(t.country) over(partition by t.games order by bronze desc)
    			, ' - '
    			, first_value(t.bronze) over(partition by t.games order by bronze desc)) as Max_Bronze
    	, concat(first_value(tm.country) over (partition by tm.games order by total_medals desc nulls last)
    			, ' - '
    			, first_value(tm.total_medals) over(partition by tm.games order by total_medals desc nulls last)) as Max_Medals
    from temp t
    join tot_medals tm on tm.games = t.games and tm.country = t.country
    order by games;