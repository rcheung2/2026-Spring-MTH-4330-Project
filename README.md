# 2026-Spring-MTH-4330-Project
Group project for MTH 4330 (Introduction to Machine Learning)

# Main Goals

We will analyze a variety of factors that could influence NYC payroll.

# Our Dataset

We will be using the Citywide Payroll Data (Fiscal Year) from NYC OpenData.
The data dictionary and the dataset itself can be downloaded from the link below:
https://data.cityofnewyork.us/City-Government/Citywide-Payroll-Data-Fiscal-Year-/k397-673e/about_data

Quantitative inputs to consider:
- Base Salary
- Regular Hours
- OT hours worked

Qualitative inputs to consider:
- Pay basis (hourly, annual, daily, prorated annual)
- Agency Name
- Work Location Borough
- Title Description (note: this one might not work as well because it is not as standardized)
- Leave Status as of June 30

Relevant outputs:
- Regular Gross Paid: A representation of actual base salary paid during the fiscal year. Does not include overtime pay or other compensation.
- Total OT Paid: The employee's total overtime pay for the fiscal year.
- Total Other Pay: Includes any additional compensation other than gross salary and overtime pay, such as retroactive pay increases, bonus pay, settlement amounts, meal allowance, etc.

# Notes
We were only able to upload the Prorated Annual dataset to this repository because the others exceed the 50MB file size limit.

Here is a list of each one:

Prorated Annual - 5.27 MB, with 29,466 rows

Per Annum - 708 MB, with 4,060,360 rows

Per Day - 262 MB, with 1,549,827 rows

Per Hour - 189 MB, with 1,136,177 rows

The prorated annual data set is for a proof of concept, but those who want to run the code on the dataset themselves are encouraged to go to
https://data.cityofnewyork.us/City-Government/Citywide-Payroll-Data-Fiscal-Year-/k397-673e/about_data
to download the larger data tables, or even the entire dataset. It is also actively updated annually, so the version on this repository will eventually become outdated.
