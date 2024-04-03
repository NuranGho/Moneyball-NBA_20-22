-- What are the most rebounds recorded by an individual player in the 2021-2022 season?

SELECT TOP 1 p.FirstName,p.LastName, sum(A.StatsValue) AS  totalrb
FROM player p LEFT JOIN (SELECT * FROM Match m LEFT JOIN MatchStats ms ON m.MatchNumber=ms.MatchNumber) A ON p.PlayerID=A.PlayerID
WHERE A.StatsID = (Select StatsID FROM TypeOfStats WHERE Stats_Name ='Total Rebounds') AND A.SeasonID = 2
GROUP BY p.FirstName,p.LastName
ORDER BY sum(A.StatsValue) DESC;

-- Best 3-PT shooter at home vs. away

SELECT TOP 1 t.statsID, m.playerID, firstName, lastName, m.statsValue
FROM typeOfStats t, player p, match ma, (SELECT * FROM matchStats WHERE statsID = 6 AND statsValue IS NOT NULL) m
WHERE t.statsID = m.statsID AND m.playerID = p.playerID AND ma.matchNumber = m.matchNumber
AND ArenaCode = (SELECT ArenaCode FROM Arena WHERE Venue = 'Madison Square Garden')
ORDER BY m.statsValue

SELECT TOP 1 t.statsID, m.playerID, firstName, lastName, m.statsValue
FROM typeOfStats t, player p, match ma, (SELECT * FROM matchStats WHERE statsID = 6 AND statsValue IS NOT NULL) m
WHERE t.statsID = m.statsID AND m.playerID = p.playerID AND ma.matchNumber = m.matchNumber
AND ArenaCode NOT IN (SELECT ArenaCode FROM Arena WHERE Venue = 'Madison Square Garden')
ORDER BY m.statsValue

-- What is the percentage of wins for the home team for each season?

SELECT top 1 seasonID, ROUND(((SELECT COUNT(*) FROM match WHERE [win/loss]  = 'W' AND seasonID = 1)/(SELECT COUNT(*) FROM match WHERE seasonid=1) *100),2) AS Team_Wins
FROM match

SELECT top 1 seasonID, ROUND(((SELECT COUNT(*) FROM match WHERE [win/loss]  = 'W' AND seasonID = 2)/(SELECT COUNT(*) FROM match WHERE seasonid=2) *100),2) AS Team_Wins
FROM match

-- Average points scored by the Knicks from the 2020-2021 season at home vs. away

SELECT ROUND(AVG(KnicksScore),2) AS [At Home]
FROM Match
WHERE SeasonID = (SELECT SeasonCode FROM Season WHERE Season = '2020-2021') AND ArenaCode = (SELECT ArenaCode FROM Arena WHERE Venue = 'Madison Square Garden')

SELECT ROUND(AVG(KnicksScore),2) AS "Away"
FROM Match
WHERE SeasonID = (SELECT SeasonCode FROM Season WHERE Season = '2020-2021') AND ArenaCode NOT IN (SELECT ArenaCode FROM Arena WHERE Venue = 'Madison Square Garden')

-- Best FT shooting percentage for an individual player from both seasons

SELECT DISTINCT S.Season, P.PlayerID, P.PlayerNo, P.FirstName, P.LastName, TOS.Stats_Name, MAX(MS.StatsValue) AS Highest_Free_Throw_Percentage
FROM TypeOfStats AS TOS, Season AS S, Player AS P, [Match] AS M, MatchStats AS MS
WHERE MS.PlayerID = P.PlayerID AND MS.StatsID = TOS.StatsID AND M.MatchNumber = MS.MatchNumber AND M.SeasonID = S.SeasonCode
AND TOS.StatsID = 9
GROUP BY S.Season, P.PlayerID, P.PlayerNo, P.FirstName, P.LastName, TOS.Stats_Name;
