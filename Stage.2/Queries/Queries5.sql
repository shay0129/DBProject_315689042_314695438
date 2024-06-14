SELECT  COUNT(*)
     FROM (
         SELECT p.Employee_ID, SUM(p.Amount) AS Total_Salary
         FROM Employee e
         JOIN Payment p ON e.Employee_ID = p.Employee_ID
         WHERE p.Payment_Purpose = 'Salary'
         GROUP BY p.Employee_ID
     ) ts
     WHERE ts.Total_Salary < (
         SELECT AVG(ts2.Total_Salary)
         FROM (
             SELECT p.Employee_ID, SUM(p.Amount) AS Total_Salary
             FROM Employee e
             JOIN Payment p ON e.Employee_ID = p.Employee_ID
             WHERE p.Payment_Purpose = 'Salary'
             GROUP BY p.Employee_ID
         ) ts2
    );
