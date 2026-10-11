-- Q1. Overall churn rate
USE churn_db;

SELECT COUNT(*) AS total_customers,
       SUM(Churn = 'Yes') AS churned,
       ROUND(100 * SUM(Churn = 'Yes') / COUNT(*), 2) AS churn_rate_pct
FROM customers;