SELECT job_posted_date
FROM job_postings_fact
LIMIT 10;


SELECT 
    '2023-02-19'::DATE,
    '123' ::INTEGER,
    'true' ::BOOLEAN,
    '3.14' ::REAL;

    -- ORGINIAL 
SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date AS date_time
FROM
    job_postings_fact
LIMIT 5;

-- DATE 
SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date:: DATE AS date
FROM
    job_postings_fact;

    -- TIMESTAMPS
SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time
FROM 
    job_postings_fact
    LIMIT 5;

-- EXTRACT 
SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time, 
    EXTRACT(MONTH FROM job_posted_date) AS date_month,
    EXTRACT(YEAR FROM job_posted_date) AS date_year
FROM 
    job_postings_fact
LIMIT 5;

-- for example we want to track how job postings are trending from month to month (adding count and groupby  we are seeing how many job were posted the particular month and we grooping by month)
SELECT 
    COUNT(job_id), 
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM
    job_postings_fact
GROUP BY
    month;

-- now we want to see number of jobs posted in each month and want to see only for data analyt 
SELECT 
    COUNT(job_id) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date) AS month 
FROM 
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY
    month
ORDER BY
    job_posted_count DESC;

PROBLEM 1 - Write a query to find the average salary both yearly (salary_year_avg) and hourly (salary_hourly_avg) for job postings that were posted after JUNE 1, 2023. Group by job schedule type.
SELECT 
    job_schedule_type,
    AVG(salary_year_avg) AS salary_yearly,
    AVG(salary_hour_avg) AS salary_hourly
FROM
    job_postings_fact
WHERE    
job_posted_date > '2023-06-01'
GROUP BY
    job_schedule_type
ORDER BY
    salary_yearly DESC;


-- Problem 2 - Write a query to count the number of job posting for each month in 2023, adjusting the job_posted_date to be in 'America/New_York' time zone before extracting (hint) the month. Assume the job_posted_date is stored in UTC. Group by and order by the month.
SELECT
    COUNT(job_id) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS month
FROM
    job_postings_fact
WHERE       
    job_posted_date >= '2023-01-01' AND job_posted_date < '2024-01-01'
GROUP BY
    month
ORDER BY            
    month;

-- Write a query to find companies (include company name) that have posted jobs offering health insurance, where these postings were made in the second quarter of 2023. Use date extraction to filter by quarter. 
SELECT 
    name,
    COUNT(job_id) AS job_posted_count
FROM
    job_postings_fact
JOIN
    company_dim ON job_postings.company_id = company_dim.company_id
WHERE
    health_insurance = true AND
    EXTRACT(QUARTER FROM job_posted_date) = 2 AND
    EXTRACT(YEAR FROM job_posted_date) = 2023
GROUP BY
    name
ORDER BY
    job_posted_count DESC;  

/* Create three tables:
   Jan 2023 jobs
   Feb 2023 jobs
    Mar 2023 jobs
Foreshadowing: This will be used in another practice problem below.
Hints:
- Use CREATE TABLE table_name AS syntax to create your table.
-Look at a way to filter out only specific months (EXTRACT). 
*/

SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date)= 1
LIMIT 10;

-- january 2023
CREATE TABLE january_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;  

-- february 2023
CREATE TABLE february_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

-- march 2023
CREATE TABLE march_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

-- to check if the tables were created successfully

SELECT job_posted_date
FROM january_jobs;
