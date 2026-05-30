# Stage 4: Executive Dashboard SQL Results

## Purpose

This document summarizes and interprets SQL results from:

```text
sql/03_executive_dashboard_queries.sql
```

These results support the Executive Dashboard page of the healthcare analytics project.

## Admissions by Year

| Admission Year | Total Admissions | Unique Patients | Average Length of Stay |
|---|---:|---:|---:|
| 2025 | 7,595 | 6,721 | 5.15 |
| 2024 | 7,529 | 6,623 | 5.13 |
| 2023 | 7,351 | 6,529 | 5.16 |
| 2022 | 7,517 | 6,667 | 5.13 |
| 2021 | 7,539 | 6,654 | 5.17 |
| 2020 | 7,469 | 6,570 | 5.19 |

## Interpretation: Admissions by Year

Admissions are stable across the six-year period, ranging from 7,351 to 7,595 admissions per year.

This suggests the synthetic hospital dataset represents a consistently operating hospital rather than one with sharp annual growth or decline.

Average length of stay is also stable, staying close to 5.1 days every year. This consistency is useful for executive monitoring because major changes in length of stay would usually require operational investigation.

## Monthly Admissions Sample

| Admission Month | Total Admissions | Unique Patients | Average Length of Stay |
|---|---:|---:|---:|
| 2020-01 | 629 | 622 | 5.25 |
| 2020-02 | 611 | 607 | 5.36 |
| 2020-03 | 633 | 624 | 5.04 |

## Interpretation: Monthly Admissions

The sample monthly results show steady monthly admission volume at around 600 admissions per month.

For the Power BI dashboard, monthly admission trends can be shown using a line chart. This will help users quickly identify seasonal variation or unusual changes in patient volume.

## Department Performance Overview

| Department | Type | Total Admissions | Unique Patients | Average Length of Stay | Total Revenue |
|---|---|---:|---:|---:|---:|
| Surgery | Clinical | 10,126 | 8,594 | 4.67 | 377,216,234 |
| Emergency | Clinical | 8,777 | 7,578 | 4.69 | 329,738,229 |
| Pediatrics | Clinical | 8,438 | 7,388 | 4.69 | 315,714,822 |
| Internal Medicine | Clinical | 7,695 | 6,737 | 4.66 | 289,566,059 |
| Orthopedics | Clinical | 5,924 | 5,344 | 4.68 | 222,585,716 |
| ICU | Clinical | 4,040 | 3,759 | 9.98 | 149,425,049 |

## Interpretation: Department Performance

Surgery has the highest admission volume and highest revenue, making it a major contributor to hospital workload and financial performance.

Emergency, Pediatrics, and Internal Medicine also show high admission volumes, indicating strong operational demand across acute, pediatric, and general medical care.

ICU has the lowest admission volume among the listed departments but has the highest average length of stay at 9.98 days. This is an important operational insight because ICU patients typically require longer stays, higher resource intensity, and closer capacity monitoring.

For the Executive Dashboard, department performance should be shown using:

- bar chart for admissions by department
- bar chart or ranked table for revenue by department
- length of stay comparison by department

## Disease Category Distribution

| Disease Category | Total Admissions | Admission Percent | Average Length of Stay |
|---|---:|---:|---:|
| Infectious | 11,248 | 25.00% | 5.16 |
| Surgical | 6,711 | 14.91% | 5.14 |
| Respiratory | 4,564 | 10.14% | 5.11 |
| Cardiac | 4,525 | 10.06% | 5.17 |
| Pediatric | 4,436 | 9.86% | 5.15 |
| Neurological | 2,300 | 5.11% | 5.07 |
| Orthopedic | 2,288 | 5.08% | 5.19 |
| Trauma | 2,253 | 5.01% | 5.27 |
| Renal | 2,251 | 5.00% | 5.26 |
| Hematological | 2,235 | 4.97% | 5.07 |
| Endocrine | 2,189 | 4.86% | 5.19 |

## Interpretation: Disease Category Distribution

Infectious diseases account for the highest share of admissions at 25.00%.

This is highly relevant for healthcare analytics in India, where infectious disease burden, seasonal outbreaks, and hospital infection-related workload can be important operational topics.

Surgical, respiratory, cardiac, and pediatric categories also represent major workload areas. These disease categories should be highlighted in the Clinical Dashboard and summarized in the Executive Dashboard.

## Top 10 Diseases by Admissions

| Disease | Disease Category | Total Admissions | Average Length of Stay |
|---|---|---:|---:|
| Stroke | Neurological | 2,300 | 5.07 |
| Sepsis | Infectious | 2,297 | 5.17 |
| Chronic Obstructive Pulmonary Disease | Respiratory | 2,289 | 5.14 |
| Fracture Femur | Orthopedic | 2,288 | 5.19 |
| Acute Myocardial Infarction | Cardiac | 2,282 | 5.23 |
| Acute Respiratory Distress | Respiratory | 2,275 | 5.08 |
| Gallstones | Surgical | 2,271 | 5.14 |
| Urinary Tract Infection | Infectious | 2,259 | 5.19 |
| Tuberculosis | Infectious | 2,256 | 5.12 |
| Road Traffic Accident | Trauma | 2,253 | 5.27 |

## Interpretation: Top Diseases

The top diseases are distributed across neurological, infectious, respiratory, orthopedic, cardiac, surgical, and trauma categories.

Sepsis, urinary tract infection, and tuberculosis appearing in the top 10 supports the finding that infectious diseases are a major workload driver in this dataset.

Stroke and acute myocardial infarction represent high-priority clinical conditions that can be useful for executive and clinical monitoring.

Road traffic accident and fracture femur indicate trauma and orthopedic workload, which may be relevant for emergency and surgical capacity planning.

## Executive Dashboard Recommendations

Recommended visuals:

- KPI cards: total admissions, total patients, total revenue, average length of stay
- line chart: admissions by month
- line chart: revenue by admission month
- bar chart: admissions by department
- bar chart: revenue by department
- bar chart: disease category distribution
- ranked table: top 10 diseases
- department table: admissions, revenue, and length of stay

## Key Executive Insights

- Admission volume is stable across 2020-2025.
- Average length of stay is stable around 5.1 days.
- Surgery is the highest-volume and highest-revenue department.
- ICU has lower admission volume but much longer average length of stay.
- Infectious diseases are the largest disease category, contributing 25.00% of admissions.
- Payment and insurance analytics should remain part of executive monitoring because insurance contributes the majority of billed amount.

