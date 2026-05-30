# Stage 4: Operations Dashboard SQL Results

## Purpose

This document will summarize and interpret SQL results from:

```text
sql/05_operations_dashboard_queries.sql
```

The Operations Dashboard focuses on:

- hospital workload
- department admissions
- admission type distribution
- length of stay
- ward and bed capacity
- staff distribution
- operational bottlenecks

## Results Status

Operations SQL queries were run in MySQL Workbench and validated against the processed CSV files.

## Operations Summary KPIs

| KPI | Value |
|---|---:|
| Total admissions | 45,000 |
| Departments with admissions | 6 |
| Wards used | 27 |
| Beds used in admission history | 145 |
| Average length of stay | 5.16 days |
| Emergency admissions | 18,077 |
| Elective admissions | 26,923 |

## Interpretation: Operations Summary

The hospital dataset includes 45,000 admissions across 6 admitting departments and 27 wards.

Elective admissions are higher than emergency admissions, which is consistent with earlier KPI results.

Important note: `beds_used` means distinct bed IDs found in the admission table. It is not the same as current occupied beds from the bed master table.

## Department Workload

| Department | Type | Total Admissions | Unique Patients | Average Length of Stay |
|---|---|---:|---:|---:|
| Surgery | Clinical | 10,126 | 8,594 | 4.67 |
| Emergency | Clinical | 8,777 | 7,578 | 4.69 |
| Pediatrics | Clinical | 8,438 | 7,388 | 4.69 |
| Internal Medicine | Clinical | 7,695 | 6,737 | 4.66 |
| Orthopedics | Clinical | 5,924 | 5,344 | 4.68 |
| ICU | Clinical | 4,040 | 3,759 | 9.98 |

## Interpretation: Department Workload

Surgery has the highest admission workload, followed by Emergency, Pediatrics, and Internal Medicine.

ICU has the lowest admission count among these departments, but its average length of stay is much higher, indicating greater bed-days and resource intensity per admission.

## Admission Type by Department

| Department | Admission Type | Total Admissions | Department Percent |
|---|---|---:|---:|
| Emergency | Elective | 5,299 | 60.37% |
| Emergency | Emergency | 3,478 | 39.63% |
| ICU | Elective | 2,475 | 61.26% |
| ICU | Emergency | 1,565 | 38.74% |
| Internal Medicine | Elective | 4,575 | 59.45% |
| Internal Medicine | Emergency | 3,120 | 40.55% |
| Orthopedics | Elective | 3,506 | 59.18% |
| Orthopedics | Emergency | 2,418 | 40.82% |
| Pediatrics | Elective | 5,084 | 60.25% |
| Pediatrics | Emergency | 3,354 | 39.75% |
| Surgery | Elective | 5,984 | 59.10% |
| Surgery | Emergency | 4,142 | 40.90% |

## Interpretation: Admission Type by Department

Each department has a similar admission type pattern, with elective admissions around 59-61% and emergency admissions around 39-41%.

This suggests a balanced synthetic distribution across departments rather than department-specific emergency concentration.

## Length of Stay by Department

| Department | Total Admissions | Average Length of Stay | Minimum LOS | Maximum LOS |
|---|---:|---:|---:|---:|
| ICU | 4,040 | 9.98 | 5 | 15 |
| Emergency | 8,777 | 4.69 | 1 | 10 |
| Pediatrics | 8,438 | 4.69 | 1 | 10 |
| Orthopedics | 5,924 | 4.68 | 1 | 10 |
| Surgery | 10,126 | 4.67 | 1 | 10 |
| Internal Medicine | 7,695 | 4.66 | 1 | 10 |

## Interpretation: Length of Stay

ICU is clearly different from other departments. Its average length of stay is 9.98 days, compared with around 4.66-4.69 days for other departments.

This should be highlighted in the Operations Dashboard because longer stays affect bed availability, staffing, and capacity planning.

## Ward Workload and Capacity

The ward workload query calculates cumulative admissions per bed over the dataset period.

Top examples:

| Department | Ward | Ward Type | Total Beds | Total Admissions | Admissions per Bed |
|---|---|---|---:|---:|---:|
| Pediatrics | Pediatrics Ward 4 | Semi-Private | 10 | 1,266 | 126.60 |
| Emergency | Emergency Ward 1 | General | 10 | 1,265 | 126.50 |
| Surgery | Surgery Ward 4 | Private | 15 | 1,895 | 126.33 |
| Pediatrics | Pediatrics Ward 3 | Semi-Private | 15 | 1,881 | 125.40 |
| Internal Medicine | Internal Medicine Ward 2 | Private | 15 | 1,873 | 124.87 |

