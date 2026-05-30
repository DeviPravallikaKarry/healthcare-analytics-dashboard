-- ============================================================
-- 06_financial_dashboard_queries.sql
-- Project: AI-Assisted Hospital Operations & Patient Analytics
-- Purpose: SQL queries for Financial Dashboard metrics
-- Database: hospital_analytics
-- ============================================================

USE hospital_analytics;

-- Important:
-- Stage 3 validation showed:
-- 1. billing.csv should be treated as the financial source of truth.
-- 2. billing_detail.csv should be used only for charge-type distribution.
-- 3. billing.bill_date is unreliable for trend analysis.
-- 4. Revenue trends should use admission date/month from the admission table.

-- ------------------------------------------------------------
-- Query 1: Financial summary KPI cards
-- Business use:
-- High-level financial performance summary.
-- ------------------------------------------------------------
SELECT
    COUNT(DISTINCT bill_id) AS total_bills,
    ROUND(SUM(total_amount), 2) AS total_revenue,
    ROUND(SUM(insurance_covered_amount), 2) AS insurance_covered_amount,
    ROUND(SUM(patient_payable_amount), 2) AS patient_payable_amount,
    ROUND(AVG(total_amount), 2) AS average_bill_amount,
    ROUND(AVG(insurance_coverage_percent), 2) AS average_insurance_coverage_percent
FROM billing;

-- ------------------------------------------------------------
-- Query 2: Revenue split
-- Business use:
-- Shows insurance-covered vs patient-payable financial split.
-- ------------------------------------------------------------
SELECT
    'Insurance Covered' AS revenue_component,
    ROUND(SUM(insurance_covered_amount), 2) AS amount,
    ROUND(SUM(insurance_covered_amount) * 100.0 / SUM(total_amount), 2) AS percent_of_total_revenue
FROM billing
UNION ALL
SELECT
    'Patient Payable' AS revenue_component,
    ROUND(SUM(patient_payable_amount), 2) AS amount,
    ROUND(SUM(patient_payable_amount) * 100.0 / SUM(total_amount), 2) AS percent_of_total_revenue
FROM billing;

-- ------------------------------------------------------------
-- Query 3: Payment status summary
-- Business use:
-- Shows paid vs pending bills and amount.
-- ------------------------------------------------------------
SELECT
    payment_status,
    COUNT(*) AS total_bills,
    ROUND(SUM(total_amount), 2) AS total_amount,
    ROUND(SUM(total_amount) * 100.0 / (SELECT SUM(total_amount) FROM billing), 2) AS amount_percent
FROM billing
GROUP BY payment_status
ORDER BY total_amount DESC;

-- ------------------------------------------------------------
-- Query 4: Payment mode summary
-- Business use:
-- Shows revenue by payment mode.
-- ------------------------------------------------------------
SELECT
    payment_mode,
    COUNT(*) AS total_bills,
    ROUND(SUM(total_amount), 2) AS total_amount,
    ROUND(SUM(total_amount) * 100.0 / (SELECT SUM(total_amount) FROM billing), 2) AS amount_percent
FROM billing
GROUP BY payment_mode
ORDER BY total_amount DESC;

-- ------------------------------------------------------------
-- Query 5: Revenue trend by admission month
-- Business use:
-- Shows monthly financial trend using admission month.
-- ------------------------------------------------------------
SELECT
    a.admission_year_month,
    COUNT(DISTINCT b.bill_id) AS total_bills,
    ROUND(SUM(b.total_amount), 2) AS total_revenue,
    ROUND(SUM(b.insurance_covered_amount), 2) AS insurance_covered_amount,
    ROUND(SUM(b.patient_payable_amount), 2) AS patient_payable_amount,
    ROUND(AVG(b.total_amount), 2) AS average_bill_amount
FROM billing b
LEFT JOIN admission a
    ON b.admission_id = a.admission_id
GROUP BY a.admission_year_month
ORDER BY a.admission_year_month;

-- ------------------------------------------------------------
-- Query 6: Revenue by department
-- Business use:
-- Shows which departments contribute most revenue.
-- ------------------------------------------------------------
SELECT
    d.department_name,
    COUNT(DISTINCT a.admission_id) AS total_admissions,
    COUNT(DISTINCT b.bill_id) AS total_bills,
    ROUND(SUM(b.total_amount), 2) AS total_revenue,
    ROUND(AVG(b.total_amount), 2) AS average_bill_amount,
    ROUND(SUM(b.insurance_covered_amount), 2) AS insurance_covered_amount,
    ROUND(SUM(b.patient_payable_amount), 2) AS patient_payable_amount
FROM admission a
LEFT JOIN department d
    ON a.department_id = d.department_id
