# Stage 4: SQL Analytics and KPI Analysis

## Purpose

Stage 4 uses MySQL to calculate hospital KPIs and dashboard-ready analytical results.

This stage demonstrates SQL skills that are useful for healthcare data analyst, clinical data analyst, and healthcare BI roles.

## Database

MySQL schema:

```sql
hospital_analytics
```

The schema was loaded from processed CSV files in:

```text
data/processed/
```

## Stage 4 SQL Files

| SQL File | Purpose |
|---|---|
| `01_database_validation.sql` | Confirm tables and row counts after MySQL import |
| `02_core_kpis.sql` | Calculate core hospital KPIs |
| `03_executive_dashboard_queries.sql` | Executive dashboard query set |
| `04_clinical_dashboard_queries.sql` | Clinical dashboard query set |
| `05_operations_dashboard_queries.sql` | Operations dashboard query set |
| `06_financial_dashboard_queries.sql` | Financial dashboard query set |

## Completed So Far

- MySQL schema created: `hospital_analytics`
- processed CSV files imported successfully
- row counts validated
- database validation SQL file created
- core KPI SQL file created
- core KPI results documented
- executive dashboard SQL file created
- executive dashboard results documented
- clinical dashboard SQL file created
- clinical dashboard results documented
- operations dashboard SQL file created
- operations dashboard results documented
- financial dashboard SQL file created
- financial dashboard results documented
- Stage 4 SQL summary created

## Stage 4 Status

Stage 4 is complete.

## Important Data Interpretation Rules

Based on Stage 3 validation:

- Use `admission` as the central table for patient, clinical, and operational analytics.
- Use `billing` as the source of truth for financial KPIs.
- Use `billing_detail` only for high-level charge-type distribution.
- Avoid using `billing.bill_date` as the main revenue trend date because many billing dates occur before admission/discharge.
- Prefer admission or discharge dates for dashboard trend analysis.

## Next Steps

The next SQL files will answer dashboard-specific questions:

- executive overview
- clinical trends
- operations workload
- financial performance
