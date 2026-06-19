# From-Procurement-to-Performance-Analyzing-₦21.8B-in-Construction-Operations-with-SQL-and-Power-BI
Conducted end-to-end operational analytics on ₦21.8B of construction project spending, leveraging SQL and Power BI to identify cost-saving opportunities, supplier risks, workforce inefficiencies, and project health concerns.

## Table of Contents
- Project Overview
- Business Problem
- Business Objectives
- Dataset Description
- Tools & Methodology
- Data Model
- SQL Analysis & Insights
- Executive Dashboard
- Workforce Analytics
- Supplier & Procurement Performance
- Equipment Operations & Utilization
- Project Health Assessment
- Key Findings
- Strategic Recommendations
- Dashboard Demonstration
- Data Limitations
- Contact

## Project Overview

This project analyzes operational data from 50 construction projects with over ₦21.8 billion in total spending. Using SQL for data analysis and Power BI for visualization, I evaluated project performance, procurement efficiency, supplier reliability, workforce utilization, equipment operations, and budget management.

The analysis focused on identifying cost drivers, detecting unusual spending patterns, assessing supplier and project risks, evaluating workforce efficiency, and uncovering opportunities for operational improvement and cost optimization. 

## Business Problem

The organization needed visibility into project performance, procurement spending, supplier risk, workforce utilization, equipment efficiency, and budget control across 50 construction projects. The objective was to identify cost drivers, operational inefficiencies, supplier risks, and project health issues to support better decision-making.#

## Dataset Description

The dataset contains operational data from 50 construction projects across multiple locations in Nigeria. It captures project activities, procurement transactions, workforce records, supplier performance, equipment operations, and budget information.
### Dataset 
* <a href=https://github.com/Debbyjones99/From-Procurement-to-Performance-Analyzing-21.8B-in-Construction-Operations-with-SQL-and-Power-BI/tree/main/Dataset > Procure to performance dashboard</a>


### Dataset Coverage

* 50 Construction Projects
* 500 Workers
* 100 Suppliers
* Multiple Equipment Assets
* Material Procurement Transactions
* Budget and Operational Cost Records

### Key Data Categories

* Project Information (Project ID, Project Type, Location, Status)
* Workforce Data (Workers, Trade, Skill Level, Labor Cost, Utilization)
* Supplier Data (Supplier ID, Ratings, Delivery Delays, Lead Time)
* Procurement Data (Material Categories, Quantity, Material Cost)
* Equipment Data (Equipment Cost, Fuel Cost, Usage Days)
* Financial Data (Budget Allocation, Operational Cost, Waste Cost)

The dataset supports analysis of project performance, cost drivers, supplier reliability, workforce efficiency, equipment utilization, and overall operational risk across construction projects.

## Tools & Methodology

### Tools Used

* **SQL (PostgreSQL)** – Data cleaning, aggregation, joins, and analytical queries
* **Power BI** – Data visualization, dashboard development, and KPI tracking
* **Excel** – Initial data inspection and validation

### Methodology

The analysis followed a structured end-to-end data analytics workflow:

1. **Data Cleaning & Preparation**

   * Handled missing values and inconsistencies in operational records
   * Standardized financial and categorical fields across datasets

2. **Data Modeling**

   * Built a relational data model connecting projects, workforce, suppliers, equipment, and financial tables
   * Established relationships using Project ID as the primary key

3. **SQL Analysis**

   * Performed aggregation to compute total costs, averages, and variances
   * Identified outliers using threshold-based comparisons (e.g., 150% of averages)
   * Conducted cohort-style analysis for workforce, supplier, and project performance

4. **Business Analysis**

   * Evaluated cost drivers across materials, labor, fuel, equipment, and transportation
   * Assessed supplier performance and risk levels
   * Analyzed workforce utilization and efficiency
   * Measured budget variance and project health

5. **Visualization (Power BI)**

   * Built interactive dashboards for executive and operational insights
   * Designed KPI cards, trend analysis visuals, and performance breakdowns
   * Enabled drill-down analysis across projects, suppliers, and workforce

The approach ensured data was transformed into actionable insights for operational decision-making.
 
## Data Model

The data model follows a **star schema structure** designed to support efficient analysis of construction operations.

### Fact Table

* **Operations Fact Table**

  * Contains transactional records for costs, usage, and performance metrics
  * Includes: fuel cost, equipment cost, transportation cost, labor cost, and budget data

### Dimension Tables

* **Project Dimension**

  * Project ID, project type, location, and status

* **Workforce Dimension**

  * Worker ID, trade, skill level, wage rate, and utilization metrics

* **Supplier Dimension**

  * Supplier ID, rating, lead time, delivery delay, and risk classification

* **Equipment Dimension**

  * Equipment ID, usage days, fuel consumption, and cost metrics

* **Time Dimension (if applicable)**

  * Year, month, and period-based breakdown for trend analysis

### Relationships

* All dimension tables connect to the **Operations Fact Table** using `Project ID` and relevant foreign keys.
* This structure enables:

  * Cross-project performance analysis
  * Time-based trend evaluation
  * Supplier and workforce benchmarking
  * Cost aggregation and variance analysis

The model supports scalable analysis across operational, financial, and performance metrics.

## SQL Analysis & Insights 

### Cost Anomaly Detection

Operational transactions were analyzed against project-level cost averages. Transactions exceeding 150% of their respective project averages for fuel, equipment, or transportation costs were flagged as anomalies.

The analysis identified multiple high-cost transactions, highlighting:

* Potential overspending
* Operational inefficiencies
* Exceptional cost activities requiring review

### Location Performance Analysis

