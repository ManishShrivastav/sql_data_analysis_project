/*
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely.
- Focuses on job postings with specified salaries removing nulls.
- Why? Highlight the top-paying opportunities for Data Analysts, offering insights into
    into employment options and location flexibility.
*/


SELECT	
	job_id,
	job_title,
	job_location,
	job_schedule_type,
	salary_year_avg,
	job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND 
    job_location = 'Des Moines, IA' AND 
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;

/*
Here's the breakdown of the top data analyst jobs in 2023:
Wide Salary Range: Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.
Diverse Employers: Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.
Job Title Variety: There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.

RESULTS
=======
[
  {
    "job_id": 1136013,
    "job_title": "DTCC Data Analyst",
    "job_location": "Des Moines, IA",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "155000.0",
    "job_posted_date": "2023-10-04 14:02:14",
    "company_name": "Robert Half"
  },
  {
    "job_id": 1767366,
    "job_title": "Financial Data Analyst",
    "job_location": "Des Moines, IA",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "130000.0",
    "job_posted_date": "2023-02-07 17:02:01",
    "company_name": "Robert Half"
  },
  {
    "job_id": 186850,
    "job_title": "Lead Data Analyst / SQL Developer",
    "job_location": "Des Moines, IA",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "117500.0",
    "job_posted_date": "2023-10-11 14:01:59",
    "company_name": "Robert Half"
  },
  {
    "job_id": 1238984,
    "job_title": "Data Analytics Lead",
    "job_location": "Des Moines, IA",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "112000.0",
    "job_posted_date": "2023-08-23 22:02:19",
    "company_name": "IBM"
  },
  {
    "job_id": 1484109,
    "job_title": "Data Governance Analyst",
    "job_location": "Des Moines, IA",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "110000.0",
    "job_posted_date": "2023-09-01 02:02:49",
    "company_name": "Robert Half"
  },
  {
    "job_id": 1527665,
    "job_title": "Data Analyst III",
    "job_location": "Des Moines, IA",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "100000.0",
    "job_posted_date": "2023-03-10 15:03:08",
    "company_name": "Insight Global"
  },
  {
    "job_id": 1187796,
    "job_title": "SQL Data Developer / SQL Data Analyst",
    "job_location": "Des Moines, IA",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "90000.0",
    "job_posted_date": "2023-04-09 07:02:53",
    "company_name": "Robert Half"
  },
  {
    "job_id": 1106071,
    "job_title": "Data Analyst",
    "job_location": "Des Moines, IA",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "85000.0",
    "job_posted_date": "2023-11-08 00:02:00",
    "company_name": "Steneral Consulting"
  },
  {
    "job_id": 766479,
    "job_title": "Data Analyst",
    "job_location": "Des Moines, IA",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "75000.0",
    "job_posted_date": "2023-11-04 11:01:50",
    "company_name": "Signature Consultants"
  },
  {
    "job_id": 1092358,
    "job_title": "Data Analyst",
    "job_location": "Des Moines, IA",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "67500.0",
    "job_posted_date": "2023-04-12 17:18:00",
    "company_name": "S&S Employment Partners"
  }
]
*/