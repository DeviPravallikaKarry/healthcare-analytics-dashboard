# Stage 6: Power BI Dashboard Summary

## Purpose

Stage 6 focused on building and validating the Power BI dashboard for the HMIS healthcare analytics project.

The goal was to convert SQL and Python findings into an interactive dashboard suitable for a healthcare analytics portfolio.

## Power BI File

```text
dashboard/Hospital_Operations_Patient_Analytics.pbix
```

## Dashboard Pages

The Power BI report contains four main pages:

1. Executive Dashboard
2. Clinical Dashboard
3. Operations Dashboard
4. Financial Dashboard

## Screenshots

Final dashboard screenshots are saved in:

```text
screenshots/
```

| Screenshot | Dashboard Page |
|---|---|
| `executive_dashboard.png` | Executive Dashboard |
| `clinical_dashboard.png` | Clinical Dashboard |
| `operations_dashboard.png` | Operations Dashboard |
| `financial_dashboard.png` | Financial Dashboard |

## Executive Dashboard

### Purpose

Provides hospital leadership with a high-level view of patient volume, revenue, department performance, and disease patterns.

### Main KPIs

- Total Admissions
- Admitted Patients
- Total Revenue
- Average Length of Stay
- Insurance Covered
- Patient Payable

### Main Visuals

- Admissions Trend by Year
- Admissions by Department
- Revenue by Department
- Admissions by Disease Category

### Main Slicers

- Admission Year
- Department
- Admission Type

## Clinical Dashboard

### Purpose

Shows clinical workload, diagnostic results, patient age group patterns, disease categories, and prescription patterns.

### Main KPIs

- Total Admissions
- Total Diagnostic Tests
- Total Prescriptions
- Abnormal Diagnostic Results
- Abnormal Result %

### Main Visuals

- Admissions by Disease Category
- Diagnostic Result Status
- Admitted Patients by Age Group
- Diagnostic Test Usage
- Prescriptions by Drug Category

### Main Slicers

- Age Group
- Gender
- Disease Category
- Department

### Important Note

The dataset is synthetic. Pediatric department or pediatric disease category records are not restricted only to child patients. Age group should be interpreted from patient date of birth, not from department or disease-category names.

## Operations Dashboard

### Purpose

Shows hospital workload, admission type, length of stay, ward workload, and current bed status.

### Main KPIs

- Total Admissions
- Emergency Admissions
- Elective Admissions
- Average Length of Stay
- Current Occupied Beds
- Current Available Beds

### Main Visuals

- Department Workload
- Average Length of Stay by Department
- Admission Type by Department
- Current Bed Status
- Ward Workload

### Main Slicers

- Department
- Ward Type
- Admission Year

### Important Note

Current bed status is a hospital-wide current capacity metric. It is not filtered by admission-based slicers.

The Ward Type slicer primarily affects Ward Workload. This is intentional because ward and bed relationships can create ambiguous model paths in Power BI.

## Financial Dashboard

### Purpose

Shows hospital revenue, insurance contribution, patient payable amount, payment status, payment mode, and revenue by department/disease category.

### Main KPIs

- Total Revenue
- Insurance Covered
- Patient Payable
- Average Bill Amount
- Pending Amount
- Paid Amount

### Main Visuals

- Revenue by Department
- Payment Mode Amount
- Revenue by Disease Category
- Payment Status Amount
- Insurance vs Patient Payable

### Main Slicers

- Department
- Payment Status
- Payment Mode
- Disease Category

## DAX Measures

The dashboard uses DAX measures for:

- admissions
- admitted patients
- revenue
- insurance-covered amount
- patient-payable amount
- average bill amount
- paid amount
- pending amount
- diagnostic tests
- abnormal result percentage
- prescriptions
- current occupied beds
- current available beds

Detailed DAX formulas are documented in:

```text
docs/stage6-powerbi-dax-measures.md
```

## Validation

Dashboard values were validated using SQL spot checks in MySQL Workbench.

Validated areas:

- Executive Dashboard filters and KPI values
- Clinical Dashboard filters and diagnostic/prescription counts
- Operations Dashboard admission, length-of-stay, and bed status metrics
- Financial Dashboard revenue, payment status, payment mode, and average bill values

Validation result:

```text
Selected Power BI dashboard values matched SQL outputs.
```

## Key Dashboard Insights

- Admissions are stable across 2020-2025.
- Surgery has the highest admission workload and revenue.
- ICU has the highest average length of stay.
- Infectious diseases are the largest disease category.
- Elderly patients are the largest age group.
- Insurance-covered amount is higher than patient-payable amount.
- Pending billing amount is slightly higher than paid billing amount.
- Current bed status shows more occupied beds than available beds.

## Stage 6 Conclusion

Stage 6 is complete.

The project now has a validated Power BI dashboard with four pages covering executive, clinical, operational, and financial analytics.

