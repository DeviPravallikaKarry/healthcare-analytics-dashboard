# Stage 4: SQL Analytics Summary

## Purpose

Stage 4 focused on using MySQL to calculate healthcare analytics KPIs and dashboard-ready query outputs.

The goal was to demonstrate practical SQL skills for healthcare data analyst, clinical data analyst, and healthcare BI roles.

## Database Used

```sql
hospital_analytics
```

The database was created in MySQL Workbench and loaded using processed CSV files from:

```text
data/processed/
```

## SQL Files Created

| SQL File | Purpose |
|---|---|
| `01_database_validation.sql` | Validate table import and row counts |
| `02_core_kpis.sql` | Calculate core hospital KPIs |
| `03_executive_dashboard_queries.sql` | Executive Dashboard query set |
| `04_clinical_dashboard_queries.sql` | Clinical Dashboard query set |
| `05_operations_dashboard_queries.sql` | Operations Dashboard query set |
| `06_financial_dashboard_queries.sql` | Financial Dashboard query set |

## Result Documents Created

| Document | Purpose |
|---|---|
| `stage4-core-kpi-results.md` | Core KPI outputs and interpretation |
| `stage4-executive-dashboard-results.md` | Executive Dashboard SQL results |
| `stage4-clinical-dashboard-results.md` | Clinical Dashboard SQL results |
| `stage4-operations-dashboard-results.md` | Operations Dashboard SQL results |
| `stage4-financial-dashboard-results.md` | Financial Dashboard SQL results |

## Core KPI Findings

| KPI | Value |
|---|---:|
| Total patients | 30,000 |
| Total admissions | 45,000 |
| Total departments | 11 |
| Total revenue | 1,684,246,109 |
| Insurance-covered amount | 976,880,867 |
| Patient-payable amount | 707,365,242 |
| Average length of stay | 5.16 days |

## Executive Dashboard Findings

- Admissions are stable from 2020 to 2025.
- Average length of stay stays close to 5.1 days each year.
- Surgery has the highest admission volume and revenue.
- ICU has lower admissions but much higher average length of stay.
- Infectious diseases are the largest disease category, representing 25.00% of admissions.

## Clinical Dashboard Findings

- The dataset includes 63,269 diagnostic test records and 73,109 prescriptions.
- Infectious diseases are the largest clinical category.
- Diagnostic results are almost evenly split between abnormal and normal.
- Pathology has higher diagnostic test volume than Radiology.
- Surgery has the highest clinical workload.
- ICU has lower volume but substantially longer length of stay.

## Operations Dashboard Findings

- Surgery has the highest admission workload.
- ICU has the longest average length of stay.
- Elective admissions are higher than emergency admissions across departments.
- Current bed status shows 65.06% occupied beds.
- Emergency, Pediatrics, and Orthopedics show high cumulative admissions per bed used.
- ICU requires careful monitoring because long stays can create capacity pressure.

## Financial Dashboard Findings

- Total revenue is 1.68 billion.
- Insurance-covered amount contributes 58% of total billed amount.
- Patient-payable amount contributes 42% of total billed amount.
- Pending billing amount is slightly higher than paid billing amount.
- Insurance is the dominant payment mode.
- Surgery is the highest revenue department.
- Infectious diseases generate the highest disease-category revenue.
- Room charges dominate charge-type distribution.

## Important Data Interpretation Rules

Based on Stage 3 validation and Stage 4 SQL analysis:

- Use `admission` as the central table for operational, clinical, and patient analytics.
- Use `billing` as the source of truth for official financial KPIs.
- Use `billing_detail` only for high-level charge-type distribution.
- Do not use `billing_detail` as audited revenue because detail totals do not reconcile exactly with bill totals.
- Avoid `billing.bill_date` for primary revenue trends because many bill dates occur before admission/discharge.
- Use admission month or discharge date for main trend analysis.
- Interpret `admissions_per_bed` as cumulative throughput, not real-time occupancy.
- Interpret `bed_status` as current bed master status.

## Stage 4 Conclusion

Stage 4 is complete.

The project now has SQL query files and interpreted results for:

- core KPIs
- Executive Dashboard
- Clinical Dashboard
- Operations Dashboard
- Financial Dashboard

These results will guide later Python EDA and Power BI dashboard design.

