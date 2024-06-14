SELECT Employee_ID, Employee_Name, Order_Count
FROM (
    SELECT e.Employee_ID, e.Employee_Name, COUNT(o.Order_ID) AS Order_Count
    FROM Orders o
    JOIN Employee e ON o.Employee_ID = e.Employee_ID
    GROUP BY e.Employee_ID, e.Employee_Name
) t
WHERE Order_Count = (
    SELECT MAX(Order_Count)
    FROM (
        SELECT COUNT(o.Order_ID) AS Order_Count
        FROM Orders o
        GROUP BY o.Employee_ID
    ) max_order
);
