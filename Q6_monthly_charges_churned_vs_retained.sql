-- Q6. Average monthly charges: churned vs retained
USE churn_db;

SELECT Churn,
       COUNT(*) AS customers,
       ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charge
FROM customers
GROUP BY Churn;