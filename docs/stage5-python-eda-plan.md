# Stage 5: Python Exploratory Data Analysis Plan

## Purpose

Stage 5 uses Python to visually explore the processed HMIS dataset before creating the Power BI dashboard.

The goal is to identify patterns, trends, and relationships that can guide dashboard design.

## Notebook

```text
notebooks/03_python_eda.ipynb
```

## Data Source

The notebook uses processed CSV files from:

```text
data/processed/
```

## Visual Outputs

Charts are saved to:

```text
visuals/
```

## Planned EDA Areas

| Area | Questions |
|---|---|
| Admissions trend | Are admissions stable or changing over time? |
| Department workload | Which departments handle the most admissions? |
| Length of stay | Which departments have longer stays? |
| Disease patterns | Which disease categories are most common? |
| Demographics | Which age groups are most represented? |
| Revenue | Which departments generate the highest revenue? |
| Insurance | How much is covered by insurance vs paid by patients? |
| Billing status | How important are pending bills? |
| Diagnostics | What is the normal vs abnormal result split? |

## Important Data Rules

Based on earlier validation:

- Use `admission` as the central table for operational and clinical analysis.
- Use `billing` as the financial source of truth.
- Do not use `billing_detail` as official revenue.
- Avoid `bill_date` for primary revenue trends.
- Use admission-based month/year fields for trends.

## Expected Output

Stage 5 should produce:

- a completed EDA notebook
- saved chart images
- a short EDA findings document
- clear recommendations for Power BI dashboard design

## Stage 5 Status

Stage 5 is complete.
