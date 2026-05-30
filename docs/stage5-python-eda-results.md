# Stage 5: Python EDA Results

## Purpose

This document summarizes the findings from:

```text
notebooks/03_python_eda.ipynb
```

The notebook uses processed CSV files from:

```text
data/processed/
```

Charts were saved in:

```text
visuals/
```

## Notebook Execution Status

The notebook was executed successfully.

All 15 code cells were run, and 9 chart images were saved.

## Visuals Created

| Visual File | Purpose |
|---|---|
| `admissions_trend_by_year.png` | Yearly admission trend |
| `admissions_by_department.png` | Department workload |
| `average_los_by_department.png` | Length of stay by department |
| `admissions_by_disease_category.png` | Disease category distribution |
| `patients_by_age_group.png` | Patient age group distribution |
| `revenue_by_department.png` | Revenue by department |
| `insurance_vs_patient_payable.png` | Insurance vs patient payable amount |
| `billing_amount_by_payment_status.png` | Paid vs pending billing amount |
| `diagnostic_result_status.png` | Normal vs abnormal diagnostic results |

## Core Dataset Snapshot

| Metric | Value |
|---|---:|
| Total registered patients | 30,000 |
| Total admissions | 45,000 |
| Admitted patients | 23,275 |
| Total revenue | 1,684,246,109 |
| Average length of stay | 5.16 days |
| Total diagnostic tests | 63,269 |
| Total prescriptions | 73,109 |

## Admissions Trend by Year

| Year | Total Admissions |
|---|---:|
| 2020 | 7,469 |
| 2021 | 7,539 |
| 2022 | 7,517 |
| 2023 | 7,351 |
| 2024 | 7,529 |
| 2025 | 7,595 |

### Interpretation

Admissions are stable across 2020-2025, with no major increase or decrease.

This confirms the SQL finding that the dataset represents a consistently operating hospital.

## Department Workload

| Department | Total Admissions |
|---|---:|
| Surgery | 10,126 |
| Emergency | 8,777 |
| Pediatrics | 8,438 |
| Internal Medicine | 7,695 |
| Orthopedics | 5,924 |
| ICU | 4,040 |

### Interpretation

Surgery has the highest admission workload, followed by Emergency and Pediatrics.

This supports using department workload as a major visual in the Executive and Operations dashboards.

## Average Length of Stay by Department

| Department | Average Length of Stay |
|---|---:|
| ICU | 9.98 |
| Emergency | 4.69 |
| Pediatrics | 4.69 |
| Orthopedics | 4.68 |
| Surgery | 4.67 |
| Internal Medicine | 4.66 |

### Interpretation

ICU is clearly different from all other departments, with almost double the average length of stay.

This is one of the strongest operational insights in the project.

## Disease Category Distribution

| Disease Category | Total Admissions |
|---|---:|
| Infectious | 11,248 |
| Surgical | 6,711 |
| Respiratory | 4,564 |
| Cardiac | 4,525 |
| Pediatric | 4,436 |
| Neurological | 2,300 |
| Orthopedic | 2,288 |
| Trauma | 2,253 |
| Renal | 2,251 |
| Hematological | 2,235 |
| Endocrine | 2,189 |

### Interpretation

Infectious diseases are the largest disease category.

This is clinically relevant and useful for the Clinical Dashboard.

## Patient Age Group Distribution

| Age Group | Patient Count |
|---|---:|
| Child | 4,443 |
| Teen | 2,314 |
| Young Adult | 4,980 |
| Adult | 6,513 |
| Senior | 4,957 |
| Elderly | 6,793 |

### Interpretation

Elderly patients form the largest age group, followed by adults.

This can support demographic filters and patient population visuals in Power BI.

## Revenue by Department

| Department | Total Revenue |
|---|---:|
| Surgery | 377,216,234 |
| Emergency | 329,738,229 |
| Pediatrics | 315,714,822 |
| Internal Medicine | 289,566,059 |
| Orthopedics | 222,585,716 |
| ICU | 149,425,049 |

### Interpretation

Surgery generates the highest revenue, mainly because it has the highest admission volume.

This confirms the SQL financial analysis.

## Insurance vs Patient Payable Amount

| Component | Amount |
|---|---:|
| Insurance Covered | 976,880,867 |
| Patient Payable | 707,365,242 |

### Interpretation

Insurance-covered amount is higher than patient-payable amount.

Insurance is a major financial contributor in this dataset.

## Payment Status Distribution

| Payment Status | Total Amount | Total Bills |
|---|---:|---:|
| Pending | 851,212,656 | 22,670 |
| Paid | 833,033,453 | 22,330 |

### Interpretation

Pending billing amount is slightly higher than paid billing amount.

This should be highlighted in the Financial Dashboard because it may indicate revenue cycle follow-up needs.

## Diagnostic Result Status

| Result Status | Total Results |
|---|---:|
| Abnormal | 31,823 |
| Normal | 31,446 |

### Interpretation

Diagnostic results are almost evenly split between abnormal and normal, with abnormal results slightly higher.

This supports a Clinical Dashboard visual for diagnostic result distribution.

## Stage 5 Conclusion

Python EDA confirms the same major patterns found in SQL:

- admissions are stable across years
- Surgery has the highest workload and revenue
- ICU has the highest length of stay
- Infectious diseases are the largest disease category
- Elderly patients are the largest age group
- insurance-covered amount is higher than patient-payable amount
- pending billing amount is slightly higher than paid amount
- abnormal diagnostic results are slightly higher than normal results

These findings will guide the Power BI dashboard design.

