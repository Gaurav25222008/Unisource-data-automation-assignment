# Automated Exchange Rate Pipeline (SQL + Python)

## 📌 Overview

This project is an end-to-end data automation pipeline that fetches daily exchange rates using a public API, computes percentage changes, and generates structured reports. It also includes SQL-based analysis on the Northwind dataset.

The solution demonstrates data extraction, transformation, reporting, and scheduling—aligned with real-world data engineering and automation workflows.

---

## ⚙️ Features

* Fetches exchange rates (USD base) from a public API
* Compares today’s and yesterday’s rates
* Calculates percentage change
* Flags significant changes (>0.5%)
* Generates CSV report
* Logs execution details
* SQL analysis using Northwind database
* Automated daily execution using Windows Task Scheduler

---

## 🧰 Tech Stack

* Python (requests, pandas)
* SQL Server (T-SQL)
* Windows Task Scheduler

---

## 📂 Project Structure

```
Exchange_Rate_Assignment/
│
├── SQL/
│   └── northwind_analysis.sql
│
├── Python/
│   └── exchange_rates.py
│
├── Output/
│   ├── exchange_rates_YYYY-MM-DD.csv
│   └── exchange_rates.log
│
├── Screenshots/
│   ├── task_scheduler_trigger.png
│   └── task_scheduler_action.png
│
└── README.md
```

---

## 🚀 How to Run

### 1. Install Dependencies

```
pip install requests pandas
```

### 2. Run Script

```
python exchange_rates.py
```

### 3. Output

* CSV file with exchange rate comparison
* Log file with execution details

---

## 📊 SQL Tasks

The SQL script includes:

* Revenue by product category
* Top 10 customers by lifetime value
* Identification of delayed orders
* Stored procedure for reusable customer analysis

---

## ⏱️ Automation (Bonus)

The Python script is scheduled using Windows Task Scheduler to run daily at a fixed time. This ensures automated data collection and reporting without manual intervention.

---

## 📎 Sample Output

* CSV: Contains currency, today’s rate, yesterday’s rate, % change, and significance flag
* Log: Contains execution timestamps and status

---

## 🧠 Key Learnings

* API integration and data extraction
* Data transformation and analysis
* Automation using scheduling tools
* Writing production-ready SQL queries and procedures

---

## 📬 Note

This project was completed as part of a technical assignment to demonstrate practical data engineering and automation skills.

---

## 👤 Author

Gaurav
