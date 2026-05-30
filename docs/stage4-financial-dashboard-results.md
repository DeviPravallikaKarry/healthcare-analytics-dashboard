# Stage 4: Financial Dashboard SQL Results

## Purpose

This document will summarize and interpret SQL results from:

```text
sql/06_financial_dashboard_queries.sql
```

The Financial Dashboard focuses on:

- total revenue
- insurance-covered amount
- patient-payable amount
- payment status
- payment mode
- revenue by admission month
- revenue by department
- revenue by disease category
- charge-type distribution
- pending billing amount

## Results Status

Financial SQL queries were run in MySQL Workbench and validated against the processed CSV files.

## Important Data Rules

Based on Stage 3 validation:

- Use `billing` as the financial source of truth.
- Use `billing_detail` only for high-level charge-type distribution.
- Do not use `billing_detail` as official revenue.
- Avoid `bill_date` for primary revenue trends.
- Use admission month from `admission` for main revenue trend analysis.

## Outputs to Capture

## Financial Summary KPIs

| KPI | Value |
|---|---:|
| Total bills | 45,000 |
| Total revenue | 1,684,246,109 |
| Insurance-covered amount | 976,880,867 |
| Patient-payable amount | 707,365,242 |
| Average bill amount | 37,427.69 |
| Average insurance coverage percent | 57.96% |

## Interpretation: Financial Summary

The hospital generated total billed revenue of 1.68 billion across 45,000 bills.

Insurance covered 976.88 million, while patient-payable amount was 707.37 million. This shows that insurance is the larger contributor to billed revenue in this dataset.

The average bill amount is 37,427.69.

## Revenue Split

| Revenue Component | Amount | Percent of Total Revenue |
|---|---:|---:|
| Insurance Covered | 976,880,867 | 58% |
| Patient Payable | 707,365,242 | 42% |

## Interpretation: Revenue Split

Insurance contributes 58% of total billed amount, while patient-payable amount contributes 42%.

This is important for a healthcare finance dashboard because it shows the hospital is strongly dependent on insurance-based payments.

## Payment Status Summary

| Payment Status | Total Bills | Total Amount | Amount Percent |
|---|---:|---:|---:|
| Pending | 22,670 | 851,212,656 | 50.54% |
| Paid | 22,330 | 833,033,453 | 49.46% |

## Interpretation: Payment Status

Pending and paid billing amounts are nearly balanced.

Pending bills account for slightly more total amount than paid bills. This can be highlighted as a financial operations concern because pending amounts may affect cash flow and collections.

## Payment Mode Summary

| Payment Mode | Total Bills | Total Amount | Amount Percent |
|---|---:|---:|---:|
| Insurance | 35,979 | 1,347,256,550 | 79.99% |
| UPI | 3,049 | 112,924,124 | 6.70% |
| Card | 3,017 | 112,824,679 | 6.70% |
| Cash | 2,955 | 111,240,756 | 6.60% |

## Interpretation: Payment Mode

Insurance is the dominant payment mode by both count and amount, contributing almost 80% of total billed amount by payment mode.

UPI, card, and cash have similar shares, each around 6.6-6.7%.

## Revenue by Department

| Department | Admissions | Bills | Total Revenue | Average Bill Amount | Insurance Covered | Patient Payable |
|---|---:|---:|---:|---:|---:|---:|
| Surgery | 10,126 | 10,126 | 377,216,234 | 37,252.25 | 220,297,168.9 | 156,919,065.1 |
| Emergency | 8,777 | 8,777 | 329,738,229 | 37,568.44 | 188,238,475.1 | 141,499,753.9 |
| Pediatrics | 8,438 | 8,438 | 315,714,822 | 37,415.84 | 185,715,457.1 | 129,999,364.9 |
| Internal Medicine | 7,695 | 7,695 | 289,566,059 | 37,630.42 | 168,729,861.7 | 120,836,197.3 |
| Orthopedics | 5,924 | 5,924 | 222,585,716 | 37,573.55 | 128,059,789.8 | 94,525,926.2 |
| ICU | 4,040 | 4,040 | 149,425,049 | 36,986.40 | 85,840,114.4 | 63,584,934.6 |

## Interpretation: Revenue by Department

Surgery generates the highest total revenue, followed by Emergency and Pediatrics.

Average bill amount is fairly similar across departments, mostly around 37,000. This means revenue differences are driven more by admission volume than by major differences in average bill amount.

ICU has the lowest total revenue because it has fewer admissions, even though operationally it has a much longer average length of stay.

## Revenue by Disease Category

