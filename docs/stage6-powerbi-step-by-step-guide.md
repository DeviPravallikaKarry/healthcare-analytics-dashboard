# Stage 6: Power BI Step-by-Step Guide

## Purpose

This guide explains how to build the Power BI dashboard step by step.

It is written for someone who has used Power BI before but needs a detailed refresher.

## Step 1: Open Power BI Desktop

Open Power BI Desktop from the Start Menu.

When it opens, choose a blank report.

## Step 2: Save the Power BI File

Before loading data, save the file.

Suggested location:

```text
dashboard/
```

Suggested file name:

```text
Hospital_Operations_Patient_Analytics.pbix
```

Why this matters:

Saving early prevents losing work and keeps the dashboard file inside the project folder.

## Step 3: Load Processed CSV Files

Go to:

```text
Home > Get Data > Text/CSV
```

Load files from:

```text
data/processed/
```

Start with these files:

- `processed_patient.csv`
- `processed_admission.csv`
- `processed_department.csv`
- `processed_disease.csv`
- `processed_billing.csv`
- `processed_bed.csv`
- `processed_ward.csv`
- `processed_patient_diagnostic.csv`
- `processed_diagnostic_test.csv`
- `processed_prescription.csv`
- `processed_drug.csv`

For each file:

1. Select the CSV.
2. Preview the data.
3. Click **Transform Data**, not Load.

Why Transform Data?

Power Query lets us check column names and data types before loading the data into the report model.

## Step 4: Rename Tables

In Power Query, rename tables by removing `processed_`.

Examples:

| Original Name | Rename To |
|---|---|
| processed_patient | patient |
| processed_admission | admission |
| processed_department | department |
| processed_billing | billing |

Why this matters:

Clean table names make DAX formulas and relationships easier to read.

## Step 5: Check Data Types

In Power Query, check important columns:

### admission

- `admission_id`: Whole Number
- `patient_id`: Whole Number
- `department_id`: Whole Number
- `ward_id`: Whole Number
- `bed_id`: Whole Number
- `disease_id`: Whole Number
- `admission_date`: Date
- `discharge_date`: Date
- `length_of_stay_days`: Whole Number
- `admission_year`: Whole Number
- `admission_month`: Whole Number
- `admission_year_month`: Text

### patient

- `patient_id`: Whole Number
- `date_of_birth`: Date
- `patient_age`: Whole Number
- `age_group`: Text

### billing

- `bill_id`: Whole Number
- `admission_id`: Whole Number
- `total_amount`: Decimal Number or Whole Number
- `insurance_covered_amount`: Decimal Number
- `patient_payable_amount`: Decimal Number
- `insurance_coverage_percent`: Decimal Number

Why this matters:

Wrong data types can break relationships, DAX measures, charts, and filters.

## Step 6: Close and Apply

After checking table names and data types, click:

```text
Home > Close & Apply
```

Power BI will load the tables into the model.

## Step 7: Create Relationships

Go to:

```text
Model View
```

Create/check relationships:

```text
patient[patient_id] -> admission[patient_id]
department[department_id] -> admission[department_id]
disease[disease_id] -> admission[disease_id]
ward[ward_id] -> admission[ward_id]
bed[bed_id] -> admission[bed_id]
admission[admission_id] -> billing[admission_id]
admission[admission_id] -> patient_diagnostic[admission_id]
diagnostic_test[test_id] -> patient_diagnostic[test_id]
admission[admission_id] -> prescription[admission_id]
drug[drug_id] -> prescription[drug_id]
```

Recommended relationship settings:

- Cardinality: One to many
- Cross filter direction: Single
- Active: Yes

Why this matters:

Relationships allow filters from patient, department, disease, and dates to affect admissions, billing, diagnostics, and prescriptions.

## Step 8: Create DAX Measures

Go to Report View.

Right-click a table, preferably `admission`, and choose:

```text
New measure
```

Create measures from:

```text
docs/stage6-powerbi-dax-measures.md
```

Why this matters:

Measures are reusable calculations for KPI cards and visuals.

## Step 9: Build Executive Dashboard First

Create the first page:

```text
Executive Dashboard
```

Start with:

- KPI cards at the top
- trend chart in the middle
- department and disease visuals below

Suggested visuals:

- Card: Total Admissions
- Card: Admitted Patients
- Card: Total Revenue
- Card: Average Length of Stay
- Line chart: Admissions by admission_year
- Bar chart: Admissions by department_name
- Bar chart: Revenue by department_name
- Bar chart: Admissions by disease_category

## Step 10: Save Frequently

Save the file after each major change.

Suggested shortcut:

```text
Ctrl + S
```

## Current Task

For now, complete only:

1. Open Power BI.
2. Save the PBIX file inside `dashboard/`.
3. Load the first 11 processed CSV files.
4. Rename tables.
5. Check data types.
6. Close and Apply.

After that, share what you see or send a screenshot if anything looks confusing.

