# Stage 4: Core KPI Results

## Purpose

This document summarizes the first SQL KPI results from:

```text
sql/02_core_kpis.sql
```

The queries were run in MySQL Workbench using the `hospital_analytics` schema.

## Core KPIs

| KPI | Value |
|---|---:|
| Total patients | 30,000 |
| Total admissions | 45,000 |
| Total departments | 11 |
| Total revenue | 1,684,246,109 |
| Insurance-covered amount | 976,880,867 |
| Patient-payable amount | 707,365,242 |
| Average length of stay | 5.16 days |

## Admission Type Distribution

| Admission Type | Total Admissions | Admission Percent |
|---|---:|---:|
| Elective | 26,923 | 59.83% |
| Emergency | 18,077 | 40.17% |

## Payment Status Distribution

| Payment Status | Total Bills | Total Amount | Bill Percent |
|---|---:|---:|---:|
| Pending | 22,670 | 851,212,656 | 50.38% |
| Paid | 22,330 | 833,033,453 | 49.62% |

## Payment Mode Distribution

| Payment Mode | Total Bills | Total Amount |
|---|---:|---:|
| Insurance | 35,979 | 1,347,256,550 |
| UPI | 3,049 | 112,924,124 |
| Card | 3,017 | 112,824,679 |
| Cash | 2,955 | 111,240,756 |

## Initial Interpretation

The dataset shows a large hospital operation with 45,000 admissions and 30,000 unique patients.

Elective admissions represent the majority of admissions at 59.83%, while emergency admissions represent 40.17%. This suggests that both planned care and urgent care are important operational areas.

The hospital generated total revenue of 1.68 billion in the dataset period. Insurance-covered amount is higher than patient-payable amount, showing that insurance plays a major role in hospital billing.

Payment status is nearly balanced between paid and pending bills. Pending bills account for 50.38% of total bills, which may be important for the Financial Dashboard.

Insurance is the dominant payment mode by total amount, which supports including insurance analytics in the dashboard.

## Dashboard Relevance

These KPIs can be used in:

- Executive Dashboard summary cards
- Financial Dashboard billing overview
- Operations Dashboard admission type analysis
- Revenue and payment status visuals