| Disease Category | Admissions | Total Revenue | Average Bill Amount | Insurance Covered | Patient Payable |
|---|---:|---:|---:|---:|---:|
| Infectious | 11,248 | 419,816,043 | 37,323.62 | 244,307,567.2 | 175,508,475.8 |
| Surgical | 6,711 | 250,300,281 | 37,297.02 | 146,525,561.8 | 103,774,719.2 |
| Cardiac | 4,525 | 170,243,633 | 37,622.90 | 97,119,442.8 | 73,124,190.2 |
| Respiratory | 4,564 | 169,194,174 | 37,071.47 | 97,720,134.8 | 71,474,039.2 |
| Pediatric | 4,436 | 165,602,892 | 37,331.58 | 94,430,330.3 | 71,172,561.7 |
| Orthopedic | 2,288 | 86,777,176 | 37,927.09 | 50,791,173 | 35,986,003 |
| Neurological | 2,300 | 86,402,857 | 37,566.46 | 50,506,596.3 | 35,896,260.7 |
| Trauma | 2,253 | 84,384,780 | 37,454.41 | 48,517,903.5 | 35,866,876.5 |
| Hematological | 2,235 | 84,312,395 | 37,723.67 | 49,859,747.4 | 34,452,647.6 |
| Renal | 2,251 | 83,697,500 | 37,182.36 | 49,249,194.6 | 34,448,305.4 |
| Endocrine | 2,189 | 83,514,378 | 38,151.84 | 47,853,215.3 | 35,661,162.7 |

## Interpretation: Revenue by Disease Category

Infectious diseases generate the highest total revenue because they have the highest admission volume.

Average bill amounts are relatively close across disease categories. Endocrine has the highest average bill amount among listed categories, but total revenue is still lower because admission volume is lower.

## Charge Type Distribution

| Charge Type | Total Line Items | Charge Type Amount | Charge Type Percent |
|---|---:|---:|---:|
| Room | 45,000 | 1,162,571,584 | 78.61% |
| Procedure | 13,575 | 204,517,073 | 13.83% |
| Test | 22,483 | 61,725,515 | 4.17% |
| Drug | 31,344 | 50,066,094 | 3.39% |

## Interpretation: Charge Type Distribution

Room charges dominate billing detail amounts at 78.61%.

Important caution: Stage 3 validation showed billing detail totals do not reconcile exactly with bill-level totals. Therefore, this should be used only as a charge-type mix view, not as the official revenue total.

## Pending Amount by Department

| Department | Pending Bills | Pending Amount |
|---|---:|---:|
| Surgery | 5,135 | 192,233,451 |
| Emergency | 4,409 | 166,456,790 |
| Pediatrics | 4,287 | 161,286,860 |
| Internal Medicine | 3,933 | 148,283,883 |
| Orthopedics | 2,932 | 110,377,323 |
| ICU | 1,974 | 72,574,349 |

## Interpretation: Pending Amount

Surgery has the highest pending amount, followed by Emergency and Pediatrics.

This appears to follow department volume: departments with more admissions and revenue also have larger pending amounts.

For the Financial Dashboard, pending amount by department can help identify where billing follow-up or revenue cycle attention may be needed.

## Insurance Coverage by Department

| Department | Bills | Total Revenue | Insurance Covered | Patient Payable | Average Insurance Coverage Percent |
|---|---:|---:|---:|---:|---:|
| Pediatrics | 8,438 | 315,714,822 | 185,715,457.1 | 129,999,364.9 | 58.75 |
| Internal Medicine | 7,695 | 289,566,059 | 168,729,861.7 | 120,836,197.3 | 58.31 |
| Surgery | 10,126 | 377,216,234 | 220,297,168.9 | 156,919,065.1 | 58.12 |
| Orthopedics | 5,924 | 222,585,716 | 128,059,789.8 | 94,525,926.2 | 57.58 |
| Emergency | 8,777 | 329,738,229 | 188,238,475.1 | 141,499,753.9 | 57.36 |
| ICU | 4,040 | 149,425,049 | 85,840,114.4 | 63,584,934.6 | 57.13 |

## Interpretation: Insurance Coverage by Department

Average insurance coverage percentage is fairly similar across departments, ranging from 57.13% to 58.75%.

Pediatrics has the highest average insurance coverage percentage, while ICU has the lowest.

The small range suggests insurance coverage patterns are relatively consistent across departments in this synthetic dataset.

## Validation Notes

The submitted outputs were validated against the processed CSV files.

The totals match:

- total bills: 45,000
- total revenue: 1,684,246,109
- insurance-covered amount: 976,880,867
- patient-payable amount: 707,365,242

## Financial Dashboard Recommendations

Recommended visuals:

- KPI cards: total revenue, insurance-covered amount, patient-payable amount, average bill amount
- donut/bar chart: revenue split
- bar chart: payment status amount
- bar chart: payment mode amount
- line chart: revenue trend by admission month
- bar chart: revenue by department
- bar chart: revenue by disease category
- bar chart: charge type distribution
- table: pending amount by department
- table: insurance coverage by department

## Key Financial Insights

- Total revenue is 1.68 billion.
- Insurance-covered amount contributes 58% of total billed amount.
- Pending bills represent slightly more total amount than paid bills.
- Insurance is the dominant payment mode.
- Surgery is the highest revenue department.
- Infectious diseases generate the highest revenue by disease category.
- Room charges dominate billing detail charge-type distribution.
- Department revenue differences are mainly driven by admission volume rather than average bill amount.
