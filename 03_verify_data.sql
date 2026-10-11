SELECT Churn, COUNT(*) AS customers
FROM customers
GROUP BY Churn;