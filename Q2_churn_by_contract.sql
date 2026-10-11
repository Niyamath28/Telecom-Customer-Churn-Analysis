-- Q2. Churn by contract type
USE churn_db;

SELECT Contract,
       COUNT(*) AS customers,
       SUM(Churn = 'Yes') AS churned,
       ROUND(100 * SUM(Churn = 'Yes') / COUNT(*), 2) AS churn_rate_pct
FROM customers
GROUP BY Contract
ORDER BY churn_rate_pct DESC;