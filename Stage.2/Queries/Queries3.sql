SELECT o.Order_ID,
       (SELECT e.Contact_Information FROM Employee e WHERE e.Employee_ID = o.Employee_ID)
        AS Employee_Email,
       (SELECT s.Contact_Information FROM Supplier s WHERE s.Supplier_ID = o.Supplier_ID)
        AS Supplier_Email
FROM Orders o
WHERE EXISTS (
    SELECT 1 FROM Employee e 
    WHERE e.Employee_ID = o.Employee_ID 
    AND e.Contact_Information LIKE '%@%'
)
AND EXISTS (
    SELECT 1 FROM Supplier s 
    WHERE s.Supplier_ID = o.Supplier_ID 
    AND s.Contact_Information LIKE '%@%'
);
