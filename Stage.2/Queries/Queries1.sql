SELECT e.Employee_ID, Total_Payment
FROM (
    SELECT p.Employee_ID, SUM(p.Amount) AS Total_Payment
    FROM Payment p
    WHERE EXTRACT(YEAR FROM p.Payment_Date) = EXTRACT(YEAR FROM SYSDATE)
    GROUP BY p.Employee_ID
) pay
JOIN Employee e ON pay.Employee_ID = e.Employee_ID
WHERE pay.Total_Payment = (
    SELECT MAX(SUM(p.Amount))
    FROM Payment p
    WHERE EXTRACT(YEAR FROM p.Payment_Date) = EXTRACT(YEAR FROM SYSDATE)
    GROUP BY p.Employee_ID
);
