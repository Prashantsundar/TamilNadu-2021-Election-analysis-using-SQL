# TamilNadu-2021-Election-analysis-using-SQL
SQL-based analysis of Tamil Nadu Assembly Election(2021) dataset to identify constituency-level voting patterns, victory margins, and competitive seats

The analysis focuses on identifying:

Winning parties

Victory margins

Closest electoral contests

Party vote share

Top Queries used-

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
All analysis logic and project implementation were performed by myself
