# Stage 2: Data Cleaning Strategy

## Purpose

This document defines the planned cleaning and preprocessing steps for the HMIS dataset before SQL analysis, Python EDA, and Power BI dashboard development.

The goal is not to change the raw data directly. The raw files should remain unchanged in:

```text
data/raw/hospital_data/
```

Cleaned or analysis-ready files will later be saved in:

```text
data/processed/
```

## Current Data Quality Summary

The Stage 2 dataset review found:

- all 19 expected CSV files are available
- no duplicate rows were found
- all primary keys are unique
- no primary key values are missing
- no foreign key relationship mismatches were found
- only one missing-value issue was found: `billing_detail.reference_id`

## Main Cleaning Priorities

## 1. Convert Date Columns

Several date columns were loaded as text/object columns. These should be converted into proper date format.

Planned date columns:

| Table | Date Columns |
|---|---|
| patient | `date_of_birth` |
| admission | `admission_date`, `discharge_date` |
| billing | `bill_date` |
| patient_diagnostic | `test_date` |
| drug_inventory | `last_restock_date` |
| patient_insurance | `policy_start_date`, `policy_end_date` |
| employee | `date_of_joining` |

Why this matters:

- enables trend analysis
- allows monthly and yearly grouping
- supports length of stay calculation
- supports patient age calculation

## 2. Create Patient Age and Age Groups

The raw patient table has `date_of_birth`, but not age.

Planned derived fields:

- `patient_age`
- `age_group`

Suggested age groups:

| Age Group | Range |
|---|---|
| Child | 0-12 |
| Teen | 13-19 |
| Young Adult | 20-34 |
| Adult | 35-54 |
| Senior | 55-69 |
| Elderly | 70+ |

Why this matters:

- supports patient demographic analysis
- helps compare disease patterns by age group
- improves dashboard readability

## 3. Calculate Length of Stay

The admission table has `admission_date` and `discharge_date`.

Planned derived field:

```text
length_of_stay_days = discharge_date - admission_date
```

Why this matters:

- key hospital operations KPI
- supports department workload analysis
- helps identify long-stay patterns

Quality checks:

- discharge date should not be before admission date
- length of stay should not be negative
- unusually long stays should be reviewed as outliers

## 4. Create Time-Based Columns

For trend analysis, create year and month fields from date columns.

Planned fields:

- `admission_year`
- `admission_month`
- `admission_year_month`
- `bill_year`
- `bill_month`
- `bill_year_month`

Why this matters:

- supports line charts in Power BI
- supports monthly and yearly trend analysis
- simplifies SQL grouping

## 5. Validate Billing Amounts

The billing table includes:

- `total_amount`
- `insurance_covered_amount`
- `patient_payable_amount`

Planned checks:

- total amount should not be negative
- insurance-covered amount should not be negative
- patient payable amount should not be negative
- insurance-covered amount should not exceed total amount
- insurance-covered amount plus patient payable amount should approximately equal total amount

Planned derived field:

```text
insurance_coverage_percent = insurance_covered_amount / total_amount
```

Why this matters:

- supports financial dashboard KPIs
- improves insurance and patient payable analysis

## 6. Investigate Missing `billing_detail.reference_id`

The only major missing-value issue is:

```text
billing_detail.reference_id
```

Missing count:

```text
67,402 missing values
```

Missing percentage:

```text
59.97%
```

Planned investigation:

- review missing `reference_id` by `charge_type`
- check whether reference ID is only required for specific charge types
- decide whether missing values are expected business logic or actual data quality issues

Possible interpretation:

- diagnostic test charges may reference `test_id`
- drug charges may reference `drug_id`
- room, consultation, or service charges may not require a reference ID

## 7. Standardize Categorical Values

Categorical columns should be checked for inconsistent spelling, casing, or spacing.

Examples:

- `gender`
- `admission_type`
- `admission_status`
- `payment_status`
- `payment_mode`
- `bed_status`
- `department_type`
- `ward_type`
- `result_status`
- `inventory_status`

Why this matters:

- avoids duplicate categories in dashboard filters
- improves data consistency
- supports accurate grouping in SQL and Power BI

## 8. Prepare Analysis-Ready Tables

After cleaning, create processed tables for analysis.

Possible processed outputs:

| Output File | Purpose |
|---|---|
| `processed_patients.csv` | patient demographics with age and age group |
| `processed_admissions.csv` | admissions with length of stay and time fields |
| `processed_billing.csv` | billing with insurance coverage percentage and time fields |
| `processed_billing_detail.csv` | billing detail with reference ID interpretation |

For Power BI, we may also create a combined analytical table later, but initially it is better to preserve the relational structure.

## Stage 3 Implementation Plan

Stage 3 should be completed in a new notebook:

```text
notebooks/02_data_cleaning_preprocessing.ipynb
```

Recommended order:

1. Load raw CSV files.
2. Convert date columns.
3. Create patient age and age groups.
4. Create length of stay.
5. Create year/month columns.
6. Validate billing amounts.
7. Investigate `billing_detail.reference_id`.
8. Check categorical values.
9. Save cleaned files to `data/processed/`.

## Stage 2 Conclusion

The dataset is structurally clean and suitable for healthcare analytics.

The cleaning stage will focus less on fixing severe data problems and more on creating useful derived fields for analysis and dashboards.
