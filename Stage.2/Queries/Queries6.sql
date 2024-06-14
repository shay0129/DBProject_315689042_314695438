UPDATE Employee
SET Job_Title = 'Worker'
WHERE Seniority < 5
  AND Employee_ID IN (
    SELECT p.Employee_ID
    FROM Payment p
    WHERE EXTRACT(YEAR FROM p.Payment_Date) = EXTRACT(YEAR FROM SYSDATE)
    GROUP BY p.Employee_ID
    HAVING SUM(p.Amount) < 4500
);

Select *
FROM Employee e
WHERE Seniority < 5
  AND (Job_Title = 'Budget Committee' OR Job_Title = 'Procurement Manager')
  AND Employee_ID IN (
    SELECT p.Employee_ID
    FROM Payment p
    WHERE EXTRACT(YEAR FROM p.Payment_Date) = EXTRACT(YEAR FROM SYSDATE)
    GROUP BY p.Employee_ID
    HAVING SUM(p.Amount) < 4500
);
