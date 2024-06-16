# Introduction
Delve into the data job market! This project focuses on data analyst roles, exploring 💰 top-paying positions, 🔥 in-demand skills, and 📈 where demand intersects with high salaries in data analytics.

🔍 Interested in SQL queries? Explore them in the [project_sql folder](/project_sql/).

# Background
Background
Motivated by the need to navigate the data analyst job market effectively, this project aims to identify top-paying roles and sought-after skills, streamlining job search efforts for others.

Data was sourced from [huggingface](https://huggingface.co/datasets/lukebarousse/data_jobs), providing insights into job titles, salaries, locations, and essential skills.

### Key Questions: Through my SQL queries, I sought to answer the following questions:
1. What are the highest-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills correlate with higher salaries?
5. Which skills should job seekers prioritize learning?

# Tools I Used
To conduct a thorough analysis of the data analyst job market, I utilized several key tools:

* **SQL:** Essential for querying the database and uncovering critical insights.
* **PostgreSQL:** Chosen for its robustness in managing job posting data.
* **Visual Studio Code:** Used for database management and executing SQL queries.
* **Git & GitHub:** Utilized for version control, sharing SQL scripts, and facilitating collaboration.

# The Analysis

Each SQL query in this project was designed to explore specific aspects of the data analyst job market:

**1. Top Paying Data Analyst Jobs**

Identified the highest-paying roles by filtering data analyst positions based on average yearly salary and remote work availability.

```sql
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
```
Findings of the top data analyst jobs in 2023:
- **Wide Salary Range:** The top 10 highest-paying data analyst roles range from $184,000 to $650,000 annually, highlighting substantial earning potential in this field.
- **Diverse Employers:** Companies such as SmartAsset, Meta, and AT&T are among those providing lucrative salaries, indicating widespread interest across diverse industries.
- **Job Title Variety:** There is a wide array of job titles, ranging from Data Analyst to Director of Analytics, showcasing the diversity of roles and specialized areas within the field of data analytics.

**2. Skills for Top Paying Jobs**

Analyzed the skills required for the top-paying data analyst roles by joining job postings with skills data, highlighting key competencies.

```sql
WITH top_paying_jobs AS (
    SELECT	
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND 
        job_location = 'Anywhere' AND 
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
```
Findings for most demanded skills for data analysts in 2023, based on job postings:
- **SQL:** SQL (Structured Query Language) stands out as the predominant skill across all roles, underscoring its critical **role in database querying and deriving insights, fundamental to data analysis.
- **Python:** Python also features prominently, highlighting its importance in data manipulation, statistical analysis, and **potentially automating tasks within data analysis workflows.
- **Tableau:** The frequent mention of Tableau points to a robust demand for data visualization skills, crucial for **effectively communicating insights to stakeholders through interactive dashboards and reports.
- **Excel:** Despite its conventional nature, Excel continues to hold relevance, particularly for tasks such as data cleaning, basic analysis, and reporting.

**3. In-Demand Skills for Data Analysts**

Identified the most frequently requested skills in data analyst job postings, focusing on roles that offer remote work opportunities.

```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND job_work_from_home = True 
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;
```

Insights on the most sought-after skills for data analysts in 2023 include:
- **SQL** and **Excel** retain their fundamental importance, highlighting the necessity for robust skills in data processing and spreadsheet management.
- **Programming** and **visualization tools** such as **Python**, **Tableau**, and **Power BI** are indispensable, underscoring the growing significance of technical expertise in data visualization, storytelling, and decision support.

| Skills   | Demand Count |
|----------|--------------|
| SQL      | 7291         |
| Excel    | 4611         |
| Python   | 4330         |
| Tableau  | 3745         |
| Power BI | 2609         |

*Table of the demand for the top 5 skills in data analyst job postings.*

**4. Skills Based on Salary**

Explored average salaries associated with different skills to reveal which skills are most financially rewarding for data analysts.

```sql
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;
```

Insights for top paying skills for Data Analysts:
- **High Demand for Big Data & ML Skills:** Top salaries are commanded by analysts skilled in big data technologies 
(PySpark, Couchbase), machine learning tools (DataRobot, Jupyter), and Python libraries (Pandas, NumPy), 
reflecting the industry's high valuation of data processing and predictive modeling capabilities.
- **Software Development & Deployment Proficiency:** Knowledge in development and deployment tools 
(GitLab, Kubernetes, Airflow) indicates a lucrative crossover between data analysis and engineering, with a 
premium on skills that facilitate automation and efficient data pipeline management.
- **Cloud Computing Expertise:** Familiarity with cloud and data engineering tools (Elasticsearch, Databricks, GCP) 
underscores the growing importance of cloud-based analytics environments, suggesting that cloud proficiency 
significantly boosts earning potential in data analytics.

| Skills        | Average Salary ($) |
|---------------|-------------------:|
| pyspark       |            208,172 |
| bitbucket     |            189,155 |
| couchbase     |            160,515 |
| watson        |            160,515 |
| datarobot     |            155,486 |
| gitlab        |            154,500 |
| swift         |            153,750 |
| jupyter       |            152,777 |
| pandas        |            151,821 |
| elasticsearch |            145,000 |

*Table of the average salary for the top 10 paying skills for data analysts*

**5. Most Optimal Skills to Learn**

Pinpointed skills that are both in high demand and offer high salaries, providing strategic insights for skill development.

```sql
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```

Insights for most optimal skills:
- **High-Demand Programming Languages:** Python and R stand out due to their significant demand, with 236 and 148 mentions respectively. Despite their popularity, their average salaries hover around $101,397 for Python and $100,499 for R, indicating that proficiency in these languages is highly valued yet widely available.

- **Cloud Tools and Technologies:** Specialized technologies like Snowflake, Azure, AWS, and BigQuery are in high demand, correlating with relatively high average salaries. This trend underscores the increasing importance of cloud platforms and big data technologies in modern data analysis.

- **Business Intelligence and Visualization Tools:** Tableau and Looker are highly sought after, with 230 and 49 mentions respectively. They command average salaries of approximately $99,288 and $103,795, emphasizing their crucial role in visualizing data and extracting actionable insights.

- **Database Technologies:** Skills in traditional and NoSQL databases such as Oracle, SQL Server, and NoSQL remain in demand, with average salaries ranging from $97,786 to $104,534. This reflects the enduring necessity for expertise in data storage, retrieval, and management.


| Skill ID | Skills     | Demand Count | Average Salary ($) |
|----------|------------|--------------|-------------------:|
| 8        | go         | 27           |            115,320 |
| 234      | confluence | 11           |            114,210 |
| 97       | hadoop     | 22           |            113,193 |
| 80       | snowflake  | 37           |            112,948 |
| 74       | azure      | 34           |            111,225 |
| 77       | bigquery   | 13           |            109,654 |
| 76       | aws        | 32           |            108,317 |
| 4        | java       | 17           |            106,906 |
| 194      | ssis       | 12           |            106,683 |
| 233      | jira       | 20           |            104,918 |

*Table of the most optimal skills for data analyst sorted by salary*

# What I learned
Through this project, I enhanced my SQL proficiency and gained valuable insights:

* Mastered complex SQL queries for data aggregation and analysis.
* Developed analytical skills to derive actionable insights from real-world datasets.
* Identified critical skills and trends in the data analyst job market to guide career decisions.

# Conclusions
Insights from the analysis include:

* Top-Paying Data Analyst Jobs offer a wide salary range, with remote work options and salaries reaching up to $650,000.
* SQL emerges as a critical skill for top-paying and in-demand data analyst roles.
* Specialized skills command higher salaries, reflecting the premium on niche expertise.
* Continuous learning and adaptation to emerging trends are crucial for success in the data analytics field.

This project not only advanced my SQL capabilities but also provided a roadmap for navigating the competitive data analyst job market. The insights gained can help aspiring data analysts prioritize skill development and optimize job search strategies. Adaptability and ongoing learning remain essential in capitalizing on opportunities in the dynamic field of data analytics.