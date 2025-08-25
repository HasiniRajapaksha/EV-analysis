# 🚗 Electric Vehicle Data Warehouse & EDA Exploration  

This project implements a **Silver → Gold Data Warehouse Architecture** in SQL Server.  
It transforms raw vehicle data into **analytical views** for exploring sales, EV specifications, and safety insights.  

---

## 🏗️ Data Architecture  
<img width="1649" height="823" alt="Image" src="https://github.com/user-attachments/assets/7c58a04b-32d0-49cd-b8b4-c8732db3866b" />

### 🔹 Silver Layer  
Stores structured source tables with metadata (`dwh_create_date`).  
- `vm_sales_warranty`  
- `vs_battery`  
- `vs_performance`  
- `vs_vehicle_info`  

### 🔹 Gold Layer  
Business-ready views for analytics.  
- `fa_vehicle_market`  
- `dim_summary`  
- `dim_safety`  

📌 *Visual Representation:*  


## 🏗️ Data Model 
<img width="1920" height="997" alt="Image" src="https://github.com/user-attachments/assets/0075e136-cf23-4764-9518-329e859169a2" />
*ERD showing how Silver tables join into Gold views.*  


# 🔎 EDA Exploration Framework  

We explore insights through **business-focused EDA questions**.  
Each section includes **questions** + **space for a visualization** you can generate.  

---

## 1️⃣ Magnitude Exploration  
📌 *How big is something at a point in time?*  

 <img width="1920" height="1017" alt="Image" src="https://github.com/user-attachments/assets/2b9ba18f-62a9-4e9e-b4f3-49e00f3622b4" />


 <img width="1920" height="1011" alt="Image" src="https://github.com/user-attachments/assets/d8ba927b-7c69-42da-acad-d5beb79f5c07" />
---

## 2️⃣ Change Over Time  
📌 *How do metrics evolve across years?*  

- How have sales changed by manufacturer year over year?  
- Is the average vehicle price increasing over time?  
- Are EV ranges (km) getting longer in newer models?  

👉 Visualization:  

![Change Over Time Placeholder](images/change_over_time.png)  
*Line chart of sales trend across years.*  

---

## 3️⃣ Cumulative Exploration  
📌 *Running totals and growth.*  
<img width="1920" height="1007" alt="Image" src="https://github.com/user-attachments/assets/a7b1664d-7213-44cb-ad9c-2d7950dd7b6a" />

---

## 4️⃣ Part-to-Whole Exploration  
📌 *Distribution and shares.*  

- What is the market share of each manufacturer in 2024?  
- What percentage of vehicles have autonomous level > 3?  
- What portion of vehicles fall into different safety ratings?  

👉 Visualization:  

![Part-to-Whole Chart Placeholder](images/part_to_whole.png)  
*Pie chart of manufacturer market share.*  

---

## 5️⃣ Performance Analysis  
📌 *Efficiency & effectiveness.*  

- Which EVs have the best price-to-range ratio?  
- Which vehicles offer the best warranty-to-price ratio?  
- Do higher safety ratings lead to higher sales?  

👉 Visualization:  

![Performance Chart Placeholder](images/performance.png)  
*Scatterplot: Price vs Range, bubble size = Sales.*  

---

## 6️⃣ Data Segmentation  
📌 *Breakdowns by groups.*  

- Compare sales volumes by manufacturer within each country.  
- Segment by safety rating groups (1–3 vs 4–5).  
- Compare average price across different charging types.  

👉 Visualization:  

![Segmentation Chart Placeholder](images/segmentation.png)  
*Boxplot of prices segmented by safety rating.*  

---

## 🚀 Future Enhancements  

- Add **Bronze Layer ingestion** (CSV/JSON/Parquet).  
- Extend to a **Star Schema Fact/Dim model**.  
- Connect to **Power BI / Tableau dashboards**.  
- Automate ETL with **Airflow / ADF / SSIS**.  

---

## 👩‍💻 Author  

Built with ❤️ by [Your Name]  
📧 Contact: [your.email@example.com]  
🌐 Portfolio: [your-portfolio-link]  

---
