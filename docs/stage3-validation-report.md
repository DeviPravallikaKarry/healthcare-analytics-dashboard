# Stage 3: Data Cleaning and Validation Report

## Purpose

This report summarizes the validation checks performed after running the Stage 3 cleaning notebook:

```text
notebooks/02_data_cleaning_preprocessing.ipynb
```

The goal is to confirm whether the processed data is ready for SQL analysis, Python EDA, and Power BI dashboard development.

## Processed Data Location

Processed files were saved in:

```text
data/processed/
```

All 19 processed CSV files were created successfully.

## Cleaning Steps Completed

The Stage 3 notebook completed the following steps:

- loaded all raw CSV files
- stripped leading/trailing spaces from text columns
- converted date columns into datetime format
- created `patient_age`
- created `age_group`
- created `length_of_stay_days`
- created admission month/year fields
- created billing month/year fields
- created `insurance_coverage_percent`
- created `billing_amount_matches`
- created `reference_id_missing` in `billing_detail`
- saved processed CSV files

## Duplicate Check

No duplicate rows were found in any processed table.

## Primary Key Check

All primary keys are unique and complete.

No missing or duplicate primary key values were found.

## Foreign Key Check

No basic foreign key mismatches were found.

Examples:

- every admission links to a valid patient
- every admission links to a valid department
- every billing record links to a valid admission
- every prescription links to a valid drug
- every diagnostic record links to a valid admission, test, and doctor

## Date Conversion Check

No date conversion failures were found.

All planned date columns converted successfully:

- `patient.date_of_birth`
- `admission.admission_date`
- `admission.discharge_date`
- `billing.bill_date`
- `patient_diagnostic.test_date`
- `drug_inventory.last_restock_date`
- `patient_insurance.policy_start_date`
- `patient_insurance.policy_end_date`
- `employee.date_of_joining`

## Length of Stay Check

| Metric | Value |
|---|---:|
| Total admissions | 45,000 |
| Negative length of stay | 0 |
| Zero-day stays | 0 |
| Average length of stay | 5.16 days |
| Maximum length of stay | 15 days |

Interpretation:

Length of stay values look reasonable for this synthetic hospital dataset.

## Patient Age Check

| Metric | Value |
|---|---:|
| Minimum age | 0 |
| Average age | 44.57 |
| 95th percentile age | 86 |
| Maximum age | 90 |
| Age below 0 | 0 |
| Age above 100 | 0 |

Age values are reasonable. No impossible age values were found.

### Age Group Distribution

| Age Group | Count |
|---|---:|
| Child | 4,443 |
| Teen | 2,314 |
| Young Adult | 4,980 |
| Adult | 6,513 |
| Senior | 4,957 |
| Elderly | 6,793 |

## Billing Amount Validation

| Check | Result |
|---|---:|
| Negative total amount | 0 |
| Negative insurance-covered amount | 0 |
| Negative patient payable amount | 0 |
| Insurance amount greater than total | 0 |
| Billing amount mismatch | 0 |
| Coverage percent outside 0-100 | 0 |

Interpretation:

The main `billing` table is internally consistent. It is safe to use `billing.total_amount`, `billing.insurance_covered_amount`, and `billing.patient_payable_amount` for financial KPIs.

## Billing Outlier Review

The billing data has some statistically high values based on the IQR method:

| Column | IQR Outlier Count |
|---|---:|
| total_amount | 429 |
| insurance_covered_amount | 446 |
| patient_payable_amount | 2,856 |
| insurance_coverage_percent | 9,021 |

Interpretation:

These are statistical outliers, not automatically errors. In healthcare billing, high-cost admissions and large patient-payable bills can be realistic.

For this project, these values should be kept unless a clear business rule says they are invalid.

## Important Billing Date Issue

Many billing dates occur before the related admission or discharge date.

| Check | Count |
|---|---:|
| Bill date before admission date | 22,407 |
| Bill date before discharge date | 22,493 |

Interpretation:

This is an important synthetic-data limitation.

For financial dashboard trends, avoid relying only on `bill_date` as the true revenue recognition date. A safer approach is to analyze revenue by the related admission date or discharge date after joining `billing` with `admission`.

Recommended handling:

- Keep `bill_date` as a raw field.
- Use `admission_date` or `discharge_date` for main revenue trend analysis.
- Clearly document this limitation in the project.

## Billing Detail Reference ID Review

The missing `reference_id` values are fully linked to specific charge types.

