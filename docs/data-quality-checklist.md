# Stage 2: Initial Data Quality Checklist

This checklist defines the first set of data quality checks for the HMIS dataset.

## General Checks

- Confirm all expected CSV files are present.
- Check number of rows and columns in each table.
- Check column names for consistency.
- Check data types after loading into pandas.
- Check missing values in each column.
- Check duplicate rows in each table.

## Date Checks

- Admission date should not be after discharge date.
- Billing date should not be before admission date.
- Test date should be during or after admission.
- Policy end date should not be before policy start date.
- Restock date should be valid.

## Numeric Checks

- Billing amounts should not be negative.
- Insurance-covered amount should not exceed total amount.
- Patient payable amount should not be negative.
- Drug unit cost should be greater than or equal to zero.
- Current stock and reorder level should not be negative.
- Patient age should be realistic.

## Relationship Checks

- Every admission should link to a valid patient.
- Every admission should link to a valid department.
- Every admission should link to a valid ward and bed.
- Every billing record should link to a valid admission.
- Every diagnostic record should link to a valid admission and test.
- Every prescription should link to a valid admission and drug.
- Every doctor should link to a valid employee.

## Healthcare Analyst Notes

Finding no issues is still useful. It shows that the dataset was checked systematically before building KPIs and dashboards.

