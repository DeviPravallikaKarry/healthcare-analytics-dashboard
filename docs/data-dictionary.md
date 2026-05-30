# Stage 2: Data Dictionary

## Purpose

This data dictionary explains the main tables and columns in the HMIS dataset in simple business terms.

It is useful for:

- understanding the dataset
- planning SQL joins
- designing Power BI dashboards
- explaining the project on GitHub

## Core Concept

The central table is `admission.csv`.

An admission represents one hospital encounter. Most patient, clinical, operational, and billing analytics connect back to admissions.

```text
patient -> admission -> department / ward / bed / disease
admission -> billing
admission -> patient_diagnostic
admission -> prescription
```

## Table-Level Dictionary

| Table | Type | Primary Key | Business Meaning |
|---|---|---|---|
| patient | Patient master | patient_id | Patient demographic information |
| admission | Central transaction | admission_id | Hospital admission and discharge details |
| department | Hospital master | department_id | Hospital departments such as Cardiology or Emergency |
| ward | Hospital master | ward_id | Ward-level information linked to departments |
| bed | Hospital master | bed_id | Bed details and bed status |
| disease | Clinical master | disease_id | Disease names and disease categories |
| diagnostic_test | Clinical master | test_id | Diagnostic tests and standard costs |
| patient_diagnostic | Clinical transaction | patient_diagnostic_id | Tests ordered/performed during admissions |
| prescription | Clinical transaction | prescription_id | Drugs prescribed during admissions |
| drug | Pharmacy master | drug_id | Drug catalog and drug cost |
| drug_inventory | Pharmacy transaction | inventory_id | Current drug stock and reorder details |
| drug_manufacturer | Pharmacy master | manufacturer_id | Drug manufacturer details |
| billing | Financial transaction | bill_id | Bill-level financial information |
| billing_detail | Financial transaction | billing_detail_id | Line-level billing charges |
| insurance_provider | Financial master | insurance_provider_id | Insurance company/provider details |
| patient_insurance | Financial transaction | patient_insurance_id | Patient insurance policy details |
| employee | Staff master | employee_id | Hospital staff details |
| doctor | Staff master | doctor_id | Doctor-specific details |
| staff_assignment | Staff transaction | assignment_id | Staff ward and shift assignments |

## Important Tables and Columns

### patient.csv

| Column | Meaning | Example Use |
|---|---|---|
| patient_id | Unique patient identifier | Count unique patients |
| gender | Patient gender | Gender-wise patient distribution |
| date_of_birth | Patient birth date | Calculate age |
| blood_group | Patient blood group | Patient profile analysis |
| city | Patient city | Geographic distribution |
| contact_number | Patient contact number | Not usually used for analytics |

### admission.csv

| Column | Meaning | Example Use |
|---|---|---|
| admission_id | Unique admission identifier | Count total admissions |
| admission_date | Date patient was admitted | Monthly/yearly admission trends |
| discharge_date | Date patient was discharged | Length of stay calculation |
| admission_type | Type of admission | Emergency vs elective analysis |
| admission_status | Current/final admission status | Discharged vs active cases |
| patient_id | Links admission to patient | Join with patient demographics |
| department_id | Links admission to department | Department workload |
| ward_id | Links admission to ward | Ward utilization |
| bed_id | Links admission to bed | Bed usage analysis |
| disease_id | Links admission to disease | Disease pattern analysis |

### billing.csv

| Column | Meaning | Example Use |
|---|---|---|
| bill_id | Unique bill identifier | Count bills |
| bill_date | Date bill was generated | Revenue trends |
| total_amount | Total billed amount | Total revenue |
| insurance_covered_amount | Amount covered by insurance | Insurance contribution |
| patient_payable_amount | Amount paid/payable by patient | Patient out-of-pocket amount |
| payment_status | Payment status | Pending vs paid analysis |
| payment_mode | Mode of payment | Insurance/cash/card trends |
| admission_id | Links bill to admission | Revenue by department/disease |

### billing_detail.csv

| Column | Meaning | Example Use |
|---|---|---|
| billing_detail_id | Unique billing line identifier | Count billing line items |
| charge_type | Type of charge | Room, drug, test, consultation analysis |
| reference_id | Optional reference to another item | Link some charges to tests or drugs |
| amount | Charge amount | Charge-level revenue |
| bill_id | Links detail line to bill | Detailed billing analysis |

### disease.csv

| Column | Meaning | Example Use |
|---|---|---|
| disease_id | Unique disease identifier | Join with admissions |
| disease_name | Disease name | Top diseases |
| disease_category | Disease group/category | Disease category trends |

### department.csv

| Column | Meaning | Example Use |
|---|---|---|
| department_id | Unique department identifier | Join with admissions |
| department_name | Department name | Revenue/workload by department |
| department_type | Department category | Clinical vs support grouping |
| floor_number | Hospital floor number | Location-based analysis |
| status | Department status | Active/inactive department check |

### ward.csv

| Column | Meaning | Example Use |
|---|---|---|
| ward_id | Unique ward identifier | Join with admissions and beds |
| ward_name | Ward name | Ward-level workload |
| ward_type | Type of ward | ICU/general/private analysis |
| total_beds | Number of beds in ward | Capacity analysis |
| department_id | Links ward to department | Department capacity |

### bed.csv

| Column | Meaning | Example Use |
|---|---|---|
| bed_id | Unique bed identifier | Join with admissions |
| bed_number | Bed label/number | Bed-level tracking |
| bed_status | Current bed status | Available vs occupied beds |
| ward_id | Links bed to ward | Ward bed analysis |

### patient_diagnostic.csv

| Column | Meaning | Example Use |
|---|---|---|
| patient_diagnostic_id | Unique diagnostic record identifier | Count tests performed |
| test_date | Date test was performed | Test volume trends |
| result_status | Diagnostic result status | Normal/abnormal pattern |
| admission_id | Links test to admission | Tests by patient encounter |
| test_id | Links to diagnostic test | Test name/category analysis |
| doctor_id | Doctor linked to test | Doctor workload |

### prescription.csv

| Column | Meaning | Example Use |
|---|---|---|
| prescription_id | Unique prescription identifier | Count prescriptions |
| dosage | Dose prescribed | Medication usage detail |
| frequency | Frequency of medication | Prescription pattern |
| duration_days | Duration of therapy | Medication duration analysis |
| admission_id | Links prescription to admission | Medications by diagnosis/admission |
| drug_id | Links prescription to drug | Drug usage analysis |

### employee.csv, doctor.csv, staff_assignment.csv

These tables support staff and workload analysis.

Useful questions:

- How many employees are assigned to each department?
- How many doctors are available by specialization?
- How are staff assigned across wards and shifts?
- Which departments may have higher workload compared with available staff?

## Notes for Analysis

- `admission.csv` should be used as the base table for most dashboard metrics.
- Date fields need conversion before time-based analysis.
- Patient age should be calculated from `date_of_birth`.
- Length of stay should be calculated using `discharge_date - admission_date`.
- Billing analysis should join `billing.csv` with `admission.csv`, `department.csv`, and `disease.csv`.
- Clinical analysis should join `admission.csv`, `disease.csv`, `patient_diagnostic.csv`, `diagnostic_test.csv`, `prescription.csv`, and `drug.csv`.