| Charge Type | Total Records | Missing Reference ID | Missing Percent |
|---|---:|---:|---:|
| Drug | 31,344 | 31,344 | 100% |
| Procedure | 13,575 | 13,575 | 100% |
| Test | 22,483 | 22,483 | 100% |
| Room | 45,000 | 0 | 0% |

Interpretation:

The missing `reference_id` pattern is systematic, not random.

Because all Drug, Procedure, and Test rows have missing `reference_id`, this column cannot currently be used to connect billing detail rows back to specific drugs, procedures, or tests.

Recommended handling:

- Use `billing_detail` for charge-type-level analysis.
- Do not use `reference_id` for detailed item-level joins unless the dataset documentation clarifies its meaning.

## Billing Detail Reconciliation Issue

The sum of billing detail line amounts does not usually match the bill-level total.

| Check | Count |
|---|---:|
| Bills without detail rows | 0 |
| Bills where detail sum does not match `billing.total_amount` | 44,998 |

Interpretation:

This is a major limitation for line-level financial reconciliation.

Recommended handling:

- Use `billing.csv` for official revenue KPIs.
- Use `billing_detail.csv` only for approximate charge-type distribution.
- Do not present billing detail totals as exact audited revenue.

## Admission Ward, Bed, and Department Consistency

All checks passed:

- admission department matches ward department
- admission ward matches bed ward
- admission department matches bed department through ward

Interpretation:

The operational structure for departments, wards, and beds is reliable.

## Diagnostic Test Department Check

All diagnostic test department IDs differ from the admission department IDs.

| Check | Count |
|---|---:|
| Diagnostic test department differs from admission department | 63,269 |

Interpretation:

This may not be a true error. Diagnostic tests are often owned by supporting departments such as laboratory or radiology, while the patient is admitted under a clinical department.

Recommended handling:

- Do not treat this as a cleaning error.
- Interpret `diagnostic_test.department_id` as the department responsible for the test.
- Use admission department for patient workload.
- Use test department for diagnostic service workload.

## Staff Assignment Department Check

| Check | Count |
|---|---:|
| Staff assignment department differs from ward department | 186 of 207 |

Interpretation:

This may reflect cross-department staffing or a synthetic-data limitation.

Recommended handling:

- Use `staff_assignment` for shift and ward assignment analysis.
- Avoid assuming employee home department always matches assigned ward department.
- Document this if using staff workload visuals.

## Insurance Policy Date Check

Many admissions do not have an active insurance policy on the admission date.

| Check | Count |
|---|---:|
| Admissions without active policy on admission date | 34,179 of 45,000 |
| Insurance payment mode without active policy on admission date | 27,283 |

Interpretation:

This is likely a synthetic-data limitation or incomplete policy-period logic.

Recommended handling:

- Use billing columns for insurance-covered amount and patient-payable amount.
- Do not use policy dates to determine whether insurance should have applied unless this limitation is explained.

## Inventory Check

| Check | Count |
|---|---:|
| Negative current stock | 0 |
| Negative reorder level | 0 |
| Drugs below reorder level | 44 |

Interpretation:

The 44 drugs below reorder level are not a data quality issue. They are useful for pharmacy inventory analysis.

## Categorical Value Check

Important categorical fields are clean and readable:

- gender: Female, Male, Other
- admission type: Elective, Emergency
- admission status: Discharged
- payment status: Paid, Pending
- payment mode: Card, Cash, Insurance, UPI
- bed status: Available, Occupied
- diagnostic result status: Abnormal, Normal
- inventory status: Low, Normal
- department status: Active

## Stage 3 Conclusion

The processed dataset is usable for analytics and dashboarding, but several limitations must be handled carefully.

### Safe to Use Directly

- patient demographics
- admission counts and trends
- department workload
- ward and bed structure
- length of stay
- disease patterns
- prescription counts
- diagnostic result counts
- main billing table financial KPIs
- inventory reorder analysis

### Use With Caution

- `billing.bill_date` for revenue trends
- `billing_detail.reference_id`
- billing detail totals as exact bill reconciliation
- insurance policy dates for coverage validation
- employee department vs ward assignment assumptions

### Recommended for Main Dashboard

Use `billing.csv` as the source of truth for financial KPIs.

Use `admission.csv` as the central table for operational, clinical, and patient analytics.

Use `billing_detail.csv` only for high-level charge-type distribution unless more documentation is available.

