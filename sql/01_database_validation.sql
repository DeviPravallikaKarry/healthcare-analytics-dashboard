-- ============================================================
-- 01_database_validation.sql
-- Project: AI-Assisted Hospital Operations & Patient Analytics
-- Purpose: Validate that processed CSV files loaded correctly into MySQL
-- Database: hospital_analytics
-- ============================================================

USE hospital_analytics;

-- 1. Show all imported tables
SHOW TABLES;

-- 2. Validate important row counts
SELECT 'patient' AS table_name, COUNT(*) AS row_count FROM patient
UNION ALL
SELECT 'admission' AS table_name, COUNT(*) AS row_count FROM admission
UNION ALL
SELECT 'billing' AS table_name, COUNT(*) AS row_count FROM billing
UNION ALL
SELECT 'billing_detail' AS table_name, COUNT(*) AS row_count FROM billing_detail
UNION ALL
SELECT 'department' AS table_name, COUNT(*) AS row_count FROM department
UNION ALL
SELECT 'disease' AS table_name, COUNT(*) AS row_count FROM disease
UNION ALL
SELECT 'prescription' AS table_name, COUNT(*) AS row_count FROM prescription
UNION ALL
SELECT 'patient_diagnostic' AS table_name, COUNT(*) AS row_count FROM patient_diagnostic
ORDER BY table_name;

-- 3. Check sample records from key tables
SELECT *
FROM patient
LIMIT 10;

SELECT *
FROM admission
LIMIT 10;

SELECT *
FROM billing
LIMIT 10;

-- 4. Confirm processed columns are available
DESCRIBE patient;
DESCRIBE admission;
DESCRIBE billing;
DESCRIBE billing_detail;

