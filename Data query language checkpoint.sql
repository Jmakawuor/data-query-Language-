use employeeparticipationdb;
select * from department;
-- Switch to the correct database
USE employeeparticipationDB;

-- 1. Employees assigned to more than one project
SELECT 
    e.Name,
    COUNT(ep.Project_Num_P) AS Project_Count
FROM 
    Employee e
JOIN 
    Employee_Project ep ON e.Num_E = ep.Employee_Num_E
GROUP BY 
    e.Num_E, e.Name
HAVING 
    COUNT(ep.Project_Num_P) > 1;

-- 2. Projects managed by each department
SELECT 
    d.Label AS Department_Label,
    d.Manager_Name,
    p.Title AS Project_Title
FROM 
    Department d
JOIN 
    Project p ON d.Num_S = p.Department_Num_S;

-- 3. Employees working on "Website Redesign" and their roles
SELECT 
    e.Name,
    ep.Role
FROM 
    Employee e
JOIN 
    Employee_Project ep ON e.Num_E = ep.Employee_Num_E
JOIN 
    Project p ON ep.Project_Num_P = p.Num_P
WHERE 
    p.Title = 'Website Redesign';

-- 4. Department with the highest number of employees
SELECT 
    d.Label AS Department_Label,
    d.Manager_Name,
    COUNT(e.Num_E) AS Employee_Count
FROM 
    Department d
JOIN 
    Employee e ON d.Num_S = e.Department_Num_S
GROUP BY 
    d.Num_S, d.Label, d.Manager_Name
ORDER BY 
    Employee_Count DESC
LIMIT 1;

-- 5. Employees earning salary > 60,000 and their department names
SELECT 
    e.Name,
    e.Position,
    e.Salary,
    d.Label AS Department_Label
FROM 
    Employee e
JOIN 
    Department d ON e.Department_Num_S = d.Num_S
WHERE 
    e.Salary > 60000;

-- 6. Number of employees assigned to each project
SELECT 
    p.Title AS Project_Title,
    COUNT(ep.Employee_Num_E) AS Employee_Count
FROM 
    Project p
LEFT JOIN 
    Employee_Project ep ON p.Num_P = ep.Project_Num_P
GROUP BY 
    p.Num_P, p.Title;

-- 7. Summary of roles employees have across projects
SELECT 
    e.Name AS Employee_Name,
    p.Title AS Project_Title,
    ep.Role
FROM 
    Employee_Project ep
JOIN 
    Employee e ON ep.Employee_Num_E = e.Num_E
JOIN 
    Project p ON ep.Project_Num_P = p.Num_P;

-- 8. Total salary expenditure for each department
SELECT 
    d.Label AS Department_Label,
    d.Manager_Name,
    SUM(e.Salary) AS Total_Salary_Expenditure
FROM 
    Department d
JOIN 
    Employee e ON d.Num_S = e.Department_Num_S
GROUP BY 
    d.Num_S, d.Label, d.Manager_Name;
