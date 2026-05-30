# Stage 2: Dashboard Question Plan

## Purpose

This document converts the dataset understanding work into practical dashboard questions.

The goal is to define what the dashboard should answer before starting data cleaning, SQL analysis, Python EDA, or Power BI development.

## Dashboard Structure

The project dashboard will be divided into four pages:

1. Executive Dashboard
2. Clinical Dashboard
3. Operations Dashboard
4. Financial Dashboard

## 1. Executive Dashboard

### Goal

Provide hospital leadership with a high-level view of hospital performance.

### Key Questions

- How many total admissions occurred?
- How many unique patients were treated?
- How has admission volume changed over time?
- Which departments handled the highest patient volume?
- What is the total hospital revenue?
- How does revenue change by year and month?
- What is the average length of stay?
- Which disease categories are most common?

### Suggested KPIs

- Total admissions
- Total unique patients
- Total revenue
- Average length of stay
- Total departments
- Top 5 departments by admissions
- Top 5 disease categories

### Main Tables Needed

- `admission`
- `patient`
- `department`
- `disease`
- `billing`

## 2. Clinical Dashboard

### Goal

Help clinical stakeholders understand patient and disease patterns.

### Key Questions

- What are the most common diseases?
- Which disease categories have the highest admission volume?
- How do disease patterns vary by gender and age group?
- Which diagnostic tests are used most frequently?
- What percentage of test results are normal, abnormal, or pending?
- Which medications are prescribed most often?
- Which departments see the highest clinical workload?

### Suggested KPIs

- Total diagnoses/admissions
- Top diseases
- Top disease categories
- Diagnostic test count
- Abnormal result count
- Prescription count
- Top prescribed drugs

### Main Tables Needed

- `admission`
- `patient`
- `disease`
- `patient_diagnostic`
- `diagnostic_test`
- `prescription`
- `drug`
- `department`

## 3. Operations Dashboard

### Goal

Help hospital operations teams monitor workload, capacity, and patient flow.

### Key Questions

- How many admissions occur by department?
- How many admissions are emergency vs elective?
- What is the average length of stay by department?
- Which wards handle the most admissions?
- What is the bed status distribution?
- Which departments or wards may have high workload?
- How are staff assigned across wards and shifts?
- How many doctors are available by specialization?

### Suggested KPIs

- Total admissions
- Emergency admissions
- Elective admissions
- Average length of stay
- Ward count
- Total beds
- Occupied beds
- Available beds
- Staff count by role
- Doctor count by specialization

### Main Tables Needed

- `admission`
- `department`
- `ward`
- `bed`
- `employee`
- `doctor`
- `staff_assignment`

## 4. Financial Dashboard

### Goal

Help finance and billing stakeholders understand revenue, payment, and insurance patterns.

### Key Questions

- What is the total billed amount?
- How much was covered by insurance?
- How much is payable by patients?
- What percentage of bills are paid vs pending?
- Which departments generate the most revenue?
- Which disease categories are associated with higher billing?
- What are the major charge types in billing details?
- Which insurance providers cover the highest amount?

### Suggested KPIs

- Total billed amount
- Insurance-covered amount
- Patient payable amount
- Paid bills
- Pending bills
- Revenue by department
- Revenue by disease category
- Revenue by payment mode
- Top insurance providers

### Main Tables Needed

- `billing`
- `billing_detail`
- `admission`
- `department`
- `disease`
- `patient_insurance`
- `insurance_provider`

## Important Derived Fields Needed Later

These fields do not currently exist directly in the raw data. We will create them during Stage 3 cleaning and preprocessing.

| Derived Field | Source Columns | Why It Is Needed |
|---|---|---|
| patient_age | `patient.date_of_birth` | Age-based patient analysis |
| age_group | `patient_age` | Dashboard-friendly age segments |
| length_of_stay_days | `admission_date`, `discharge_date` | Operations KPI |
| admission_year | `admission_date` | Trend analysis |
| admission_month | `admission_date` | Monthly trend analysis |
| bill_year | `bill_date` | Revenue trend analysis |
| bill_month | `bill_date` | Monthly financial trend |
| insurance_coverage_percent | `insurance_covered_amount`, `total_amount` | Insurance analytics |

## Stage 2 Conclusion

The dataset supports all four planned dashboard pages.

The next stage should prepare clean, analysis-ready fields so these questions can be answered using SQL, Python, and Power BI.

