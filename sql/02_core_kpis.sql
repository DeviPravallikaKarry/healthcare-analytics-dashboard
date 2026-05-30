-- ============================================================
-- 02_core_kpis.sql
-- Project: AI-Assisted Hospital Operations & Patient Analytics
-- Purpose: Calculate core hospital KPIs using MySQL
-- Database: hospital_analytics
-- ============================================================

USE hospital_analytics;

-- ------------------------------------------------------------
-- KPI 1: Total patients
-- Business meaning:
-- Number of unique patients available in the hospital dataset.
-- ------------------------------------------------------------
SELECT
    COUNT(DISTINCT patient_id) AS total_patients
FROM patient;

-- ------------------------------------------------------------
-- KPI 2: Total admissions
-- Business meaning:
-- Total hospital encounters/admissions recorded.
-- ------------------------------------------------------------
SELECT
    COUNT(DISTINCT admission_id) AS total_admissions
FROM admission;

-- ------------------------------------------------------------
-- KPI 3: Total departments
-- Business meaning:
-- Number of active hospital departments in the dataset.
-- ------------------------------------------------------------
SELECT
    COUNT(DISTINCT department_id) AS total_departments
FROM department
WHERE status = 'Active';

-- ------------------------------------------------------------
-- KPI 4: Total revenue
-- Business meaning:
-- Total billed amount from the main billing table.
--
-- Important:
-- Based on Stage 3 validation, billing.csv is the source of truth
-- for official revenue KPIs.
-- ------------------------------------------------------------
SELECT
    ROUND(SUM(total_amount), 2) AS total_revenue
FROM billing;

-- ------------------------------------------------------------
-- KPI 5: Insurance-covered amount and patient-payable amount
-- Business meaning:
-- Splits total billed amount into insurance contribution and
-- patient out-of-pocket/payable amount.
-- ------------------------------------------------------------
SELECT
    ROUND(SUM(total_amount), 2) AS total_revenue,
    ROUND(SUM(insurance_covered_amount), 2) AS insurance_covered_amount,
    ROUND(SUM(patient_payable_amount), 2) AS patient_payable_amount
FROM billing;

-- ------------------------------------------------------------
-- KPI 6: Average length of stay
-- Business meaning:
-- Average number of days patients stayed in the hospital.
-- ------------------------------------------------------------
SELECT
    ROUND(AVG(length_of_stay_days), 2) AS average_length_of_stay_days
FROM admission;

-- ------------------------------------------------------------
-- KPI 7: Admission type distribution
-- Business meaning:
-- Shows emergency vs elective workload.
-- ------------------------------------------------------------
SELECT
    admission_type,
    COUNT(*) AS total_admissions,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM admission), 2) AS admission_percent
FROM admission
GROUP BY admission_type
ORDER BY total_admissions DESC;

-- ------------------------------------------------------------
-- KPI 8: Payment status distribution
-- Business meaning:
-- Shows paid vs pending bill status.
-- ------------------------------------------------------------
SELECT
    payment_status,
    COUNT(*) AS total_bills,
    ROUND(SUM(total_amount), 2) AS total_amount,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM billing), 2) AS bill_percent
FROM billing
GROUP BY payment_status
ORDER BY total_bills DESC;

-- ------------------------------------------------------------
-- KPI 9: Payment mode distribution
-- Business meaning:
-- Shows how bills are paid: insurance, UPI, card, or cash.
-- ------------------------------------------------------------
SELECT
    payment_mode,
    COUNT(*) AS total_bills,
    ROUND(SUM(total_amount), 2) AS total_amount
FROM billing
GROUP BY payment_mode
ORDER BY total_amount DESC;

-- ------------------------------------------------------------
-- KPI 10: Bed status distribution
-- Business meaning:
-- Basic operational view of occupied vs available beds.
-- ------------------------------------------------------------
SELECT
    bed_status,
    COUNT(*) AS total_beds
FROM bed
GROUP BY bed_status
ORDER BY total_beds DESC;

