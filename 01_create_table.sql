CREATE DATABASE churn_db;
USE churn_db;

CREATE TABLE customers (
    customerID        VARCHAR(20),
    gender            VARCHAR(10),
    SeniorCitizen     INT,
    Partner           VARCHAR(5),
    Dependents        VARCHAR(5),
    tenure            INT,
    PhoneService      VARCHAR(5),
    MultipleLines     VARCHAR(30),
    InternetService   VARCHAR(20),
    OnlineSecurity    VARCHAR(30),
    OnlineBackup      VARCHAR(30),
    DeviceProtection  VARCHAR(30),
    TechSupport       VARCHAR(30),
    StreamingTV       VARCHAR(30),
    StreamingMovies   VARCHAR(30),
    Contract          VARCHAR(20),
    PaperlessBilling  VARCHAR(5),
    PaymentMethod     VARCHAR(40),
    MonthlyCharges    DECIMAL(8,2),
    TotalCharges      VARCHAR(20),
    Churn             VARCHAR(5)
);