# Stage 6: Power BI Dashboard Development Plan

## Purpose

Stage 6 focuses on building an interactive Power BI dashboard using the processed HMIS dataset.

The dashboard will convert the SQL and Python findings into a visual portfolio-ready business intelligence project.

## Dashboard Pages

The Power BI report will have four pages:

1. Executive Dashboard
2. Clinical Dashboard
3. Operations Dashboard
4. Financial Dashboard

## Data Source

Use processed CSV files from:

```text
data/processed/
```

For the first Power BI version, use CSV files instead of connecting directly to MySQL.

Reason:

- easier to set up
- easier to share on GitHub
- avoids MySQL connector issues
- processed CSV files already contain cleaned fields
- Power BI can refresh from the local folder

## Recommended Tables to Load First

Load these core tables first:

| Table File | Power BI Table Name | Why It Is Needed |
|---|---|---|
| processed_patient.csv | patient | Demographics and age groups |
| processed_admission.csv | admission | Central fact table for operations and clinical analysis |
| processed_department.csv | department | Department names and types |
| processed_disease.csv | disease | Disease names and categories |
| processed_billing.csv | billing | Financial KPIs |
| processed_bed.csv | bed | Bed status |
| processed_ward.csv | ward | Ward and bed capacity |
| processed_patient_diagnostic.csv | patient_diagnostic | Diagnostic result analysis |
| processed_diagnostic_test.csv | diagnostic_test | Test names and categories |
| processed_prescription.csv | prescription | Prescription volume |
| processed_drug.csv | drug | Drug names and categories |

Optional later:

| Table File | Power BI Table Name | Why It Is Optional |
|---|---|---|
| processed_employee.csv | employee | Staff analysis |
| processed_doctor.csv | doctor | Doctor specialization |
| processed_staff_assignment.csv | staff_assignment | Ward shift staffing |
| processed_drug_inventory.csv | drug_inventory | Pharmacy inventory |
| processed_billing_detail.csv | billing_detail | Charge-type distribution only |
| processed_insurance_provider.csv | insurance_provider | Insurance provider analysis |
| processed_patient_insurance.csv | patient_insurance | Use cautiously due policy-date limitations |

## Data Model Principle

Use `admission` as the central table for most dashboard analysis.

Main relationships:

```text
patient[patient_id]              -> admission[patient_id]
department[department_id]        -> admission[department_id]
disease[disease_id]              -> admission[disease_id]
ward[ward_id]                    -> admission[ward_id]
bed[bed_id]                      -> admission[bed_id]
admission[admission_id]          -> billing[admission_id]
admission[admission_id]          -> patient_diagnostic[admission_id]
diagnostic_test[test_id]         -> patient_diagnostic[test_id]
admission[admission_id]          -> prescription[admission_id]
drug[drug_id]                    -> prescription[drug_id]
```

## Important Modeling Rules

- Use `billing` as the source of truth for financial KPIs.
- Use `billing_detail` only for charge-type distribution.
- Avoid using `bill_date` for main revenue trends.
- Use `admission_year_month` from `admission` for main time trends.
- Interpret `admissions_per_bed` as cumulative throughput, not real-time occupancy.
- Interpret `bed_status` as current bed master status.

## Page 1: Executive Dashboard

### Goal

Provide a high-level hospital performance overview.

### KPI Cards

- Total Admissions
- Total Patients
- Total Revenue
- Average Length of Stay
- Insurance Covered Amount
- Patient Payable Amount

### Suggested Visuals

- Line chart: Admissions by Year/Month
- Bar chart: Admissions by Department
- Bar chart: Revenue by Department
- Bar chart: Disease Category Distribution
- Table: Department Performance

### Suggested Slicers

- Admission Year
- Department Name
- Disease Category
- Admission Type

## Page 2: Clinical Dashboard

### Goal

Show disease, diagnostic, prescription, and patient demographic patterns.

### KPI Cards

- Total Admissions
- Total Diagnostic Tests
- Total Prescriptions
- Total Diseases
- Abnormal Diagnostic Results

### Suggested Visuals

- Bar chart: Disease Category Distribution
- Bar chart: Top Diseases
- Bar chart: Diagnostic Result Status
- Bar chart: Diagnostic Test Usage
- Bar chart: Patient Age Group Distribution
- Bar chart: Prescription Volume by Drug Category

### Suggested Slicers

- Age Group
- Gender
- Disease Category
- Department Name

## Page 3: Operations Dashboard

### Goal

Show hospital workload, patient flow, length of stay, bed status, and operational pressure.

### KPI Cards

- Total Admissions
- Emergency Admissions
- Elective Admissions
- Average Length of Stay
- Occupied Beds
- Available Beds

### Suggested Visuals

- Bar chart: Department Workload
- Stacked bar chart: Admission Type by Department
- Bar chart: Average Length of Stay by Department
- Bar chart: Bed Status
- Bar chart: Ward Workload
- Table: Potential Bottleneck View

### Suggested Slicers

- Department Name
- Ward Type
- Admission Type
- Admission Year

## Page 4: Financial Dashboard

### Goal

Show revenue, payment status, payment mode, insurance contribution, and financial risks.

### KPI Cards

- Total Revenue
- Insurance Covered Amount
- Patient Payable Amount
- Average Bill Amount
- Pending Amount
- Paid Amount

### Suggested Visuals

- Bar chart: Revenue by Department
- Bar chart: Revenue by Disease Category
- Bar chart: Payment Status Amount
- Bar chart: Payment Mode Amount
- Bar chart: Insurance vs Patient Payable
- Line chart: Revenue by Admission Month

### Suggested Slicers

- Department Name
- Payment Status
- Payment Mode
- Disease Category
- Admission Year

## Build Order

Recommended order:

1. Load processed CSV files.
2. Check data types in Power Query.
3. Create relationships in Model View.
4. Create DAX measures.
5. Build Executive Dashboard first.
6. Build Clinical Dashboard.
7. Build Operations Dashboard.
8. Build Financial Dashboard.
9. Review design and formatting.
10. Save dashboard screenshots.

## Stage 6 Output

Expected outputs:

- Power BI `.pbix` file
- dashboard screenshots
- dashboard documentation
- final dashboard insights

