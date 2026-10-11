USE churn_db;
SET SQL_SAFE_UPDATES = 0;

UPDATE customers SET TotalCharges = NULL WHERE TRIM(TotalCharges) = '';
ALTER TABLE customers MODIFY TotalCharges DECIMAL(10,2);