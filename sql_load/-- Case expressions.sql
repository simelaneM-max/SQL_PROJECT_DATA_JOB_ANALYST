-- Case expressions 
SELECT
    job_title_short, 
    job_location
FROM  
    job_postings_fact;

/* REclassify where a job is located - 3 conditions

Label new column as follows:
- 'Anywhere' jobs as 'Remote'
- 'New York, NY' jobs as Local 
- Otherwise 'Onsite' 
and how many jobs i can apply to locally, remotely and onsite

*/

SELECT
    job_title_short, 
    job_location,
    CASE 
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM  
    job_postings_fact;

/* REclassify where a job is located - 3 conditions

Label new column as follows:
- 'Anywhere' jobs as 'Remote'
- 'New York, NY' jobs as Local 
- Otherwise 'Onsite' 
and how many jobs i can apply to locally, remotely and onsite

*/

SELECT
   COUNT(job_id) AS number_of_jobs,
    CASE 
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM  
    job_postings_fact
WHERE
    job_title_short = 'Data Scientist'
GROUP BY
    location_category;