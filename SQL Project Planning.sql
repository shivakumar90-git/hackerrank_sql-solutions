WITH ranked_tasks AS (
  SELECT 
    Start_Date,
    End_Date,
    ROW_NUMBER() OVER (ORDER BY Start_Date) as rn
  FROM Projects
),
grouped_tasks AS (
  SELECT 
    Start_Date,
    End_Date,
    Start_Date - rn as group_id
  FROM ranked_tasks
),
project_groups AS (
  SELECT 
    group_id,
    MIN(Start_Date) as project_start,
    MAX(End_Date) as project_end,
    MAX(End_Date) - MIN(Start_Date) + 1 as project_days
  FROM grouped_tasks
  GROUP BY group_id
)
SELECT 
  project_start,
  project_end
FROM project_groups
ORDER BY project_days ASC, project_start ASC;
