-- ============================================================
-- 03_executive_dashboard_queries.sql
-- Project: AI-Assisted Hospital Operations & Patient Analytics
-- Purpose: SQL queries for Executive Dashboard metrics
-- Database: hospital_analytics
-- ============================================================

USE hospital_analytics;

-- Important:
-- Stage 3 validation showed that billing.bill_date is unreliable for
-- revenue trend analysis because many bill dates occur before admission.
-- For executive trend analysis, this file uses admission dates.

-- ------------------------------------------------------------
-- Query 1: Executive summary KPI cards
-- Business use:
-- High-level summary cards for hospital leadership.
-- ------------------------------------------------------------
SELECT
    COUNT(DISTINCT a.admission_id) AS total_admissions,
    COUNT(DISTINCT a.patient_id) AS total_patients_treated,
    COUNT(DISTINCT a.department_id) AS departments_with_admissions,
    ROUND(AVG(a.length_of_stay_days), 2) AS average_length_of_stay_days,
    ROUND(SUM(b.total_amount), 2) AS total_revenue,
    ROUND(SUM(b.insurance_covered_amount), 2) AS insurance_covered_amount,
    ROUND(SUM(b.patient_payable_amount), 2) AS patient_payable_amount
FROM admission a
LEFT JOIN billing b
    ON a.admission_id = b.admission_id;

-- ------------------------------------------------------------
-- Query 2: Admissions trend by year
-- Business use:
-- Shows hospital patient volume growth or decline over time.
-- ------------------------------------------------------------
SELECT
    admission_year,
    COUNT(*) AS total_admissions,
    COUNT(DISTINCT patient_id) AS unique_patients,
    ROUND(AVG(length_of_stay_days), 2) AS average_length_of_stay_days
FROM admission
GROUP BY admission_year
ORDER BY admission_year;

-- ------------------------------------------------------------
-- Query 3: Admissions trend by month
-- Business use:
-- Supports monthly admission trend line chart.
-- ------------------------------------------------------------
SELECT
    admission_year_month,
    COUNT(*) AS total_admissions,
    COUNT(DISTINCT patient_id) AS unique_patients,
    ROUND(AVG(length_of_stay_days), 2) AS average_length_of_stay_days
FROM admission
GROUP BY admission_year_month
ORDER BY admission_year_month;

-- ------------------------------------------------------------
-- Query 4: Revenue trend by admission month
-- Business use:
-- Monthly revenue trend using admission month instead of bill date.
-- ------------------------------------------------------------
SELECT
    a.admission_year_month,
    COUNT(DISTINCT a.admission_id) AS total_admissions,
    ROUND(SUM(b.total_amount), 2) AS total_revenue,
    ROUND(SUM(b.insurance_covered_amount), 2) AS insurance_covered_amount,
    ROUND(SUM(b.patient_payable_amount), 2) AS patient_payable_amount
FROM admission a
LEFT JOIN billing b
    ON a.admission_id = b.admission_id
GROUP BY a.admission_year_month
ORDER BY a.admission_year_month;

-- ------------------------------------------------------------
-- Query 5: Department performance overview
-- Business use:
-- Compares departments by workload, revenue, and average length of stay.
-- ------------------------------------------------------------
SELECT
    d.department_name,
    d.department_type,
    COUNT(DISTINCT a.admission_id) AS total_admissions,
    COUNT(DISTINCT a.patient_id) AS unique_patients,
    ROUND(AVG(a.length_of_stay_days), 2) AS average_length_of_stay_days,
    ROUND(SUM(b.total_amount), 2) AS total_revenue
FROM admission a
LEFT JOIN department d
    ON a.department_id = d.department_id
LEFT JOIN billing b
    ON a.admission_id = b.admission_id
GROUP BY
    d.department_name,
    d.department_type
ORDER BY total_admissions DESC;

-- ------------------------------------------------------------
-- Query 6: Top disease categories by admissions
-- Business use:
-- Shows common disease groups affecting hospital demand.
-- ------------------------------------------------------------
SELECT
    dis.disease_category,
    COUNT(*) AS total_admissions,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM admission), 2) AS admission_percent,
    ROUND(AVG(a.length_of_stay_days), 2) AS average_length_of_stay_days
FROM admission a
LEFT JOIN disease dis
    ON a.disease_id = dis.disease_id
GROUP BY dis.disease_category
ORDER BY total_admissions DESC;

-- ------------------------------------------------------------
-- Query 7: Top 10 diseases by admissions
-- Business use:
-- Gives leadership a quick view of high-volume disease conditions.
-- ------------------------------------------------------------
SELECT
    dis.disease_name,
    dis.disease_category,
    COUNT(*) AS total_admissions,
    ROUND(AVG(a.length_of_stay_days), 2) AS average_length_of_stay_days
FROM admission a
LEFT JOIN disease dis
    ON a.disease_id = dis.disease_id
GROUP BY
    dis.disease_name,
    dis.disease_category
ORDER BY total_admissions DESC
LIMIT 10;

-- ------------------------------------------------------------
-- Query 8: Admission type by department
-- Business use:
-- Shows which departments handle more emergency vs elective cases.
-- ------------------------------------------------------------
SELECT
    d.department_name,
    a.admission_type,
    COUNT(*) AS total_admissions,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY d.department_name), 2) AS department_admission_percent
FROM admission a
LEFT JOIN department d
    ON a.department_id = d.department_id
GROUP BY
    d.department_name,
    a.admission_type
ORDER BY
    d.department_name,
    total_admissions DESC;

-- ------------------------------------------------------------
-- Query 9: Executive monthly summary
-- Business use:
-- One monthly table combining volume, revenue, and length of stay.
-- Useful for Power BI line charts and trend cards.
-- ------------------------------------------------------------
SELECT
    a.admission_year_month,
    COUNT(DISTINCT a.admission_id) AS total_admissions,
    COUNT(DISTINCT a.patient_id) AS unique_patients,
    ROUND(AVG(a.length_of_stay_days), 2) AS average_length_of_stay_days,
    ROUND(SUM(b.total_amount), 2) AS total_revenue,
    ROUND(SUM(b.insurance_covered_amount), 2) AS insurance_covered_amount,
    ROUND(SUM(b.patient_payable_amount), 2) AS patient_payable_amount
FROM admission a
LEFT JOIN billing b
    ON a.admission_id = b.admission_id
GROUP BY a.admission_year_month
ORDER BY a.admission_year_month;

