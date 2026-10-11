-- Q8. Highest-risk customer segments (CTE)
USE churn_db;

WITH segments AS (
    SELECT Contract,
           InternetService,
           CASE WHEN tenure <= 12 THEN '0-12 months' ELSE '13+ months' END AS tenure_group,
           COUNT(*) AS customers,
           SUM(Churn = 'Yes') AS churned,
           ROUND(100 * SUM(Churn = 'Yes') / COUNT(*), 2) AS churn_rate_pct
    FROM customers
    GROUP BY Contract, InternetService, tenure_group
    HAVING COUNT(*) >= 50
)
SELECT *
FROM segments
ORDER BY churn_rate_pct DESC
LIMIT 5;