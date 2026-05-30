# Stage 2: Initial Data Quality Report

## Purpose

This report summarizes the first data quality review of the raw HMIS dataset.

The goal is to understand whether the dataset is ready for cleaning, SQL analysis, and Power BI dashboard development.

## Dataset Location

```text
data/raw/hospital_data/
```

## File Availability Check

All expected CSV files are available.

```text
Expected files: 19
Available files: 19
Missing files: 0
Extra files: 0
```

## Table Summary

| Table | Rows | Columns | Duplicate Rows | Missing Values |
|---|---:|---:|---:|---:|
| admission | 45,000 | 10 | 0 | 0 |
| bed | 415 | 4 | 0 | 0 |
| billing | 45,000 | 8 | 0 | 0 |
| billing_detail | 112,402 | 5 | 0 | 67,402 |
| department | 11 | 5 | 0 | 0 |
| diagnostic_test | 9 | 5 | 0 | 0 |
| disease | 20 | 3 | 0 | 0 |
| doctor | 98 | 5 | 0 | 0 |
| drug | 250 | 6 | 0 | 0 |
| drug_inventory | 250 | 6 | 0 | 0 |
| drug_manufacturer | 300 | 5 | 0 | 0 |
| employee | 500 | 7 | 0 | 0 |
| insurance_provider | 50 | 5 | 0 | 0 |
| patient | 30,000 | 6 | 0 | 0 |
| patient_diagnostic | 63,269 | 6 | 0 | 0 |
| patient_insurance | 21,617 | 7 | 0 | 0 |
| prescription | 73,109 | 6 | 0 | 0 |
| staff_assignment | 207 | 4 | 0 | 0 |
| ward | 27 | 5 | 0 | 0 |

## Duplicate Check

No duplicate rows were found in any table.

This is important because duplicates can incorrectly increase:

- admission counts
- patient counts
- billing totals
- prescription counts
- diagnostic test usage
- department workload metrics

## Primary Key Check

All primary keys are unique and complete.

This means each table has a reliable unique identifier, such as:

- `patient_id` in `patient.csv`
- `admission_id` in `admission.csv`
- `bill_id` in `billing.csv`
- `department_id` in `department.csv`

## Relationship Check

No foreign key mismatches were found.

This means the major table relationships are valid. For example:

- every admission links to a valid patient
- every admission links to a valid department
- every billing record links to a valid admission
- every prescription links to a valid drug
- every diagnostic record links to a valid test and doctor

This is a strong sign that the dataset is structurally ready for relational analysis.

## Missing Value Finding

Only one missing-value issue was found.

| Table | Column | Missing Count | Missing Percent |
|---|---|---:|---:|
| billing_detail | reference_id | 67,402 | 59.97% |

## Interpretation of Missing `reference_id`

The missing values in `billing_detail.reference_id` may not automatically mean the data is bad.

In a hospital billing detail table, `reference_id` may only apply to certain charge types. For example:

- a diagnostic test charge may reference `test_id`
- a drug charge may reference `drug_id`
- a room charge or consultation charge may not need a reference ID

Because of this, the next step is to inspect `charge_type` and understand when `reference_id` is expected.

## Stage 2 Conclusion

The dataset is suitable for this healthcare analytics portfolio project.

Current assessment:

- file structure is complete
- relational structure is valid
- duplicate rows are not present
- primary keys are reliable
- foreign key relationships are valid
- only one missing-value issue needs further interpretation

## Cleaning Considerations for Stage 3

Stage 3 should focus on:

- converting date columns into datetime format
- calculating patient age
- creating age groups
- calculating length of stay
- validating billing calculations
- checking whether `billing_detail.reference_id` is missing because of valid business logic
- preparing cleaned datasets for SQL and Power BI

