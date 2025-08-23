# 📒 Data Catalog – Gold Layer

## 📌 Overview
The **Gold Layer** provides business-friendly views of vehicle data for reporting, analytics, and dashboards. It includes both **fact** and **dimension views**, following a simplified star schema approach.

---

## 1. `gold.fa_vehicle_market` (Fact Table)

**Purpose:**  
Captures vehicle-level market data such as price, units sold, warranty, and manufacturer details. It serves as the core fact table for sales and distribution analysis.

| Column Name           | Data Type     | Description                                                                 |
|------------------------|---------------|-----------------------------------------------------------------------------|
| vehicle_id             | INT           | Unique ID representing the vehicle.                                        |
| manufacturer           | NVARCHAR(50)  | Name of the manufacturer (e.g., Tesla, Ford).                              |
| model                  | NVARCHAR(50)  | Vehicle model name.                                                        |
| country_of_manufacture | NVARCHAR(50)  | Country where the vehicle is manufactured.                                 |
| color                  | NVARCHAR(50)  | Color of the vehicle.                                                      |
| warranty_years         | INT           | Warranty period in years.                                                  |
| year                   | INT           | Model release year.                                                        |
| units_sold_2024        | INT           | Total units sold in 2024.                                                  |
| price_usd              | DECIMAL(9,2)  | Price of the vehicle in USD.                                               |

---

## 2. `gold.dim_summary` (Dimension Table)

**Purpose:**  
Provides technical specifications for each vehicle related to battery and energy efficiency. Supports EV performance and charging analysis.

| Column Name           | Data Type     | Description                                                                 |
|------------------------|---------------|-----------------------------------------------------------------------------|
| vehicle_id             | INT           | Unique ID representing the vehicle.                                        |
| battery_type           | NVARCHAR(50)  | Type of battery used (e.g., Lithium-ion).                                  |
| charging_type          | NVARCHAR(50)  | Charging technology (e.g., Fast Charge).                                   |
| charge_time_hr         | DECIMAL(5,2)  | Time required to fully charge the vehicle, in hours.                       |
| range_km               | INT           | Maximum range of the vehicle on a full charge (in kilometers).             |
| battery_capacity_kwh   | DECIMAL(5,2)  | Total battery capacity in kilowatt-hours.                                  |

---

## 3. `gold.dim_safety` (Dimension Table)

**Purpose:**  
Describes safety and autonomous features for each vehicle model. Supports safety analysis and regulatory compliance reporting.

| Column Name       | Data Type     | Description                                                                 |
|--------------------|---------------|-----------------------------------------------------------------------------|
| vehicle_id         | INT           | Unique ID representing the vehicle.                                        |
| autonomous_level   | INT           | Level of autonomous driving capabilities (0–5).                            |
| safety_rating      | INT           | Safety rating based on standard testing (e.g., Euro NCAP, NHTSA).          |

---

## 🔁 Relationships (Conceptual)

