# Stage 4: Clinical Dashboard SQL Results

## Purpose

This document will summarize and interpret SQL results from:

```text
sql/04_clinical_dashboard_queries.sql
```

The Clinical Dashboard focuses on:

- disease patterns
- patient demographics
- diagnostic test usage
- diagnostic result status
- prescription patterns
- clinical workload by department

## Results Status

Clinical SQL queries were run in MySQL Workbench.

## Clinical Summary KPIs

| KPI | Value |
|---|---:|
| Total admissions | 45,000 |
| Patients treated | 23,275 |
| Total diseases | 20 |
| Total diagnostic tests | 63,269 |
| Total prescriptions | 73,109 |

## Interpretation: Clinical Summary

The clinical workload is substantial, with 45,000 admissions, 63,269 diagnostic test records, and 73,109 prescriptions.

The `patients treated` count is 23,275 because this query counts distinct patients who appear in admissions, not all 30,000 patients in the patient master table. This is an important distinction:

- `patient` table total = all registered patients
- admitted patients = patients who had at least one admission

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

## Interpretation: Disease Categories

Infectious diseases are the largest clinical category, accounting for 25.00% of admissions.

Surgical, respiratory, cardiac, and pediatric cases also represent major clinical workload areas. Average length of stay is fairly similar across disease categories, mostly around 5.1 to 5.3 days.

## Diagnostic Result Status

| Result Status | Total Results | Result Percent |
|---|---:|---:|
| Abnormal | 31,823 | 50.30% |
| Normal | 31,446 | 49.70% |

## Interpretation: Diagnostic Results

Diagnostic results are almost evenly split between abnormal and normal results.

Abnormal results are slightly higher at 50.30%, which can be highlighted in the Clinical Dashboard as a high-level diagnostic outcome indicator.

## Diagnostic Tests by Department

| Diagnostic Department | Test Category | Total Tests |
|---|---|---:|
| Pathology | Pathology | 35,182 |
| Radiology | Radiology | 28,087 |

## Interpretation: Diagnostic Departments

Pathology has higher diagnostic test volume than Radiology.

This can support a clinical operations insight: laboratory/pathology services may carry a larger diagnostic workload in this dataset.

## Diagnostic Test Usage

| Test Name | Test Category | Total Tests | Standard Cost |
|---|---|---:|---:|
| Complete Blood Count | Pathology | 7,086 | 4,257 |
| Kidney Function Test | Pathology | 7,065 | 4,440 |
| X-Ray Chest | Radiology | 7,064 | 1,328 |
| MRI Spine | Radiology | 7,061 | 3,541 |
| Lipid Profile | Pathology | 7,039 | 2,796 |
| Liver Function Test | Pathology | 7,031 | 924 |
| CT Scan Brain | Radiology | 7,017 | 4,852 |
| Blood Sugar | Pathology | 6,961 | 2,770 |
| Ultrasound Abdomen | Radiology | 6,945 | 1,665 |

## Interpretation: Diagnostic Test Usage

Diagnostic test volumes are fairly evenly distributed across the available tests, with Complete Blood Count and Kidney Function Test having the highest counts.

This supports including a ranked diagnostic test visual in the Clinical Dashboard.

## Top Prescribed Drugs

| Drug Name | Drug Category | Total Prescriptions | Average Duration Days |
|---|---|---:|---:|
| Excepturi | Steroid | 638 | 8.28 |
| Iusto | Antipyretic | 626 | 8.42 |
| Inventore | Analgesic | 622 | 8.41 |
| Fugit | Antacid | 620 | 8.50 |
| Quaerat | Antihypertensive | 613 | 8.65 |
| Iste | Antidiabetic | 612 | 8.25 |
| Deserunt | Analgesic | 609 | 8.69 |
| Nam | Antacid | 597 | 8.56 |
| Dicta | Steroid | 584 | 8.68 |
| Nostrum | Antihypertensive | 583 | 8.42 |

## Interpretation: Prescriptions

The top prescribed drugs are spread across steroid, antipyretic, analgesic, antacid, antihypertensive, and antidiabetic categories.

Average prescription duration is consistently around 8 to 9 days among the top drugs.

Because the drug names are synthetic, the Clinical Dashboard should focus more on drug categories and prescription volume rather than over-interpreting individual drug names.

## Clinical Workload by Department

| Department | Total Admissions | Total Diagnostic Tests | Total Prescriptions | Average Length of Stay |
|---|---:|---:|---:|---:|
| Surgery | 10,126 | 14,272 | 16,563 | 4.63 |
| Emergency | 8,777 | 12,414 | 14,099 | 4.70 |
| Pediatrics | 8,438 | 11,813 | 13,666 | 4.69 |
| Internal Medicine | 7,695 | 10,859 | 12,577 | 4.68 |
| Orthopedics | 5,924 | 8,366 | 9,695 | 4.69 |
| ICU | 4,040 | 5,545 | 6,509 | 9.94 |

## Interpretation: Clinical Workload by Department

Surgery has the highest clinical workload across admissions, diagnostic tests, and prescriptions.

Emergency, Pediatrics, and Internal Medicine also have high diagnostic and prescription activity.

ICU has lower volume but much higher average length of stay, which reinforces the earlier executive finding that ICU requires special capacity and resource monitoring.

## Did We Miss Anything?

The major clinical outputs were captured.

Optional outputs that can still be captured later:

- disease category by gender
- disease category by age group
- top diseases within each age group
- prescription volume by drug category

These are useful for dashboard filters and demographic drill-downs, but they are not blockers for moving forward.

## Clinical Dashboard Recommendations

Recommended visuals:

- KPI cards: total admissions, diagnostic tests, prescriptions, diseases
- bar chart: disease category distribution
- bar chart: top diseases
- donut or bar chart: diagnostic result status
- bar chart: diagnostic tests by test name
- bar chart: diagnostic workload by department
- bar chart: top drug categories or top prescribed drugs
- table: clinical workload by department

## Key Clinical Insights

- Infectious diseases are the largest disease category.
- Diagnostic results are almost evenly split between abnormal and normal.
- Pathology has higher diagnostic test volume than Radiology.
- Surgery has the highest overall clinical workload.
- ICU has lower volume but substantially longer length of stay.
- Synthetic drug names should be interpreted cautiously; drug category analysis is more useful.
