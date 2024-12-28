
Human Resources Data Analysis Project 📊
Overview
This project involves a comprehensive analysis of a Human Resources (HR) dataset using SQL. The focus is on cleaning, transforming, and analyzing the dataset to uncover valuable insights about employees, such as demographics, tenure, job roles, and termination rates.

By leveraging SQL, the project demonstrates proficiency in data cleaning, feature engineering, and exploratory data analysis (EDA), addressing key HR-related business questions.

Table of Contents
Dataset Schema
Data Cleaning and Transformation
Exploratory Data Analysis (EDA)
Key Insights
Conclusion
How to Use This Repository
Dataset Schema
The dataset contains the following columns:

Column Name	Description

emp_id	Unique identifier for each employee.

birthdate	Employee's date of birth.

hire_date	Date the employee was hired.

termdate	Date the employee was terminated (if applicable).

age	Employee's age.

gender	Gender of the employee.

race	Race/ethnicity of the employee.

department	Department where the employee works.

jobtitle	Employee's job title.

location	Location of the employee (headquarters or remote).

location_city	City of the employee's location.

location_state	State of the employee's location.


Data Cleaning and Transformation:

The dataset underwent extensive cleaning and transformation to ensure consistency and reliability for analysis. Key steps include:

Fixing Column Names: Renamed and standardized column names for clarity.
Date Format Normalization: Converted birthdate, hire_date, and termdate into the standard YYYY-MM-DD format.

Feature Engineering:

Added an age column using birthdate.

Derived time_of_day and age_group categories.

Handling Missing Data: Filled missing or invalid termination dates with 0000-00-00.

Exploratory Data Analysis (EDA)

The project answered the following key questions using SQL queries:

1. What is the gender breakdown of employees?


2. What is the race breakdown of employees?


3. What is the age distribution of employees by gender?

4. How many employees work at headquarters versus remote locations?

5. What is the average tenure of terminated employees?

6. How does gender distribution vary across departments and job titles?

7. What is the distribution of job titles across the company?

8. Which department has the highest termination rate?

9. What is the distribution of employees across cities and states?

10. How has the company's employee count changed over time?

11. What is the tenure distribution for each department?

Key Insights
Gender and Race:

Gender distribution among active employees shows a balanced ratio in most departments.
Racial diversity was mapped across departments and locations.
Age Distribution:

Employees primarily fall into the 25-34 age group.
Gender variations exist within specific age groups.
Location and Job Titles:

Headquarters employs the majority of staff, with some representation at remote locations.
Top job titles indicate a concentration in administrative and technical roles.
Termination Analysis:

The department with the highest termination rate was identified for further investigation.
Average tenure of terminated employees was calculated for insights into employee retention.
Employee Count Over Time:

Net employee growth over the years was analyzed to assess hiring trends.
Tenure:

Departments with the longest and shortest average tenures were highlighted.

Conclusion

The HR dataset provided valuable insights into employee demographics, tenure, and department dynamics. This analysis can help HR teams:


Optimize hiring and retention strategies.

Identify departments or roles with higher termination rates.

Promote diversity and inclusion across the organization.


