# sql-analysis
SQL practice projects for data analytics.

# SQL Analysis Portfolio

This repository contains my SQL practice and analysis work.  
I am using the **Chinook Database** (sample music store) and later other datasets to practice SQL for data analytics.  

---

sql-analysis/
│
├── README.md # Project overview
├── chinook/ # Chinook database queries
│ ├── 01_basics.sql # SELECT, WHERE, ORDER BY
│ ├── 02_aggregations.sql # GROUP BY, HAVING
│ ├── 03_joins.sql # JOINs
│ ├── 04_window.sql # Window functions
│ ├── 05_case_studies.sql # Business case studies
│
└── notes/ # Optional notes
├── queries.md
└── learnings.md 

---

## 🛠️ Setup Instructions
1. Download the **Chinook Database (MySQL version)** from [Chinook GitHub](https://github.com/lerocha/chinook-database).  
2. Import it into MySQL:  
   ```bash
   mysql -u root -p -e "CREATE DATABASE chinook;"
   mysql -u root -p chinook < ~/Chinook_MySql.sql
3. Verify:
   USE chinook;
   SHOW TABLES;



