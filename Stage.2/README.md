16/6/24

•	Shay Mordechai			315689042

•	Yair Miller			314695438

                                                  School Management System

Stage 2:

## Queries

**Select without parameters**

1. The employee with the highest total salary including bonuses.
```sql
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
```
Stage.2\Queries\ScreenShots\first_query.png

2. The employee with the largest number of orders.

```sql
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
```
Stage.2\Queries\ScreenShots\second_query.png

3. Employee and supplier are linked to each other and both have email.

```sql
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
```
Stage.2\Queries\ScreenShots\third_query.png

4. Employees who exceeded the annual budget in the last year by a certain percentage.

```sql
SELECT e.Employee_ID, e.Employee_Name
FROM Employee e
WHERE EXISTS (
    SELECT 1 FROM Orders o
    JOIN Invoice i ON o.Invoice_ID = i.Invoice_ID
    WHERE o.Employee_ID = e.Employee_ID
    AND EXTRACT(YEAR FROM i.Invoice_Date) = EXTRACT(YEAR FROM SYSDATE) - 1
    GROUP BY o.Employee_ID
    HAVING SUM(DISTINCT i.Invoice_Cost) > 0.005 * (
        SELECT SUM(Budget_Amount)
        FROM Budget
        WHERE  Budget_Year = EXTRACT(YEAR FROM SYSDATE) - 1
    )
);
Stage.2\Queries\ScreenShots\four_query.png
```
5. Some workers their salary is less than the average.
```sql
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
```
Stage.2\Queries\ScreenShots\five_query.png

**Update without parameters**

1. Updates a job name for an employee under certain conditions.

```sql
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

```
before

