-- View 2: StudentActivityDetails
CREATE VIEW StudentActivityDetails AS
SELECT 
    a.activity_id,
    a.date_of_activity,
    a.activity_name,
    a.capacity,
    st.student_id,
    st.student_name,
    st.grade,
    st.counselor_id
FROM 
    Activity a
JOIN 
    Active ac ON a.activity_id = ac.activity_id
JOIN 
    Student st ON ac.student_id = st.student_id;

-- Query 1: Total Students and Average Grade by Activity
SELECT 
    activity_id,
    activity_name,
    COUNT(student_id) AS Total_Students,
    AVG(grade) AS Average_Grade
FROM 
    StudentActivityDetails
GROUP BY 
    activity_id, activity_name;

-- Query 2: Activities with more than 20 students and average grade > 8
SELECT 
    activity_id,
    activity_name,
    COUNT(student_id) AS Number_of_Students,
    AVG(grade) AS Average_Grade
FROM 
    StudentActivityDetails
GROUP BY 
    activity_id, activity_name
HAVING 
    COUNT(student_id) > 20 AND AVG(grade) > 8;
