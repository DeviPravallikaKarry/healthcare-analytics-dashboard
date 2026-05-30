-- ============================================================
-- 05_operations_dashboard_queries.sql
-- Project: AI-Assisted Hospital Operations & Patient Analytics
-- Purpose: SQL queries for Operations Dashboard metrics
-- Database: hospital_analytics
-- ============================================================

USE hospital_analytics;

-- ------------------------------------------------------------
-- Query 1: Operations summary KPI cards
-- Business use:
-- High-level operational workload and capacity view.
-- ------------------------------------------------------------
SELECT
    COUNT(DISTINCT a.admission_id) AS total_admissions,
    COUNT(DISTINCT a.department_id) AS departments_with_admissions,
    COUNT(DISTINCT a.ward_id) AS wards_used,
    COUNT(DISTINCT a.bed_id) AS beds_used,
    ROUND(AVG(a.length_of_stay_days), 2) AS average_length_of_stay_days,
    SUM(CASE WHEN a.admission_type = 'Emergency' THEN 1 ELSE 0 END) AS emergency_admissions,
    SUM(CASE WHEN a.admission_type = 'Elective' THEN 1 ELSE 0 END) AS elective_admissions
FROM admission a;

-- ------------------------------------------------------------
-- Query 2: Department workload
-- Business use:
-- Shows which departments handle the most patient admissions.
-- ------------------------------------------------------------
SELECT
    d.department_name,
    d.department_type,
    COUNT(*) AS total_admissions,
    COUNT(DISTINCT a.patient_id) AS unique_patients,
    ROUND(AVG(a.length_of_stay_days), 2) AS average_length_of_stay_days
FROM admission a
LEFT JOIN department d
    ON a.department_id = d.department_id
GROUP BY
    d.department_name,
    d.department_type
ORDER BY total_admissions DESC;

-- ------------------------------------------------------------
-- Query 3: Admission type by department
-- Business use:
-- Shows emergency vs elective workload for each department.
-- ------------------------------------------------------------
SELECT
    d.department_name,
    a.admission_type,
    COUNT(*) AS total_admissions,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY d.department_name), 2) AS department_percent
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
-- Query 4: Length of stay by department
-- Business use:
-- Identifies departments with longer patient stays.
-- ------------------------------------------------------------
SELECT
    d.department_name,
    COUNT(*) AS total_admissions,
    ROUND(AVG(a.length_of_stay_days), 2) AS average_length_of_stay_days,
    MIN(a.length_of_stay_days) AS minimum_length_of_stay_days,
    MAX(a.length_of_stay_days) AS maximum_length_of_stay_days
FROM admission a
LEFT JOIN department d
    ON a.department_id = d.department_id
GROUP BY d.department_name
ORDER BY average_length_of_stay_days DESC;

-- ------------------------------------------------------------
-- Query 5: Ward workload and capacity
-- Business use:
-- Compares ward admission workload with available bed capacity.
-- ------------------------------------------------------------
SELECT
    d.department_name,
    w.ward_name,
    w.ward_type,
    w.total_beds,
    COUNT(a.admission_id) AS total_admissions,
    ROUND(COUNT(a.admission_id) / w.total_beds, 2) AS admissions_per_bed
FROM ward w
LEFT JOIN department d
    ON w.department_id = d.department_id
LEFT JOIN admission a
    ON w.ward_id = a.ward_id
GROUP BY
    d.department_name,
    w.ward_name,
    w.ward_type,
    w.total_beds
ORDER BY admissions_per_bed DESC;

-- ------------------------------------------------------------
-- Query 6: Bed status distribution
-- Business use:
-- Shows current bed availability status.
-- ------------------------------------------------------------
SELECT
    bed_status,
    COUNT(*) AS total_beds,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM bed), 2) AS bed_percent
FROM bed
GROUP BY bed_status
ORDER BY total_beds DESC;

-- ------------------------------------------------------------
-- Query 7: Bed status by ward type
-- Business use:
-- Shows occupancy/availability patterns by ward category.
-- ------------------------------------------------------------
SELECT
    w.ward_type,
    b.bed_status,
    COUNT(*) AS total_beds
FROM bed b
LEFT JOIN ward w
    ON b.ward_id = w.ward_id
GROUP BY
    w.ward_type,
    b.bed_status
ORDER BY
    w.ward_type,
    total_beds DESC;

-- ------------------------------------------------------------
-- Query 8: Monthly admission workload
-- Business use:
-- Shows operational patient volume trend over time.
-- ------------------------------------------------------------
SELECT
    admission_year_month,
    COUNT(*) AS total_admissions,
    SUM(CASE WHEN admission_type = 'Emergency' THEN 1 ELSE 0 END) AS emergency_admissions,
    SUM(CASE WHEN admission_type = 'Elective' THEN 1 ELSE 0 END) AS elective_admissions,
    ROUND(AVG(length_of_stay_days), 2) AS average_length_of_stay_days
FROM admission
GROUP BY admission_year_month
ORDER BY admission_year_month;

-- ------------------------------------------------------------
-- Query 9: Staff count by role
-- Business use:
-- Gives a high-level staffing overview.
-- ------------------------------------------------------------
SELECT
    role,
    COUNT(*) AS total_staff
FROM employee
GROUP BY role
ORDER BY total_staff DESC;

-- ------------------------------------------------------------
-- Query 10: Staff count by department
-- Business use:
-- Shows how employees are distributed across departments.
-- ------------------------------------------------------------
SELECT
    d.department_name,
    e.role,
    COUNT(*) AS total_staff
FROM employee e
LEFT JOIN department d
    ON e.department_id = d.department_id
GROUP BY
    d.department_name,
    e.role
ORDER BY
    d.department_name,
    total_staff DESC;

-- ------------------------------------------------------------
-- Query 11: Doctor count by specialization
-- Business use:
-- Shows doctor availability by specialty.
-- ------------------------------------------------------------
SELECT
    specialization,
    COUNT(*) AS total_doctors,
    ROUND(AVG(experience_years), 2) AS average_experience_years
FROM doctor
GROUP BY specialization
ORDER BY total_doctors DESC;

-- ------------------------------------------------------------
-- Query 12: Staff assignments by ward and shift
-- Business use:
-- Shows ward staffing pattern by shift.
--
-- Note:
-- Stage 3 validation showed employee home department may differ
-- from assigned ward department. Use this as assignment-level data.
-- ------------------------------------------------------------
SELECT
    w.ward_name,
    w.ward_type,
    sa.shift,
    COUNT(*) AS assigned_staff
FROM staff_assignment sa
LEFT JOIN ward w
    ON sa.ward_id = w.ward_id
GROUP BY
    w.ward_name,
    w.ward_type,
    sa.shift
ORDER BY
    w.ward_name,
    sa.shift;

-- ------------------------------------------------------------
-- Query 13: Potential operational bottleneck view
-- Business use:
-- Combines admissions, beds, and length of stay to identify
-- departments that may need closer operational monitoring.
-- ------------------------------------------------------------
SELECT
    d.department_name,
    COUNT(DISTINCT a.admission_id) AS total_admissions,
    COUNT(DISTINCT a.bed_id) AS beds_used,
    ROUND(COUNT(DISTINCT a.admission_id) / COUNT(DISTINCT a.bed_id), 2) AS admissions_per_bed_used,
    ROUND(AVG(a.length_of_stay_days), 2) AS average_length_of_stay_days
FROM admission a
LEFT JOIN department d
    ON a.department_id = d.department_id
GROUP BY d.department_name
ORDER BY
    admissions_per_bed_used DESC,
    average_length_of_stay_days DESC;

