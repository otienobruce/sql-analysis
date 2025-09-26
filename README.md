# CaseAnalysis – SQL Analysis on Chinook Database

This project explores the [Chinook database](https://github.com/lerocha/chinook-database), a sample database representing a digital media store.  
It contains tables for artists, albums, customers, invoices, playlists, and more.  

The project is divided into **Foundations** (basic exploration & joins) and **CaseAnalysis** (detailed business analysis).  
All queries are written in SQL and organized into `.sql` files for clarity.

---

## Project Structure

CaseAnalysis/
│
├── Catalog_analysis.sql # Product- and catalog-focused queries
├── Customer_analysis.sql # Customer-focused queries
├── Revenue_analysis.sql # Revenue and sales performance queries
│
Foundations/
├── Basics.sql # Basic queries (tables, simple selects)
├── Joins.sql # Practicing SQL joins across tables


---

## Foundations

The **Foundations** folder introduces the database:

- `Basics.sql`  
  - Explore available databases and tables.  
  - Simple `SELECT` queries to understand the structure.  
  - Overview of key tables: `Album`, `Artist`, `Customer`, `Invoice`, `Track`, etc.

- `Joins.sql`  
  - Demonstrates relationships between tables using `INNER JOIN`.  
  - Examples include:
    - Linking `Artist` → `Album` (albums per artist).  
    - Linking `Customer` → `Invoice` (customer purchases).  
    - Linking `Track` → `Album`, `Genre`, `MediaType`.  
  - Includes first revenue aggregation by genre.

This stage builds the foundation for deeper analysis.

---

## Catalog Analysis (`Catalog_analysis.sql`)

Focus: products, albums, artists, genres, and media types.

### Track-Level
- **Top-selling tracks by revenue** (window function & grouped aggregate versions).  
- **Most purchased tracks** (by quantity).  
- **Average unit price per track purchase**.

### Album-Level
- **Revenue per album.**  
- **Top-selling albums** (based on revenue).

### Artist-Level
- **Revenue per artist.**  
- **Top-selling artists** (with ranking).  
- **Artists with the most albums in the catalog.**

### Genre-Level
- **Revenue per genre** (with ranking).  
- **Most popular genre overall.**  
- **Most popular genre by country** (using `ROW_NUMBER`).

### Media Type-Level
- **Revenue by media type.**  
- **Most popular media type by sales.**

---

## Customer Analysis (`Customer_analysis.sql`)

Focus: customer behavior and demographics.

- **Top customers by total spending.**  
- **Top customers per country** (using `ROW_NUMBER`).  
- **Customers with the highest number of invoices.**  
- **Customer count per country.**  
- **Most active customers** (by number of tracks purchased).  
- **Top spenders per city** (useful for geographic analysis).  

This file highlights which customers and regions drive sales.

---

## Revenue Analysis (`Revenue_analysis.sql`)

Focus: sales, invoices, and revenue performance.

- **Total revenue generated** (overall store performance).  
- **Revenue by country** (geographic breakdown).  
- **Revenue by billing city.**  
- **Monthly revenue trends** (time-series analysis).  
- **Invoice-level insights:**
  - Largest invoices by total.  
  - Average invoice value.  
  - Number of invoices per country.

This file answers *“where does the money come from?”* and *“what are the top revenue drivers?”*.

---

## Key Insights from the Analysis

- Certain **tracks and artists dominate sales**, confirming the Pareto principle (few products generate most revenue).  
- **Customer spending is unevenly distributed** across countries and cities.  
- **Genres and media types** show distinct preferences across regions.  
- Revenue analysis reveals **seasonal/monthly trends** and identifies high-value customers & regions.

---

## How to Use

1. Clone or download this repository.  
2. Import the Chinook database into your SQL environment (MySQL/PostgreSQL/SQLite).  
3. Run queries from the `.sql` files in order:
   - Start with `Foundations/` to understand the schema.  
   - Then move to `CaseAnalysis/` for deeper analysis.  

---

##  Notes

- Queries use **aggregations, joins, and window functions** (`ROW_NUMBER`, `RANK`, etc.).  
- The project emphasizes **step-by-step learning**: from exploring tables → mastering joins → conducting advanced analysis.  
- Designed for both **practice** and **real-world case analysis**.

---

## Next Steps

- Add **visualizations** (Power BI, Tableau, or Matplotlib/Seaborn in Python).  
- Automate reporting with **stored procedures** or scripts.  
- Explore **playlist-level insights** (e.g., most popular playlists, top artists per playlist).

---

## Conclusion

This project provides a full case study of the Chinook database, covering customers, products, and revenue.  
It demonstrates how SQL can extract insights from raw data, starting from basic queries up to advanced analytics.  

