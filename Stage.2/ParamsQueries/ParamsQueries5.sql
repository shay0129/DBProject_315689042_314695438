SELECT e.Employee_ID, e.Employee_Name, SUM(p.Amount) AS Total_Bonus
FROM Employee e
JOIN Payment p ON e.Employee_ID = p.Employee_ID
WHERE p.Payment_Purpose = 'Bonus'
  AND p.payment_date BETWEEN TO_DATE (&from, 'DD-MM-YYYY') AND TO_DATE (&to, 'DD-MM-YYYY')
GROUP BY e.Employee_ID, e.Employee_Name
HAVING SUM(p.Amount) > (
    SELECT AVG(p2.Amount)
    FROM Payment p2
    WHERE p2.Payment_Purpose = 'Bonus'
       AND p2.payment_date BETWEEN TO_DATE (&from, 'DD-MM-YYYY') AND TO_DATE (&to, 'DD-MM-YYYY')
)
ORDER BY Total_Bonus DESC;
