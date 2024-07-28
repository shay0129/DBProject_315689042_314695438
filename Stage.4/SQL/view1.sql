-- View 1: SubjectTeacherDetails
CREATE VIEW SubjectTeacherDetails AS
SELECT 
    s.Subject_Name,
    s.students_studying_number,
    s.Difficulty_level,
    t.Employee_ID,
    e.Employee_Name,
    e.Job_Title,
    e.Seniority
FROM 
    Subjects_Taught s
JOIN 
    Teach t ON s.Subject_Name = t.Subject_Name
JOIN 
    Employee e ON t.Employee_ID = e.Employee_ID;


-- Query 1: Total Students and Average Difficulty by Employee
SELECT 
    Employee_ID,
    Employee_Name,
    Job_Title,
    Seniority,
    SUM(students_studying_number) AS Total_Students,
    AVG(Difficulty_level) AS Average_Difficulty
FROM 
    SubjectTeacherDetails
GROUP BY 
    Employee_ID, Employee_Name, Job_Title, Seniority;


-- Query 2: Employees with more than 2 subjects with difficulty level > 4
SELECT 
    Employee_ID,
    Employee_Name,
    COUNT(Subject_Name) AS Number_of_Subjects
FROM 
    SubjectTeacherDetails
WHERE 
    Difficulty_level > 4
GROUP BY 
    Employee_ID, Employee_Name
HAVING 
    COUNT(Subject_Name) > 2;
