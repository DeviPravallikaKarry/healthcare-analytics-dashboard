# Stage 2: Dataset Selection & Understanding

## Selected Dataset

**Dataset name:** Hospital Management Information System (HMIS) Dataset

This project uses a synthetic but realistic hospital dataset designed for healthcare analytics, dashboards, SQL practice, and operational insight generation.

## Why This Dataset Was Selected

This dataset is suitable for a healthcare analytics portfolio project because it contains multiple hospital domains:

- patient demographics
- admissions and discharge details
- departments, wards, and beds
- diseases and diagnostic tests
- billing and insurance
- prescriptions and pharmacy inventory
- doctors, employees, and staff assignments

The structure is relational, which means the data is stored across multiple connected tables instead of one flat file. This is useful because healthcare analysts often work with data from hospital information systems where joins are needed to answer business questions.

## Central Table

The most important table for analysis is:

```text
admission.csv
```

Most major analytics questions connect back to admissions because an admission represents a hospital encounter.

Example relationships:

```text
patient -> admission -> department
patient -> admission -> disease
admission -> billing
admission -> patient_diagnostic
admission -> prescription
admission -> ward -> bed
```

## Initial Analytical Areas

### Executive Analytics

- total admissions
- total patients
- admission trends by year/month
- revenue trends
- department-level overview

### Clinical Analytics

- disease distribution
- diagnostic test usage
- prescription patterns
- patient demographics by disease category

### Operations Analytics

- department workload
- ward and bed utilization
- length of stay
- admission type and admission status
- staff and doctor workload

### Financial Analytics

- total billed amount
- insurance-covered amount
- patient payable amount
- payment status
- revenue by department, disease, and admission type

## Stage 2 Focus

At this stage, the goal is not to clean the dataset yet. The goal is to understand the data clearly before analysis.

Stage 2 tasks:

- confirm all expected CSV files are available
- load each table using Python
- check row and column counts
- inspect column names and data types
- identify primary keys and foreign keys
- check missing values and duplicates
- identify possible data quality issues
- document possible dashboard insights

## Dataset Location

Raw CSV files are stored in:

```text
data/raw/hospital_data/
```

