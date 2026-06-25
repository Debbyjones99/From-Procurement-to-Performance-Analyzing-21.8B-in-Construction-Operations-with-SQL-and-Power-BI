# Construction Operations, Procurement & Performance Analysis
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
- Workforce Performance Dashboard
- Supplier & Procurement Performance Dashboard
- Equipment Operations & Utilization Dashboard
- Project Health Assessment
- Key Findings
- Strategic Recommendations
- Data Limitations
- Contact

## Project Overview

This project analyzes operational data from 50 building construction projects with over ₦21.8 billion in total spending. Using SQL (PostgreSQL) for analysis and Power BI for visualization, the project evaluates procurement efficiency, supplier performance, workforce utilization, equipment operations, project health, and budget management.

The goal was to identify key cost drivers, detect operational inefficiencies, assess supplier and project risks, and uncover opportunities for cost optimization and performance improvement.


## Business Problem

The organization lacked a centralized view of project performance, procurement spending, supplier risk, workforce utilization, equipment efficiency, and budget control across multiple construction projects.
Without visibility into these areas, management faced challenges identifying cost overruns, operational inefficiencies, supplier-related risks, and underperforming projects.


## Business Objectives
* Identify major operational cost drivers across projects.
* Evaluate supplier performance and procurement risks.
* Assess workforce utilization and labor efficiency.
* Monitor equipment and operational cost performance.
* Detect budget overruns and project health issues.
* Provide data-driven recommendations to improve operational efficiency and cost control.


## Dataset Description
The dataset contains operational data from 50 building construction projects across multiple locations in Nigeria.
### Dataset 
* <a href=https:https://github.com/Debbyjones99/Construction-Operations-Procurement-Performance-Analysis/tree/main/Dataset>Construction Operations, Procurement & Performance Analysis</a>


### Dataset Coverage

* 50 building Construction Projects
* 500 Workers
* 100 Suppliers
* Multiple Equipment Assets
* Procurement Transactions
* Budget and Operational Cost Records

### Dataset Includes

* Project Information
* Workforce Records
* Supplier Performance Data
* Procurement Transactions
* Equipment Operations
* Financial & Budget Data



## Tools & Methodology

### Tools Used

* **SQL (PostgreSQL)** – Data cleaning, aggregation, joins, and analytical queries
* **Power BI** – Data visualization, dashboard development, and KPI tracking

### Methodology

1. Data Cleaning & Preparation
2. Data Modeling
3. SQL Analysis
4. Business Analysis
5. Dashboard Development

## Data Model

The data model follows a **star schema structure** designed to support efficient analysis of construction operations.

### Fact Table

**Operations Fact Table**

Stores transactional records related to:

* Material Costs
* Labour Costs
* Equipment Costs
* Fuel Costs
* Transportation Costs

**Dimension Tables**

* Project Dimension
* Workforce Dimension
* Supplier Dimension
* Equipment Dimension
* Time Dimension

**Relationships**

The Operations Fact Table serves as the central table.

Dimension tables were connected using Project ID, Worker ID, Supplier ID, Equipment ID, and other relevant foreign keys to support analysis across projects, suppliers, workforce, equipment, and financial performance.


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
This project analyzes operational, procurement, workforce, supplier, equipment, and budget performance across 50  building construction projects using SQL and Power BI, covering over ₦21.8 billion in total operational spending.
<p></p>
The analysis revealed significant budget overruns, procurement-driven cost concentration, supplier performance risks, workforce utilization inefficiencies, and project-level performance disparities. While fuel efficiency and supplier diversification remained relatively stable, procurement cost control and project governance emerged as the most critical areas for improvement.
<p></p>
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

## Workforce Performance Dashboard
<p></p>
<img width="622" height="372" alt="Executive_dashboard" src="https://github.com/Debbyjones99/From-Procurement-to-Performance-Analyzing-21.8B-in-Construction-Operations-with-SQL-and-Power-BI/blob/main/Dashboard_Screenshot/workforce_optimization_dashboard_Onyewem.png" />

- 500 workers (50% contractors)
- Contractors were primary cost drivers in 26 projects
- Premium skilled workers concentrated in Masons, Electricians, Plumbers, Carpenters
- Evidence of underutilization in workforce allocation (e.g., Worker 40217)
  

## Supplier & Procurement Performance Dashboard
<p></p>
<img width="622" height="372" alt="Executive_dashboard" src="https://github.com/Debbyjones99/From-Procurement-to-Performance-Analyzing-21.8B-in-Construction-Operations-with-SQL-and-Power-BI/blob/main/Dashboard_Screenshot/supplier_performance_dashboard_Onyewem.png" />
<p></p>

- 79 active suppliers with moderate performance score (60/100)
- 36 high-risk suppliers identified Frequent delivery delays (avg: 96.1%)
- No strong supplier concentration risk (<2% per supplier)


## Equipment Operations & Utilization Dashboard
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
- Analysis was based on historical data without real-time validation, and findings are correlation-based rather than experimentally tested. External market and operational factors were not included in the dataset.
- External factors such as market conditions, inflation, weather, regulatory changes, and economic conditions were not included in the dataset.
- Results are dependent on the completeness and accuracy of the source data provided.

## Contact

Open to Data Analyst opportunities.

- Email: deborahjonah06@gmail.com
- LinkedIn: https://www.linkedin.com/in/deborah-jonah-220210327











