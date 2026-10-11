-- Q7. Revenue lost to churn
USE churn_db;

SELECT ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges END), 2) AS monthly_revenue_lost,
       ROUND(SUM(MonthlyCharges), 2) AS total_monthly_revenue,
       ROUND(100 * SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges END) / SUM(MonthlyCharges), 2) AS pct_revenue_lost
FROM customers;