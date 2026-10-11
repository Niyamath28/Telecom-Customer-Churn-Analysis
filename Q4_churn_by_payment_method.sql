-- Q4. Churn by payment method
USE churn_db;

SELECT PaymentMethod,
       COUNT(*) AS customers,
       ROUND(100 * SUM(Churn = 'Yes') / COUNT(*), 2) AS churn_rate_pct
FROM customers
GROUP BY PaymentMethod
ORDER BY churn_rate_pct DESC;