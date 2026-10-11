# 📉 Telecom Customer Churn Analysis

**End-to-end analytics project: SQL → Python → Machine Learning → Tableau**

![SQL](https://img.shields.io/badge/SQL-MySQL-blue)
![Python](https://img.shields.io/badge/Python-Pandas%20%7C%20Scikit--learn-yellow)
![Tableau](https://img.shields.io/badge/Dashboard-Tableau%20Public-orange)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen)

🔗 **[View the live Tableau dashboard](YOUR_TABLEAU_PUBLIC_LINK)**

![Dashboard](dashboard/churn_dashboard.png)

---

## 📌 Business Problem

A telecom company is losing customers every month. Keeping an existing customer costs far less than winning a new one, so the business needs answers to three questions:

1. **Why** are customers leaving?
2. **Which** customers are most at risk?
3. **What** can the company do to reduce churn?

This project answers them using SQL, Python, a predictive model and an interactive dashboard.

---

## 🎯 Key Results at a Glance

| Metric | Result |
|---|---|
| Customers analysed | **7,043** |
| Customers who churned | **1,869** |
| Overall churn rate | **26.54%** |
| Monthly revenue lost to churn | **$139,130.85** (30.50% of $456,116.60) |
| Highest-risk segment | Month-to-month + Fiber optic + first year → **70.20%** churn |
| Best model recall (balanced Random Forest) | **77.5%** of churners caught |
| Best model accuracy (Random Forest) | **80.1%** |

> Churned customers are 26.5% of the customer base but account for **30.5% of monthly revenue**, so each lost customer costs more than average.

---

## 🗂️ Dataset

- **Source:** [Telco Customer Churn (IBM sample dataset, Kaggle)](https://www.kaggle.com/datasets/blastchar/telco-customer-churn)
- **Size:** 7,043 customers, 21 columns
- **Target:** `Churn` (Yes / No)
- **Main fields:** tenure, contract type, internet service, payment method, add-on services, monthly and total charges

---

## 🛠️ Tools Used

| Stage | Tools |
|---|---|
| Database and analysis | MySQL, MySQL Workbench (CTEs, window functions, joins, aggregations) |
| Cleaning and EDA | Python, Pandas, NumPy, Matplotlib, Seaborn |
| Modelling | Scikit-learn (Logistic Regression, Random Forest) |
| Dashboard | Tableau Public |

---

## 🔄 Project Workflow

```
Raw CSV → MySQL analysis → Python cleaning + feature engineering → EDA → ML model → Tableau dashboard → Recommendations
```

### 1️⃣ SQL analysis (MySQL)
Nine queries answer the core business questions. Highlights:

| Segment | Customers | Churn rate |
|---|---|---|
| Month-to-month contract | 3,875 | **42.71%** |
| One year contract | 1,473 | 11.27% |
| Two year contract | 1,695 | 2.83% |
| Tenure 0-12 months | 2,186 | **47.44%** |
| Tenure 13-24 months | 1,024 | 28.71% |
| Tenure 25-48 months | 1,594 | 20.39% |
| Tenure 48+ months | 2,239 | 9.51% |

**Top 5 highest-risk segments** (segments with at least 50 customers):

| Contract | Internet | Tenure | Customers | Churn rate |
|---|---|---|---|---|
| Month-to-month | Fiber optic | 0-12 months | 916 | **70.20%** |
| Month-to-month | Fiber optic | 13+ months | 1,212 | 42.82% |
| Month-to-month | DSL | 0-12 months | 690 | 42.46% |
| Month-to-month | No internet | 0-12 months | 388 | 22.68% |
| One year | Fiber optic | 13+ months | 532 | 19.17% |

📁 All queries are in [`Sql/`](Sql/) with a separate file for each question.

### 2️⃣ Data cleaning and feature engineering (Python)
- Found that `TotalCharges` was stored as text, with **11 hidden blank values**. All 11 were brand-new customers with `tenure = 0`, so they were filled with 0.
- Checked for duplicates: **0 duplicate rows and 0 duplicate customer IDs**.
- Merged "No internet service" and "No phone service" into "No" for add-on columns.
- Created new features: `tenure_group`, `charge_category`, `num_services`, `avg_monthly_spend`, `auto_pay`.
- Cross-checked Python results against SQL results. Churn rates by contract and tenure matched exactly.

📓 Notebook: [`notebooks/`](notebooks/)

### 3️⃣ Exploratory data analysis
Churn rate by key factors:

| Factor | Highest risk | Lowest risk |
|---|---|---|
| Contract | Month-to-month **42.7%** | Two year 2.8% |
| Tenure | 0-12 months **47.4%** | 48+ months 9.5% |
| Internet service | Fiber optic **41.9%** | No internet 7.4% (DSL 19.0%) |
| Payment method | Electronic check **45.3%** | Credit card (auto) 15.2% |

**Add-on services:** among customers with internet, churn falls steadily as add-ons increase.

| Add-on services | 0 | 1 | 2 | 3 | 4 | 5 | 6 |
|---|---|---|---|---|---|---|---|
| Churn rate | 52.2% | 45.8% | 35.8% | 27.4% | 22.3% | 12.4% | 5.3% |

**Correlation with churn:** tenure **-0.35**, TotalCharges -0.20, MonthlyCharges +0.19, num_services -0.09.

> 💡 Note: my first add-on chart included customers with no internet, which made the "0 services" bar look low (about 21%). Filtering to internet customers gave the true pattern above.

![Churn by contract](screenshots/eda_02_churn_by_contract.png)
![Churn by tenure](screenshots/eda_03_churn_by_tenure.png)

### 4️⃣ Predictive modelling
Data split 80/20 (stratified), giving 1,409 test customers.

| Model | Accuracy | Precision | Recall | F1 |
|---|---|---|---|---|
| Logistic Regression | 79.8% | 65.4% | 51.1% | 0.574 |
| Random Forest | **80.1%** | **67.2%** | 49.2% | 0.568 |
| Random Forest (class-balanced) | 76.4% | 53.9% | **77.5%** | **0.636** |

**Why the balanced model?** Only about 26% of customers churn, so the standard models missed half of the churners. Class weighting raised recall from 49% to 77.5%, trading some accuracy and precision. For a retention campaign, a missed churner costs more than a wasted offer, so this model is the better fit.

**Confusion matrix (balanced Random Forest):**

| | Predicted stay | Predicted churn |
|---|---|---|
| **Actually stayed** | 787 | 248 |
| **Actually churned** | 84 | **290** |

**Top 10 features driving churn:**

| Rank | Feature | Importance |
|---|---|---|
| 1 | tenure | 0.161 |
| 2 | Contract: Two year | 0.104 |
| 3 | TotalCharges | 0.100 |
| 4 | Internet: Fiber optic | 0.092 |
| 5 | MonthlyCharges | 0.083 |
| 6 | avg_monthly_spend | 0.077 |
| 7 | Payment: Electronic check | 0.050 |
| 8 | Tenure group: 48+ months | 0.048 |
| 9 | Internet: No | 0.040 |
| 10 | Contract: One year | 0.038 |

The model's top drivers agree with the SQL and EDA findings.

![Feature importance](screenshots/model_02_feature_importance.png)

### 5️⃣ Tableau dashboard
An interactive dashboard with KPI cards (churn rate, customers, revenue at risk), churn by contract, internet service, tenure and payment method, and a contract-by-tenure risk heatmap.

**Heatmap highlights (churn rate):**

| Tenure | Month-to-month | One year | Two year |
|---|---|---|---|
| 0-12 months | **51.4%** | 10.5% | 0.0% |
| 13-24 months | 37.7% | 8.1% | 0.0% |
| 25-48 months | 32.9% | 10.6% | 2.2% |
| 48+ months | 26.0% | 12.9% | 3.3% |

🔗 **[Open the dashboard](YOUR_TABLEAU_PUBLIC_LINK)**

---

## 🔍 Key Insights

1. **Contract type is the strongest driver.** Month-to-month customers churn at 42.71%, about 15 times the rate of two-year customers (2.83%).
2. **The first year is the danger zone.** Churn is 47.44% in the first 12 months and falls to 9.51% after 48 months.
3. **Fiber optic customers churn the most.** The rate is 41.9%, more than double DSL (19.0%). This points to a possible price or service-quality issue.
4. **Electronic check users churn the most (45.3%).** Customers on automatic payments churn at 15 to 17%.
5. **More add-on services go with lower churn.** Among internet customers, churn drops from 52.2% with no add-ons to 5.3% with all six.
6. **Churn costs more than its share.** Churned customers are 26.5% of customers but 30.5% of monthly revenue.
7. **The worst segment is month-to-month, fiber optic, in their first year.** 643 of 916 customers (70.20%) left.

---

## ✅ Recommendations

| # | Action | Evidence |
|---|---|---|
| 1 | Offer discounts or bonuses to move month-to-month customers to 1-year contracts | Month-to-month churn is 42.71% vs 11.27% for one year |
| 2 | Launch a first-year onboarding and check-in programme | 47.44% churn in the first 12 months |
| 3 | Review fiber optic pricing and service quality | 41.9% churn vs 19.0% for DSL; 70.20% in the worst segment |
| 4 | Encourage auto-pay with a small bill credit | Electronic check churn is 45.3% vs 15 to 17% for auto-pay |
| 5 | Bundle or trial add-ons such as security and tech support | Churn falls from 52.2% to 5.3% as add-ons rise |
| 6 | Use the balanced model to flag at-risk customers for retention calls | Catches 77.5% of churners |

---

## ⚠️ Limitations

- Results show **association, not causation**. For example, customers on auto-pay may simply be more committed already.
- The balanced model has **53.9% precision**, so about half of the customers it flags would not have left. It suits low-cost retention offers, not expensive ones.
- Some segments are small (two-year contracts in their first two years show 0.0% churn), so treat them as "very low" rather than exact.
- The dataset is a sample from one company at one point in time.

---

## 📁 Repository Structure

```
Telecom-Customer-Churn-Analysis/
│── Data/
│     ├── Telco_churn.csv              (original, untouched)
│     └── telco_churn_cleaned.csv      (after cleaning + new features)
│── Sql/
│     ├── 01_create_table.sql
│     ├── 02_clean_data.sql
│     ├── 03_verify_data.sql
│     └── analysis/                    (Q1 to Q9 queries)
│── notebooks/
│     ├── 01_data_cleaning_eda.ipynb
│     ├── 02_eda.ipynb
│     └── 03_model.ipynb
│── screenshots/                       (SQL results, EDA charts, model charts)
│── dashboard/
│     └── churn_dashboard.png
│── README.md
```

---

## ▶️ How to Reproduce

1. Download the dataset from Kaggle and place it in `Data/`.
2. Install the libraries: `pip install pandas numpy matplotlib seaborn scikit-learn`
3. Run the SQL files in `Sql/` in order (`01` to `03`), then the queries in `Sql/analysis/`.
4. Run the notebooks in order (`01` → `02` → `03`).
5. Open the cleaned CSV in Tableau Public to rebuild the dashboard.

---

## 👤 Author

**Niyamath**
Aspiring Data Analyst | SQL · Python · Power BI · Tableau

🔗 [GitHub](https://github.com/Niyamath28) · [LinkedIn](YOUR_LINKEDIN_LINK)

⭐ If you found this project useful, consider giving it a star.