LEFT JOIN billing b
    ON a.admission_id = b.admission_id
GROUP BY d.department_name
ORDER BY total_revenue DESC;

-- ------------------------------------------------------------
-- Query 7: Revenue by disease category
-- Business use:
-- Shows financial burden by clinical category.
-- ------------------------------------------------------------
SELECT
    dis.disease_category,
    COUNT(DISTINCT a.admission_id) AS total_admissions,
    ROUND(SUM(b.total_amount), 2) AS total_revenue,
    ROUND(AVG(b.total_amount), 2) AS average_bill_amount,
    ROUND(SUM(b.insurance_covered_amount), 2) AS insurance_covered_amount,
    ROUND(SUM(b.patient_payable_amount), 2) AS patient_payable_amount
FROM admission a
LEFT JOIN disease dis
    ON a.disease_id = dis.disease_id
LEFT JOIN billing b
    ON a.admission_id = b.admission_id
GROUP BY dis.disease_category
ORDER BY total_revenue DESC;

-- ------------------------------------------------------------
-- Query 8: Top 10 diseases by revenue
-- Business use:
-- Identifies high-revenue/high-cost disease conditions.
-- ------------------------------------------------------------
SELECT
    dis.disease_name,
    dis.disease_category,
    COUNT(DISTINCT a.admission_id) AS total_admissions,
    ROUND(SUM(b.total_amount), 2) AS total_revenue,
    ROUND(AVG(b.total_amount), 2) AS average_bill_amount
FROM admission a
LEFT JOIN disease dis
    ON a.disease_id = dis.disease_id
LEFT JOIN billing b
    ON a.admission_id = b.admission_id
GROUP BY
    dis.disease_name,
    dis.disease_category
ORDER BY total_revenue DESC
LIMIT 10;

-- ------------------------------------------------------------
-- Query 9: Charge type distribution
-- Business use:
-- Shows approximate charge-type distribution from billing_detail.
--
-- Note:
-- billing_detail totals do not reconcile exactly with billing totals.
-- Use this only for high-level charge-type mix, not official revenue.
-- ------------------------------------------------------------
SELECT
    charge_type,
    COUNT(*) AS total_line_items,
    ROUND(SUM(amount), 2) AS charge_type_amount,
    ROUND(SUM(amount) * 100.0 / (SELECT SUM(amount) FROM billing_detail), 2) AS charge_type_percent
FROM billing_detail
GROUP BY charge_type
ORDER BY charge_type_amount DESC;

-- ------------------------------------------------------------
-- Query 10: Average bill amount by admission type
-- Business use:
-- Compares billing patterns for elective vs emergency admissions.
-- ------------------------------------------------------------
SELECT
    a.admission_type,
    COUNT(DISTINCT a.admission_id) AS total_admissions,
    ROUND(SUM(b.total_amount), 2) AS total_revenue,
    ROUND(AVG(b.total_amount), 2) AS average_bill_amount,
    ROUND(AVG(b.insurance_coverage_percent), 2) AS average_insurance_coverage_percent
FROM admission a
LEFT JOIN billing b
    ON a.admission_id = b.admission_id
GROUP BY a.admission_type
ORDER BY total_revenue DESC;

-- ------------------------------------------------------------
-- Query 11: Pending amount by department
-- Business use:
-- Helps identify departments with higher pending billing amounts.
-- ------------------------------------------------------------
SELECT
    d.department_name,
    COUNT(*) AS pending_bills,
    ROUND(SUM(b.total_amount), 2) AS pending_amount
FROM billing b
LEFT JOIN admission a
    ON b.admission_id = a.admission_id
LEFT JOIN department d
    ON a.department_id = d.department_id
WHERE b.payment_status = 'Pending'
GROUP BY d.department_name
ORDER BY pending_amount DESC;

-- ------------------------------------------------------------
-- Query 12: Insurance coverage by department
-- Business use:
-- Shows how insurance coverage varies by department.
-- ------------------------------------------------------------
SELECT
    d.department_name,
    COUNT(DISTINCT b.bill_id) AS total_bills,
    ROUND(SUM(b.total_amount), 2) AS total_revenue,
    ROUND(SUM(b.insurance_covered_amount), 2) AS insurance_covered_amount,
    ROUND(SUM(b.patient_payable_amount), 2) AS patient_payable_amount,
    ROUND(AVG(b.insurance_coverage_percent), 2) AS average_insurance_coverage_percent
FROM billing b
LEFT JOIN admission a
    ON b.admission_id = a.admission_id
LEFT JOIN department d
    ON a.department_id = d.department_id
GROUP BY d.department_name
ORDER BY average_insurance_coverage_percent DESC;

