-- Q3. Churn by tenure group
USE churn_db;

SELECT CASE
         WHEN tenure <= 12 THEN '0-12 months'
         WHEN tenure <= 24 THEN '13-24 months'
         WHEN tenure <= 48 THEN '25-48 months'
         ELSE '48+ months'
       END AS tenure_group,
       COUNT(*) AS customers,
       ROUND(100 * SUM(Churn = 'Yes') / COUNT(*), 2) AS churn_rate_pct
FROM customers
GROUP BY tenure_group
ORDER BY MIN(tenure);