# Stage 4: MySQL Import Guide

## Purpose

This guide explains how to load the processed hospital analytics CSV files into MySQL Workbench.

The processed files are stored in:

```text
data/processed/
```

The MySQL schema is:

```sql
hospital_analytics
```

## Why We Are Using MySQL

MySQL is suitable for this portfolio project because healthcare data analyst roles often expect SQL skills.

Using MySQL allows us to practice:

- table imports
- joins
- grouping
- filtering
- KPI calculations
- dashboard-ready SQL queries

## Import Method

One table was imported manually first:

```text
processed_department.csv -> department
```

This helped confirm that MySQL Workbench and the schema are working.

For the remaining project workflow, we use a Python script to load all processed CSV files automatically.

The script is:

```text
scripts/load_processed_to_mysql.py
```

## What the Script Does

The script:

- reads all files named `processed_*.csv`
- removes the `processed_` prefix from table names
- loads each file into MySQL
- replaces existing tables with the same name
- asks for the MySQL password at runtime

Example:

| CSV File | MySQL Table |
|---|---|
| processed_patient.csv | patient |
| processed_admission.csv | admission |
| processed_billing.csv | billing |
| processed_department.csv | department |

## Important Note

The script uses:

```python
if_exists="replace"
```

This means if a table already exists in `hospital_analytics`, it will be replaced with the processed CSV version.

This is okay for this project because the processed CSV files are our cleaned analysis-ready source.

## How to Run the Script

Open Command Prompt and move into the project folder:

```bat
cd "C:\Users\devip\Desktop\Healthcare Projects\Healthcare-Analytics-Project"
```

Run the script:

```bat
python scripts\load_processed_to_mysql.py
```

When it asks:

```text
Enter your MySQL password for user root:
```

Type your MySQL root password and press Enter.

The password may not visibly appear while typing. That is normal.

## After Import

Open MySQL Workbench.

In the left Schemas panel:

1. Right-click inside the Schemas area.
2. Click **Refresh All**.
3. Expand `hospital_analytics`.
4. Expand **Tables**.

You should see 19 tables:

- admission
- bed
- billing
- billing_detail
- department
- diagnostic_test
- disease
- doctor
- drug
- drug_inventory
- drug_manufacturer
- employee
- insurance_provider
- patient
- patient_diagnostic
- patient_insurance
- prescription
- staff_assignment
- ward

## Validation Query

Run this in MySQL Workbench:

```sql
USE hospital_analytics;

SHOW TABLES;
```

Then test a few row counts:

```sql
SELECT COUNT(*) AS total_patients FROM patient;
SELECT COUNT(*) AS total_admissions FROM admission;
SELECT COUNT(*) AS total_bills FROM billing;
SELECT COUNT(*) AS total_departments FROM department;
```

Expected results:

| Table | Expected Rows |
|---|---:|
| patient | 30,000 |
| admission | 45,000 |
| billing | 45,000 |
| department | 11 |

## Next Step

After confirming that the tables loaded correctly, we will create SQL KPI queries for:

- executive dashboard
- clinical dashboard
- operations dashboard
- financial dashboard

