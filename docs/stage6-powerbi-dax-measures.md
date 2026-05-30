# Stage 6: Power BI DAX Measures

## Purpose

This document lists the DAX measures planned for the Power BI dashboard.

Create these measures after loading data and setting relationships.

## Core Measures

```DAX
Total Admissions = DISTINCTCOUNT(admission[admission_id])
```

```DAX
Total Registered Patients = DISTINCTCOUNT(patient[patient_id])
```

```DAX
Admitted Patients = DISTINCTCOUNT(admission[patient_id])
```

```DAX
Average Length of Stay = AVERAGE(admission[length_of_stay_days])
```

```DAX
Emergency Admissions =
CALCULATE(
    [Total Admissions],
    admission[admission_type] = "Emergency"
)
```

```DAX
Elective Admissions =
CALCULATE(
    [Total Admissions],
    admission[admission_type] = "Elective"
)
```

## Financial Measures

```DAX
Total Revenue = SUM(billing[total_amount])
```

```DAX
Insurance Covered Amount = SUM(billing[insurance_covered_amount])
```

```DAX
Patient Payable Amount = SUM(billing[patient_payable_amount])
```

```DAX
Average Bill Amount = AVERAGE(billing[total_amount])
```

```DAX
Average Insurance Coverage % = AVERAGE(billing[insurance_coverage_percent])
```

```DAX
Paid Amount =
CALCULATE(
    [Total Revenue],
    billing[payment_status] = "Paid"
)
```

```DAX
Pending Amount =
CALCULATE(
    [Total Revenue],
    billing[payment_status] = "Pending"
)
```

```DAX
Insurance Revenue Share % =
DIVIDE(
    [Insurance Covered Amount],
    [Total Revenue],
    0
)
```

```DAX
Patient Payable Share % =
DIVIDE(
    [Patient Payable Amount],
    [Total Revenue],
    0
)
```

## Clinical Measures

```DAX
Total Diagnostic Tests = COUNTROWS(patient_diagnostic)
```

```DAX
Abnormal Diagnostic Results =
CALCULATE(
    [Total Diagnostic Tests],
    patient_diagnostic[result_status] = "Abnormal"
)
```

```DAX
Normal Diagnostic Results =
CALCULATE(
    [Total Diagnostic Tests],
    patient_diagnostic[result_status] = "Normal"
)
```

```DAX
Total Prescriptions = COUNTROWS(prescription)
```

```DAX
Total Diseases = DISTINCTCOUNT(disease[disease_id])
```

## Operations Measures

```DAX
Total Beds = COUNTROWS(bed)
```

```DAX
Occupied Beds =
CALCULATE(
    [Total Beds],
    bed[bed_status] = "Occupied"
)
```

```DAX
Available Beds =
CALCULATE(
    [Total Beds],
    bed[bed_status] = "Available"
)
```

```DAX
Occupied Bed % =
DIVIDE(
    [Occupied Beds],
    [Total Beds],
    0
)
```

## Formatting Notes

After creating measures:

- format revenue measures as currency or whole number
- format percentage measures as percentage
- format average length of stay with 2 decimal places
- format count measures as whole numbers

## Important Notes

- Use `Total Registered Patients` for all patients in the patient master table.
- Use `Admitted Patients` for patients who actually had admissions.
- Use `Total Revenue` from `billing`, not `billing_detail`.
- Use admission month/year for trend visuals.

