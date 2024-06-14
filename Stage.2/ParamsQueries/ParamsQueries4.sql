SELECT e.Employee_ID, e.Employee_Name
FROM Employee e
WHERE EXISTS (
    SELECT 1 FROM Orders o
    JOIN Invoice i ON o.Invoice_ID = i.Invoice_ID
    WHERE o.Employee_ID = e.Employee_ID
    AND EXTRACT(YEAR FROM i.Invoice_Date) = EXTRACT(YEAR FROM SYSDATE) - 1
    GROUP BY o.Employee_ID
    HAVING SUM(DISTINCT i.Invoice_Cost) > &percents * (
        SELECT SUM(Budget_Amount)
        FROM Budget
        WHERE  Budget_Year = EXTRACT(YEAR FROM SYSDATE) - 1
    )
);