Operational efficiency was assessed using delivery delays, fuel consumption, equipment costs, and transportation costs.

Results showed:

* **Lagos** – Critical performance zone
* **Abuja** – At Risk
* **Kano, Ogun, Port Harcourt** – Efficient operations

Although Ogun recorded the highest operational expenditure (₦7.53B), it demonstrated relatively stronger cost efficiency compared to Lagos.

### Project Health Assessment

Project performance scoring revealed widespread operational challenges across the portfolio:

* 41 Critical Projects
* 9 At-Risk Projects

Key drivers included:

* Budget overruns
* Delivery delays
* Low workforce utilization
* Unfavorable cost variances

Budget analysis further showed:

* 41 projects exceeded budgets
* 7 were in critical budget condition
* 2 were at risk of future overruns

## Executive Summary
<p>
This project analyzes operational, procurement, workforce, supplier, equipment, and budget performance across 50 construction projects using SQL and Power BI, covering over ₦21.8 billion in total operational spending.
<p></p>
The analysis revealed significant budget overruns, procurement-driven cost concentration, supplier performance risks, workforce utilization inefficiencies, and project-level performance disparities. While fuel efficiency and supplier diversification remained relatively stable, procurement cost control and project governance emerged as the most critical areas for improvement.

<img width="622" height="372" alt="Executive_dashboard" src="https://github.com/Debbyjones99/From-Procurement-to-Performance-Analyzing-21.8B-in-Construction-Operations-with-SQL-and-Power-BI/blob/main/Dashboard_Screenshot/executive_dashboard_Onyewem.png" />
<P></P>
Key Insights

### Operational Performance

- Total spend: ₦21.8B vs ₦14.4B budget (significant overspend)
- 2025 recorded the highest operational cost (₦7.38B)
- Spending patterns were highly project-specific, not uniform across time
- Project 10039 recorded extreme budget variance (>703%)

### Cost Structure

- Material procurement dominated total spend: ₦18.85B (~85%+ of total cost)
- Equipment: ₦1.41B | Labour: ₦771.9M | Fuel: ₦380M | Transport: ₦232M
- Procurement efficiency identified as the highest-impact cost-saving lever

## Workforce Performance
<p></p>
<img width="622" height="372" alt="Executive_dashboard" src="https://github.com/Debbyjones99/From-Procurement-to-Performance-Analyzing-21.8B-in-Construction-Operations-with-SQL-and-Power-BI/blob/main/Dashboard_Screenshot/workforce_optimization_dashboard_Onyewem.png" />

- 500 workers (50% contractors)
- Contractors were primary cost drivers in 26 projects
- Premium skilled workers concentrated in Masons, Electricians, Plumbers, Carpenters
- Evidence of underutilization in workforce allocation (e.g., Worker 40217)
  

## Supplier Performance
<p></p>
<img width="622" height="372" alt="Executive_dashboard" src="https://github.com/Debbyjones99/From-Procurement-to-Performance-Analyzing-21.8B-in-Construction-Operations-with-SQL-and-Power-BI/blob/main/Dashboard_Screenshot/supplier_performance_dashboard_Onyewem.png" />
<p></p>

- 79 active suppliers with moderate performance score (60/100)
- 36 high-risk suppliers identified Frequent delivery delays (avg: 96.1%)
- No strong supplier concentration risk (<2% per supplier)


## Equipment & Operations
<p></p>
<img width="622" height="372" alt="Executive_dashboard" src="https://github.com/Debbyjones99/From-Procurement-to-Performance-Analyzing-21.8B-in-Construction-Operations-with-SQL-and-Power-BI/blob/main/Dashboard_Screenshot/equipment_efficiency_dashboard_Onyewem.png" />
<P></P>

- Fuel: ₦380M | Equipment: ₦1.41B | Transport: ₦232M
- Fuel usage remained proportional to equipment utilization (no major anomalies)
- Equipment 5048 recorded highest operational cost impact

## Project Health Assessment

Project health scoring identified widespread portfolio performance challenges.

Results showed:

* 41 Critical Projects
* 9 At-Risk Projects

Key drivers included:

* Budget overruns
* Delivery delays
* Low workforce utilization
* Unfavorable cost variances

Budget analysis further revealed:

* 41 projects exceeded budget expectations
* 7 projects were in a critical budget condition
* 2 projects were at risk of future budget overruns

## Key Findings 

Material costs contributed 86.2% of total operational expenses, highlighting procurement as the primary cost driver across all projects. This level of concentration suggests that procurement efficiency, supplier pricing, and sourcing strategy have a disproportionate impact on overall project profitability and cost control.

## Strategic Recommendations

1. Prioritize procurement optimization initiatives since material costs account for approximately 86% of total operational spending.
2. Implement stronger supplier performance monitoring programs focused on delivery reliability and lead-time reduction.
3. Conduct detailed reviews of high-risk and critical projects to identify root causes of budget overruns.
4. Improve workforce allocation processes to reduce underutilization and maximize labor productivity.
5. Establish automated anomaly detection systems to monitor unusual operational transactions in real time.
6. Perform operational audits in Lagos to identify drivers of inefficiency and replicate best practices from higher-performing locations.
7. Introduce stricter budget governance and forecasting processes to reduce widespread project cost overruns.

## Data Limitation 
Analysis was based on historical data without real-time validation, and findings are correlation-based rather than experimentally tested. External market and operational factors were not included in the dataset.

## Contact

Open to Data Analyst opportunities.

- Email: deborahjonah06@gmail.com
- LinkedIn: https://www.linkedin.com/in/deborah-jonah-220210327











