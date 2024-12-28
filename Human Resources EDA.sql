CREATE DATABASE human_resources;

USE human_resources;

SELECT *
FROM hr;

-- ---------------------------------------- Data Cleaning ----------------------------------------

ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NOT NULL PRIMARY KEY;

DESCRIBE hr;


UPDATE hr
SET birthdate = 
CASE
    WHEN birthdate LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END  ;  

ALTER TABLE hr
MODIFY COLUMN birthdate DATE;


UPDATE hr
SET hire_date = 
CASE
    WHEN hire_date LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END  ;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;


UPDATE hr
SET termdate = IF(termdate IS NOT NULL AND termdate != '', date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')), '0000-00-00')
WHERE true;

SELECT termdate from hr;

SET sql_mode = 'ALLOW_INVALID_DATES';

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

ALTER TABLE hr
ADD COLUMN age INT;

UPDATE hr
SET age = TIMESTAMPDIFF(YEAR, birthdate, CURDATE());


ALTER TABLE hr
ADD COLUMN age INT;

UPDATE hr
SET age = TIMESTAMPDIFF(YEAR, birthdate, CURDATE());


-- EDA on hr dataset

-- 1) What is the gender breakdown of employees in company?

SELECT 
   gender,
   COUNT(*) AS gender_count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY gender;   

-- 2) What is the race breakdown of employees in company?

SELECT 
   race,
   COUNT(*) AS gender_count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY race
ORDER BY 2 DESC; 

-- 3) What is the age distribution with gender of employees in the company?

SELECT 
   MIN(age) AS Youngest,
   MAX(age) AS Oldest,
   gender
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00';

SELECT
   CASE
       WHEN age >= 18 AND age <= 24 THEN '18-24'
       WHEN age >= 25 AND age <= 34 THEN '25-34'
       WHEN age >= 35 AND age <= 44 THEN '35-44'
       WHEN age >= 45 AND age <= 54 THEN '45-54'
       WHEN age >= 55 AND age <= 65 THEN '55-65'
       ELSE '65+'
  END AS age_group, gender,
  COUNT(*) AS count
  FROM hr
  WHERE age >= 18 AND termdate = '0000-00-00'
  GROUP BY age_group, gender
  ORDER BY age_group;
  
  -- 4) How many employees work at headquarters versus remote locations?
  
  SELECT 
     location,
     COUNT(*) AS Count
 FROM hr
 WHERE age >= 18 AND termdate = '0000-00-00'
 GROUP BY location;
 
 -- 5) What is the average length of employment for employees who have been terminated?
 
 SELECT 
   ROUND(AVG(DATEDIFF(termdate, hire_date)) / 365,0) AS  tenure_of_employees
FROM hr
WHERE termdate <= CURDATE() AND termdate <> '0000-00-00' AND age>= 18


-- 6) How does the gender distribution vary across departments and job titles?

 SELECT
   department,
   gender,
   COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY department, gender
ORDER BY 3 DESC


-- 7) What is the distribution of job titles across the company?

SELECT 
    jobtitle, 
    COUNT(*) AS job_count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY jobtitle
ORDER BY job_count DESC;

-- 8) Which department has the highest termination rate?

SELECT 
   department,
   total_count,
   terminated_count,
   ROUND(((terminated_count / total_count)*100),0) AS termination_rate
FROM(
  SELECT department,
  COUNT(*) AS total_count,
  SUM(CASE
        WHEN termdate <> '0000-00-00' AND termdate <= CURDATE() THEN 1
        ELSE 0 
        END) AS terminated_count
  FROM hr
  WHERE age >= 18
  GROUP BY department  
  ) AS sub  
ORDER BY termination_rate DESC;  


-- 9) What is the distribution of employees across locations by city and state?

SELECT
   location_city,
   location_state,
   COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY location_city, location_state
ORDER BY COUNT DESC;

-- 10) How has the comapany's employee count change over time based on hire and term date

SELECT
   year,
   hires,
   terminations,
   hires - terminations AS net_change,
   ROUND((hires - terminations) / hires * 100, 2) As net_change_pct
FROM(
   SELECT YEAR(hire_date) AS year,
   COUNT(*) AS hires,
   SUM(CASE
           WHEN termdate <> '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminations
   FROM hr
   WHERE age >= 18
   GROUP BY YEAR(hire_date)
   ) AS sub
ORDER BY year ASC;   


-- 11) What is the tenure distribution for each department?

SELECT
   department,
   ROUND(AVG(DATEDIFF(termdate, hire_date) / 365), 0) AS avg_tenure
FROM hr
WHERE termdate <= CURDATE() AND termdate <> '0000-00-00' AND age >= 18
GROUP BY department;   


