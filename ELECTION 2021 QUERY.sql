/*
Project: Tamil Nadu Election Data Analysis
Author: Prasanth Sundar

Description:
This SQL script contains queries used to analyze the Tamil Nadu election dataset.

Queries include:
- Top candidates per constituency
- Victory margin calculation
- Closest electoral contests
- Party vote share analysis

Note:
AI tools were used for syntax assistance and query refinement.
All analysis logic and project implementation were performed by myself.
*/

SELECT * FROM tamilnadu_ec
WHERE PARTY = 'DMK'

SELECT *
FROM (
    SELECT 
        Constituency,
        PARTY,
        Total_Votes,
        ROW_NUMBER() OVER (PARTITION BY Constituency ORDER BY Total_Votes DESC) AS rn
    FROM tamilnadu_ec
) t
WHERE rn <= 2
ORDER BY Constituency, rn;

SELECT PARTY,
COUNT(*) AS Seats_Won
FROM tamilnadu_ec
WHERE Win_Lost_Flag = 'WON'
GROUP BY PARTY
ORDER BY Seats_Won DESC;


SELECT *
FROM (
SELECT Constituency,
PARTY,
Total_Votes,
ROW_NUMBER() OVER (PARTITION BY Constituency ORDER BY Total_Votes DESC) AS Rank
FROM tamilnadu_ec
) t
WHERE Rank = 2;

SELECT TOP 10  PARTY, Total_Votes
FROM tamilnadu_ec
ORDER BY Total_Votes DESC;



WITH ranked AS (
    SELECT 
        Constituency,
        PARTY,
        CAST(Total_Votes AS INT) AS Total_Votes,
        ROW_NUMBER() OVER (PARTITION BY Constituency ORDER BY CAST(Total_Votes AS INT) DESC) AS rn
    FROM tamilnadu_ec
)

SELECT 
    w.Constituency,
    w.PARTY AS Winner,
    w.Total_Votes AS Winner_Votes,
    r.PARTY AS Runner_Up,
    r.Total_Votes AS RunnerUp_Votes,
    (w.Total_Votes - r.Total_Votes) AS Victory_Margin
FROM ranked w
JOIN ranked r
    ON w.Constituency = r.Constituency
WHERE w.rn = 1 
AND r.rn = 2
ORDER BY Victory_Margin DESC;

WITH ranked AS (
    SELECT 
        Constituency,
        PARTY,
        CAST(Total_Votes AS INT) AS Total_Votes,
        ROW_NUMBER() OVER (
            PARTITION BY Constituency 
            ORDER BY CAST(Total_Votes AS INT) DESC
        ) AS rn
    FROM tamilnadu_ec
)

SELECT 
    w.Constituency,
    w.PARTY AS Winner,
    w.Total_Votes AS Winner_Votes,
    r.PARTY AS Runner_Up,
    r.Total_Votes AS RunnerUp_Votes,
    (w.Total_Votes - r.Total_Votes) AS Victory_Margin
FROM ranked w
JOIN ranked r
    ON w.Constituency = r.Constituency
WHERE w.rn = 1 
AND r.rn = 2
ORDER BY Victory_Margin ASC;