-- ============================================================
-- 04_clinical_dashboard_queries.sql
-- Project: AI-Assisted Hospital Operations & Patient Analytics
-- Purpose: SQL queries for Clinical Dashboard metrics
-- Database: hospital_analytics
-- ============================================================

USE hospital_analytics;

-- ------------------------------------------------------------
-- Query 1: Clinical summary KPI cards
-- Business use:
-- High-level clinical workload overview.
-- ------------------------------------------------------------
SELECT
    COUNT(DISTINCT a.admission_id) AS total_admissions,
    COUNT(DISTINCT a.patient_id) AS total_patients,
    COUNT(DISTINCT a.disease_id) AS total_diseases,
    COUNT(DISTINCT pd.patient_diagnostic_id) AS total_diagnostic_tests,
    COUNT(DISTINCT pr.prescription_id) AS total_prescriptions
FROM admission a
LEFT JOIN patient_diagnostic pd
    ON a.admission_id = pd.admission_id
LEFT JOIN prescription pr
    ON a.admission_id = pr.admission_id;

-- ------------------------------------------------------------
-- Query 2: Disease category distribution
-- Business use:
-- Shows which disease categories contribute most to hospital workload.
-- ------------------------------------------------------------
SELECT
    d.disease_category,
    COUNT(*) AS total_admissions,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM admission), 2) AS admission_percent,
    ROUND(AVG(a.length_of_stay_days), 2) AS average_length_of_stay_days
FROM admission a
LEFT JOIN disease d
    ON a.disease_id = d.disease_id
GROUP BY d.disease_category
ORDER BY total_admissions DESC;

-- ------------------------------------------------------------
-- Query 3: Top 10 diseases by admissions
-- Business use:
-- Identifies high-volume clinical conditions.
-- ------------------------------------------------------------
SELECT
    d.disease_name,
    d.disease_category,
    COUNT(*) AS total_admissions,
    ROUND(AVG(a.length_of_stay_days), 2) AS average_length_of_stay_days
FROM admission a
LEFT JOIN disease d
    ON a.disease_id = d.disease_id
GROUP BY
    d.disease_name,
    d.disease_category
ORDER BY total_admissions DESC
LIMIT 10;

-- ------------------------------------------------------------
-- Query 4: Disease category by gender
-- Business use:
-- Helps compare disease burden across gender groups.
-- ------------------------------------------------------------
SELECT
    d.disease_category,
    p.gender,
    COUNT(*) AS total_admissions
FROM admission a
LEFT JOIN disease d
    ON a.disease_id = d.disease_id
LEFT JOIN patient p
    ON a.patient_id = p.patient_id
GROUP BY
    d.disease_category,
    p.gender
ORDER BY
    d.disease_category,
    total_admissions DESC;

-- ------------------------------------------------------------
-- Query 5: Disease category by age group
-- Business use:
-- Supports age-wise clinical pattern analysis.
-- ------------------------------------------------------------
SELECT
    d.disease_category,
    p.age_group,
    COUNT(*) AS total_admissions
FROM admission a
LEFT JOIN disease d
    ON a.disease_id = d.disease_id
LEFT JOIN patient p
    ON a.patient_id = p.patient_id
GROUP BY
    d.disease_category,
    p.age_group
ORDER BY
    d.disease_category,
    total_admissions DESC;

-- ------------------------------------------------------------
-- Query 6: Top diseases by age group
-- Business use:
-- Shows which diseases are most common within each age segment.
-- ------------------------------------------------------------
WITH disease_age_counts AS (
    SELECT
        p.age_group,
        d.disease_name,
        d.disease_category,
        COUNT(*) AS total_admissions,
        ROW_NUMBER() OVER (
            PARTITION BY p.age_group
            ORDER BY COUNT(*) DESC
        ) AS disease_rank
    FROM admission a
    LEFT JOIN patient p
        ON a.patient_id = p.patient_id
    LEFT JOIN disease d
        ON a.disease_id = d.disease_id
    GROUP BY
        p.age_group,
        d.disease_name,
        d.disease_category
)
SELECT
    age_group,
    disease_name,
    disease_category,
    total_admissions