## Interpretation: Ward Workload

Admissions per bed is a cumulative workload metric, not a real-time occupancy percentage.

High admissions per bed means the ward had high patient turnover over the multi-year dataset period.

ICU wards show lower admissions per bed but much longer length of stay, so ICU workload should be interpreted using both volume and length of stay.

## Bed Status Distribution

| Bed Status | Total Beds | Bed Percent |
|---|---:|---:|
| Occupied | 270 | 65.06% |
| Available | 145 | 34.94% |

## Bed Status by Ward Type

| Ward Type | Bed Status | Total Beds |
|---|---|---:|
| General | Occupied | 138 |
| General | Available | 82 |
| ICU | Occupied | 52 |
| ICU | Available | 13 |
| Private | Occupied | 46 |
| Private | Available | 29 |
| Semi-Private | Occupied | 34 |
| Semi-Private | Available | 21 |

## Interpretation: Bed Status

The bed master table shows that 65.06% of beds are currently marked as occupied.

General wards have the largest number of occupied beds. ICU has fewer total beds, but a high share of occupied ICU beds may be operationally important because ICU capacity is usually limited and high intensity.

## Staff Count by Role

| Role | Total Staff |
|---|---:|
| Nurse | 109 |
| Pharmacist | 101 |
| Doctor | 98 |
| Technician | 98 |
| Admin | 94 |

## Interpretation: Staff Count

Nurses are the largest staff group, followed by pharmacists, doctors, technicians, and admin staff.

This supports a staffing overview section in the Operations Dashboard.

## Doctor Count by Specialization

| Specialization | Total Doctors | Average Experience Years |
|---|---:|---:|
| Neurology | 14 | 18.50 |
| General Medicine | 13 | 20.92 |
| Cardiology | 12 | 20.08 |
| ICU | 12 | 16.42 |
| Orthopedics | 11 | 14.36 |
| Pulmonology | 11 | 18.09 |
| Pediatrics | 10 | 12.10 |
| Nephrology | 9 | 18.22 |
| Surgery | 6 | 16.17 |

## Interpretation: Doctor Specialization

Neurology has the highest doctor count, while Surgery has the lowest doctor count among listed specializations.

This can be used in a staffing view, but it should not be over-interpreted without knowing actual doctor schedules, patient acuity, or case complexity.

## Potential Operational Bottleneck View

| Department | Total Admissions | Beds Used | Admissions per Bed Used | Average Length of Stay |
|---|---:|---:|---:|---:|
| Emergency | 8,777 | 28 | 313.46 | 4.69 |
| Pediatrics | 8,438 | 27 | 312.52 | 4.69 |
| Orthopedics | 5,924 | 19 | 311.79 | 4.68 |
| ICU | 4,040 | 13 | 310.77 | 9.98 |
| Internal Medicine | 7,695 | 25 | 307.80 | 4.66 |
| Surgery | 10,126 | 33 | 306.85 | 4.67 |

## Interpretation: Operational Bottlenecks

Emergency, Pediatrics, and Orthopedics have the highest admissions per bed used, indicating high cumulative patient turnover.

ICU has slightly lower admissions per bed used but much higher length of stay. This makes ICU a capacity-sensitive department even with lower admission volume.

For dashboard interpretation:

- admissions per bed used = cumulative throughput indicator
- length of stay = resource duration indicator
- bed status = current bed availability indicator

These should be shown together instead of treated as one single occupancy metric.

## Validation Notes

The submitted outputs were validated against the processed CSV files.

Important distinction:

- `beds_used = 145` comes from distinct `bed_id` values in admission history.
- `Occupied = 270` comes from current `bed_status` in the bed master table.

These two values answer different questions and should not be compared directly.

## Operations Dashboard Recommendations

Recommended visuals:

- KPI cards: total admissions, average length of stay, emergency admissions, elective admissions
- bar chart: department workload
- stacked bar chart: admission type by department
- bar chart: length of stay by department
- table or bar chart: ward workload and admissions per bed
- donut/bar chart: bed status distribution
- bar chart: staff count by role
- bar chart: doctor count by specialization
- bottleneck table: admissions per bed used and length of stay by department

## Key Operations Insights

- Surgery has the highest admission workload.
- ICU has the longest average length of stay.
- Elective admissions are higher than emergency admissions across all departments.
- Current bed status shows 65.06% occupied beds.
- Emergency, Pediatrics, and Orthopedics show high cumulative admissions per bed used.
- ICU requires careful monitoring because long length of stay can create capacity pressure even with fewer admissions.
