-- Q5. Churn by internet service
USE churn_db;

SELECT InternetService,
       COUNT(*) AS customers,
       ROUND(100 * SUM(Churn = 'Yes') / COUNT(*), 2) AS churn_rate_pct
FROM customers
GROUP BY InternetService
ORDER BY churn_rate_pct DESC;