![‏‏צילום מסך (18)](https://github.com/shay0129/DBProject_315689042_314695438/assets/116823605/7ed92f30-2332-4af3-8956-ee0bceabe0c0)

after

![‏‏צילום מסך (19)](https://github.com/shay0129/DBProject_315689042_314695438/assets/116823605/45391057-01b1-4bbe-b277-d6a68da7d027)

2. Increases an Supplier's inventory under certain conditions.
```sql
UPDATE Supplier
SET Inventory = Inventory * 1.10
WHERE Supplier_ID IN (
    SELECT o.Supplier_ID
    FROM Orders o
    JOIN Supplier s ON o.Supplier_ID = s.Supplier_ID
    GROUP BY o.Supplier_ID, s.Inventory
    HAVING SUM(o.Quantity) > 35
    AND ABS(s.Inventory - SUM(o.Quantity)) < 20
);

SELECT *
FROM Supplier s
SET Inventory = Inventory * 1.10
WHERE Supplier_ID IN (
    SELECT o.Supplier_ID
    FROM Orders o
    JOIN Supplier s ON o.Supplier_ID = s.Supplier_ID
    GROUP BY o.Supplier_ID, s.Inventory
    HAVING SUM(o.Quantity) > 35
    AND ABS(s.Inventory - SUM(o.Quantity)) < 20
);
```
before

![‏‏צילום מסך (16)](https://github.com/shay0129/DBProject_315689042_314695438/assets/116823605/e7f8ea3e-1094-496a-8a53-5a0c69ae2baf)

after

![‏‏צילום מסך (17)](https://github.com/shay0129/DBProject_315689042_314695438/assets/116823605/54816b7e-b7b4-41d9-891a-6c620d03544e)

**Delete without parameters**

1. Deletes purchasing managers under certain conditions if they have not made any orders at all.
```sql
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
```
before

![‏‏צילום מסך (20)](https://github.com/shay0129/DBProject_315689042_314695438/assets/116823605/0d4968e6-a486-41b8-95f8-005bb66a6cc6)

after

![‏‏צילום מסך (27)](https://github.com/shay0129/DBProject_315689042_314695438/assets/116823605/af63aad5-106d-4273-aad6-f21b44e5f28f)


2. Deletes all suppliers who have not issued an invoice over 5 in the last 20 years.
```sql
DELETE FROM Supplier
WHERE Supplier_ID NOT IN (
    SELECT DISTINCT s.Supplier_ID
    FROM Orders o
    JOIN Supplier s ON o.Supplier_ID = s.Supplier_ID
    JOIN Invoice i ON o.Invoice_ID = i.Invoice_ID
    WHERE i.Invoice_Cost > 5.0
      AND EXTRACT(YEAR FROM i.Invoice_Date) >= EXTRACT(YEAR FROM SYSDATE) - 20
);

SELECT *
FROM Supplier s
WHERE Supplier_ID NOT IN (
    SELECT DISTINCT s2.Supplier_ID
    FROM Orders o
    JOIN Supplier s2 ON o.Supplier_ID = s2.Supplier_ID
    JOIN Invoice i ON o.Invoice_ID = i.Invoice_ID
    WHERE  i.Invoice_Cost > 5.0
      AND EXTRACT(YEAR FROM i.Invoice_Date) >= EXTRACT(YEAR FROM SYSDATE) - 20
);
```
before

![‏‏צילום מסך (28)](https://github.com/shay0129/DBProject_315689042_314695438/assets/116823605/94685e45-9d44-46f3-9735-62b7fddd63a1)

after

...


## ParamsQueries

1. All suppliers and the identification number of the orders they provided, the user should enter the order quantity date and stock of the order at the supplier.
```sql
SELECT s.Supplier_ID, s.Supplier_Name, o.Order_ID
FROM Orders o
JOIN Supplier s ON o.Supplier_ID = s.Supplier_ID
JOIN Employee e ON o.Employee_ID = e.Employee_ID
JOIN Invoice i ON o.Invoice_ID = i.Invoice_ID
WHERE i.Invoice_Date BETWEEN TO_DATE (&from, 'DD-MM-YYYY') AND TO_DATE (&to, 'DD-MM-YYYY')
 AND o.quantity > &quantityMin 
 AND s.inventory > &inventoryMin
ORDER BY i.Invoice_Date;
```
Stage.2\ParamsQueries\ScreenShots\first_ParamsQuery.png

2. All employees who ordered from a certain supplier, the user must enter the name of the supplier and data about the employee.
```sql
SELECT e.Employee_ID, e.Employee_Name
FROM Orders o
JOIN Supplier s ON o.Supplier_ID = s.Supplier_ID
JOIN Employee e ON o.Employee_ID = e.Employee_ID
WHERE e.job_title =  &< name = "title" list =  "Budget Committee, Procurement Manager, Worker" type = "string" > 
 AND e.seniority = &< name = �seniority� list = "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20" > 
 AND s.supplier_name = &< name = �supplierName� list = "SELECT DISTINCT Supplier_Name FROM Supplier" type = "string" >
ORDER BY e.Employee_ID;
```
Stage.2\ParamsQueries\ScreenShots\second_ParamsQuery.png

3. A vendor with invoice prices for orders it has supplied, the user must enter date and order details.
```sql
SELECT s.supplier_id, s.Supplier_Name, i.Invoice_Cost
FROM Invoice i
JOIN Supplier s ON i.Supplier_ID = s.Supplier_ID
WHERE i.Invoice_Date BETWEEN TO_DATE (&from, 'DD-MM-YYYY') AND TO_DATE (&to, 'DD-MM-YYYY')
 AND i.invoice_cost = &< name = "cost" list = "SELECT DISTINCT Invoice_Cost FROM Invoice" >
ORDER BY i.Invoice_Cost DESC;
```
Stage.2\ParamsQueries\ScreenShots\third_ParamsQuery.png

4. Employees who exceeded the annual budget in the last year by a certain percentage.
```sql
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
```
Stage.2\ParamsQueries\ScreenShots\four_ParamsQuery.png

5. All employees whose bonus price they received in a certain year is greater than the average of the bonuses received in that year.
```sql
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
```
Stage.2\ParamsQueries\ScreenShots\five_ParamsQuery.png

## Constraint

1. CHECK - 
```sql
-- Constraint for Employee table
ALTER TABLE Employee
MODIFY Seniority DEFAULT 0;
```

checks:


2. NOT NULL - 
```sql
-- Constraint for Invoice table
ALTER TABLE Invoice
ADD CONSTRAINT Invoice_Cost
CHECK Invoice_Cost > 0 and Invoice_Cost < 10000;
```

3. CHECK - 
```sql
-- Constraint for Orders table
ALTER TABLE Orders
MODIFY Quantity DEFAULT 1;
```