FROM disease_age_counts
WHERE disease_rank <= 5
ORDER BY
    age_group,
    disease_rank;

-- ------------------------------------------------------------
-- Query 7: Diagnostic test usage
-- Business use:
-- Shows the most commonly used diagnostic tests.
-- ------------------------------------------------------------
SELECT
    dt.test_name,
    dt.test_category,
    COUNT(*) AS total_tests,
    ROUND(AVG(dt.standard_cost), 2) AS standard_cost
FROM patient_diagnostic pd
LEFT JOIN diagnostic_test dt
    ON pd.test_id = dt.test_id
GROUP BY
    dt.test_name,
    dt.test_category
ORDER BY total_tests DESC;

-- ------------------------------------------------------------
-- Query 8: Diagnostic result status distribution
-- Business use:
-- Shows normal vs abnormal diagnostic result volume.
-- ------------------------------------------------------------
SELECT
    result_status,
    COUNT(*) AS total_results,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM patient_diagnostic), 2) AS result_percent
FROM patient_diagnostic
GROUP BY result_status
ORDER BY total_results DESC;

-- ------------------------------------------------------------
-- Query 9: Diagnostic tests by department
-- Business use:
-- Shows diagnostic service workload by test-owning department.
--
-- Note:
-- diagnostic_test.department_id represents the department responsible
-- for the test, not necessarily the admitting department.
-- ------------------------------------------------------------
SELECT
    dep.department_name AS diagnostic_department,
    dt.test_category,
    COUNT(*) AS total_tests
FROM patient_diagnostic pd
LEFT JOIN diagnostic_test dt
    ON pd.test_id = dt.test_id
LEFT JOIN department dep
    ON dt.department_id = dep.department_id
GROUP BY
    dep.department_name,
    dt.test_category
ORDER BY total_tests DESC;

-- ------------------------------------------------------------
-- Query 10: Top prescribed drugs
-- Business use:
-- Identifies high-use medications for clinical/pharmacy analysis.
-- ------------------------------------------------------------
SELECT
    dr.drug_name,
    dr.drug_category,
    COUNT(*) AS total_prescriptions,
    ROUND(AVG(pr.duration_days), 2) AS average_duration_days
FROM prescription pr
LEFT JOIN drug dr
    ON pr.drug_id = dr.drug_id
GROUP BY
    dr.drug_name,
    dr.drug_category
ORDER BY total_prescriptions DESC
LIMIT 10;

-- ------------------------------------------------------------
-- Query 11: Prescription volume by drug category
-- Business use:
-- Shows broader medication category utilization.
-- ------------------------------------------------------------
SELECT
    dr.drug_category,
    COUNT(*) AS total_prescriptions,
    ROUND(AVG(pr.duration_days), 2) AS average_duration_days
FROM prescription pr
LEFT JOIN drug dr
    ON pr.drug_id = dr.drug_id
GROUP BY dr.drug_category
ORDER BY total_prescriptions DESC;

-- ------------------------------------------------------------
-- Query 12: Clinical workload by department
-- Business use:
-- Combines admissions, diagnostics, and prescriptions by admitting department.
-- ------------------------------------------------------------
SELECT
    dep.department_name,
    COUNT(DISTINCT a.admission_id) AS total_admissions,
    COUNT(DISTINCT pd.patient_diagnostic_id) AS total_diagnostic_tests,
    COUNT(DISTINCT pr.prescription_id) AS total_prescriptions,
    ROUND(AVG(a.length_of_stay_days), 2) AS average_length_of_stay_days
FROM admission a
LEFT JOIN department dep
    ON a.department_id = dep.department_id
LEFT JOIN patient_diagnostic pd
    ON a.admission_id = pd.admission_id
LEFT JOIN prescription pr
    ON a.admission_id = pr.admission_id
GROUP BY dep.department_name
ORDER BY total_admissions DESC;

