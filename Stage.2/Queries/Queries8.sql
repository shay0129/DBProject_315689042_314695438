DELETE FROM Employee
WHERE Employee_ID IN (
    SELECT e.Employee_ID
    FROM Employee e
    LEFT JOIN Payment p ON e.Employee_ID = p.Employee_ID
    LEFT JOIN Orders o ON e.Employee_ID = o.Employee_ID
    WHERE p.Payment_ID IS NULL AND o.Order_ID IS NULL
    AND e.seniority > 8
    AND e.job_title = 'Procurement Manager'
);

SELECT *
FROM Employee e
WHERE Employee_ID IN (
    SELECT e2.Employee_ID
    FROM Employee e2
    LEFT JOIN Payment p ON e2.Employee_ID = p.Employee_ID
    LEFT JOIN Orders o ON e2.Employee_ID = o.Employee_ID
    WHERE p.Payment_ID IS NULL AND o.Order_ID IS NULL
    AND e2.seniority > 8
    AND e2.job_title = 'Procurement Manager'
);
