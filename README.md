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

Explore insights through **business-focused EDA questions**.  

---

##  Magnitude Exploration  
📌 *How big is something at a point in time?*  

 <img width="1920" height="1017" alt="Image" src="https://github.com/user-attachments/assets/2b9ba18f-62a9-4e9e-b4f3-49e00f3622b4" />


 <img width="1920" height="1011" alt="Image" src="https://github.com/user-attachments/assets/d8ba927b-7c69-42da-acad-d5beb79f5c07" />
---


##  Cumulative Exploration  
📌 *Running totals and growth.*  
<img width="1920" height="1007" alt="Image" src="https://github.com/user-attachments/assets/a7b1664d-7213-44cb-ad9c-2d7950dd7b6a" />

---
