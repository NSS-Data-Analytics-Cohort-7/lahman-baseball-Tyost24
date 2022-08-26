Select * 
from teams


Select *
from people



--------------------------------------------------

-- 1. What range of years for baseball games played does the provided database cover?

--from 1864 to 2016

Select Distinct(yearid)
from teams as t
Union all 
Select Distinct(yearid)
From collegeplaying as c
order by yearid DESC


-- 2. Find the name and height of the shortest player in the database. How many games did he play in? What is the name of the team for which he played?

-- Eddie Gaedel is the shortest played at 43CM  for the St.Louis Browns and he only played one game.


Select p.namefirst, p.namelast, p.height, t.name, a.g_all as games_played
from people as p
left join appearances as a
on p.playerid = a.playerid
Left join teams as t
on a.teamid = t.teamid
Group by p.namefirst, p.namelast, p.height, t.name, games_played
Order by p.height


-- 3. Find all players in the database who played at Vanderbilt University. Create a list showing each player’s first and last names as well as the total salary they earned in the major leagues. Sort this list in descending order by the total salary earned. Which Vanderbilt player earned the most money in the majors?

-- David Price is the highest paid player at 24553888

Select Distinct concat(cast(p.namefirst as text),' ', cast(p.namelast as text)) as full_name, 
sum(s.salary) as salary, 
sc.schoolname as school
from people as p
left join salaries as s
on p.playerid = s.playerid
left Join collegeplaying as c
on p.playerid = c.playerid
Left Join schools as sc
on c.schoolid = sc.schoolid
Where sc.schoolname = 'Vanderbilt University'
and salary is not NULL
and sc.schoolid is not NULL
Group by full_name, school
Order by salary Desc


-- 4. Using the fielding table, group players into three groups based on their position: label players with position OF as "Outfield", those with position "SS", "1B", "2B", and "3B" as "Infield", and those with position "P" or "C" as "Battery". Determine the number of putouts made by each of these three groups in 2016.

-- Outfield: 29560, Infield: 58934, Battery: 39182.

Select
	sum(po) as total_putouts,
	CASE WHEN pos = 'OF' THEN 'Outfield'
	WHEN pos = 'SS' OR pos = '1B' OR pos = '2B' OR pos = '3B' THEN 'infield'
	WHEN pos = 'p' OR pos = 'C' THEN 'Battery'
	END AS position
FROM fielding
WHERE yearid = '2016'

GROUP by position


 -- 5. Find the average number of strikeouts per game by decade since 1920. Round the numbers you report to 2 decimal places. Do the same for home runs per game. Do you see any trends?
 

Select round(AVG(so/g), 2)  AS avg_strikeout , round(AVG(hr/g),2) as AVG_homeruns,
CASE WHEN yearid BETWEEN 1920 AND 1929 THEN '1920s'
	WHEN yearid BETWEEN 1930 AND 1939 THEN '1930s'
	WHEN yearid BETWEEN 1940 AND 1949 THEN '1940s'
	When yearid Between 1950 AND 1959 THen '1950s'
	When yearid Between 1960 and 1969 Then '1960s'
	WHEn yearid Between 1970 and 1979 THEN '1970s'
	WHEN yearid Between 1980 and 1989 then '1980s'
	WHEN yearid Between 1990 and 1999 then '1990s'
	When yearid Between 2000 and 2009 then '2000s'
	When yearid Between 2010 and 2019 then '2010s'
	End As decade
FROM teams
Where yearid >= 1920
GROUP BY decade
order by decade DESC;


-- 6. Find the player who had the most success stealing bases in 2016, where success is measured as the percentage of stolen base attempts which are successful. (A stolen base attempt results either in a stolen base or being caught stealing.) Consider only players who attempted at least 20 stolen bases.








