-- Q9. Rank payment methods by churn within each contract (window function)
USE churn_db;

WITH seg AS (
    SELECT Contract, PaymentMethod,
           COUNT(*) AS customers,
           ROUND(100 * SUM(Churn = 'Yes') / COUNT(*), 2) AS churn_rate_pct
    FROM customers
    GROUP BY Contract, PaymentMethod
)
SELECT Contract, PaymentMethod, customers, churn_rate_pct,
       RANK() OVER (PARTITION BY Contract ORDER BY churn_rate_pct DESC) AS risk_rank
FROM seg
ORDER BY Contract, risk_rank;