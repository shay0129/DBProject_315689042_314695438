
•	Shay Mordechai			315689042

•	Yair Miller			314695438

                                                  School Management System
3/6/24

## Stage 1:

## Description:

This system is designed to manage a school's administrative operations, including employee information, budgeting, procurement, and financial transactions.

Data Entities:

•	__Employee__ (***Employee_ID***,Employee_Name, Seniority, Contact_Information, Job_Title)

•	__Budget__ (***Budget_Code***, _Employee_ID_, Expense_Category, Budget_Amount, Budget_Year)

•	__Supplier__ (***Supplier_ID***, Supplier_Name, Contact_Information, Inventory)

•	__Invoice__ (***Invoice_ID***, _Supplier_ID_, Invoice_Cost, Invoice_Date)

•	__Orders__ (***Order_ID***, _Supplier_ID_, _Employee_ID_, Invoice_ID, Quantity)

•	__Payment__ (***Payment_ID***, _Employee_ID_, Amount, Payment_Purpose, Payment_Date)


**Relationships:**

• An ***Employee*** may be associated with multiple ***Budgets*** (via Employee_ID in Budget).

• An ***Employee*** can initiate multiple Orders and receive multiple ***Payments*** (via Employee_ID in Orders and Payment).

• A ***Supplier*** can have multiple ***Orders*** placed with them (via Supplier_ID in Orders).

• Each ***Order*** is tied to a single Supplier and a single ***Invoice*** (via Supplier_ID and Order_ID in foreign keys).

• Each ***Invoice*** is linked to a single ***Order*** (via Order_ID in foreign key).

• Each ***Supplier*** must have exactly one Invoice associated with them, and each Invoice must be associated with exactly one ***Supplier***.

**Functionality:**

This database schema allows you to manage various aspects of a school's financial operations:

• Record and manage employee information, including their roles and contact details.

• Define and track budgets allocated to different expense categories, ensuring efficient financial management.

• Maintain supplier details, including their names, contact information, and inventory levels (if applicable).

• Create and manage purchase orders placed with suppliers, tracking details such as order quantities and delivery dates.

• Process invoices received from suppliers for placed orders, ensuring accurate billing and payment reconciliation.

• Record payments made to employees for salaries, bonuses, or grants, enabling efficient payroll processing and financial reporting.

## ERD:
 ![Entity-Relationship Diagram](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.1/ERD/ERD.png)

The ERD was chosen to accurately represent the key components and relationships involved in the procurement process, employee payroll process, and budget management process.

1. Procurement Process:

Suppliers, Orders, Invoices.

2. Employee Payroll Process:

Employees, Payments, Budget.

3. Management Process:

Budgets, Employees.


## DSD:
 !["Data Structure Diagram"](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.1/DSD/DSD.png)

## Create Tables:
```sql
CREATE TABLE Employee (
   Employee_ID NUMBER(4) PRIMARY KEY,
   Employee_Name VARCHAR(30),
   Seniority NUMBER(5),
   Contact_Information VARCHAR(50),
   Job_Title  VARCHAR(30) CHECK (Job_Title IN ('Budget Committee', 'Procurement Manager', 'Worker'))
);

CREATE TABLE Budget (
   Budget_Code INT PRIMARY KEY,
   Employee_ID NUMBER(4), -- Each budget must be associated with an employee
   Expense_Category VARCHAR(50),
   Budget_Amount DECIMAL(10,2),
   Budget_Year NUMBER(4),
   FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);

CREATE TABLE Supplier (
   Supplier_ID INT PRIMARY KEY,
   Supplier_Name VARCHAR(30),
   Contact_Information VARCHAR(50),
   Inventory DECIMAL(10,2)
);

CREATE TABLE Invoice (
   Invoice_ID INT PRIMARY KEY,
   Supplier_ID INT, -- Each invoice must be associated with a supplier
   Invoice_Cost DECIMAL(10,2),
   Invoice_Date DATE,
   FOREIGN KEY (Supplier_ID) REFERENCES Supplier(Supplier_ID)
);

CREATE TABLE Orders (
   Order_ID INT PRIMARY KEY,
   Supplier_ID INT, -- Each order must be associated with a supplier
   Employee_ID INT, -- Each order must be associated with an employee
   Invoice_ID INT NOT NULL, -- Ensuring Invoice_ID is mandatory
   Quantity INT,
   FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID),
   FOREIGN KEY (Supplier_ID) REFERENCES Supplier(Supplier_ID),
   FOREIGN KEY (Invoice_ID) REFERENCES Invoice(Invoice_ID)
);

CREATE TABLE Payment (
   Payment_ID INT PRIMARY KEY,
   Employee_ID INT, -- Each payment must be associated with an employee
   Amount DECIMAL(10,2),
   Payment_Purpose VARCHAR(20) CHECK (Payment_Purpose IN ('Salary', 'Bonus', 'Grant')),
   Payment_Date DATE,
   FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);
```
## Desc. commands:
1. Employee:

!["Employee Table"](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.1/SQL/DESC/Employee.png)

2. Budget:

!["Budget Table"](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.1/SQL/DESC/Budget.png)

3. Supplier:

!["Supplier Table"](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.1/SQL/DESC/Supplier.png)

4. Invoice:

!["Invoice Table"](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.1/SQL/DESC/Invoice.png)

5. Orders:

!["Orders Table"](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.1/SQL/DESC/Orders.png)

6. Payment:

!["Payment Table"](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.1/SQL/DESC/Payment.png)

## Data Generate – Three Ways:
1. Employee:

![alt text](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.1/DataImporterFiles/GENERATE/Employee.png)

2. Budget:

![alt text](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.1/DataImporterFiles/GENERATE/Budget.png)

3. Supplier:

![alt text](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.1/DataImporterFiles/GENERATE/Supplier.png)

4. Invoice:

![alt text](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.1/DataImporterFiles/GENERATE/Invoice.png)

5. Orders:

![alt text](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.1/DataImporterFiles/GENERATE/Orders.png)

6. Payment:

![alt text](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.1/DataImporterFiles/GENERATE/Payment.png)

## Text Importer - PLSQL:

1. Employee:

!["Employee – 500 records."](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.1/DataImporterFiles/IMPORT/Employee.png)
 
 2. Budget:

!["Budget – 482 records."](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.1/DataImporterFiles/IMPORT/Budget.png)

3. Supplier:

![Supplier – 500 records.](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.1/DataImporterFiles/GENERATE/Supplier.png)
 
 4. Invoice:

!["Invoice – 500 records."](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.1/DataImporterFiles/IMPORT/Invoice.png)
 
 5. Orders:

!["Orders – 497 records."](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.1/DataImporterFiles/IMPORT/Orders.png)

6. Payment:

!["Payment – 499 records."](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.1/DataImporterFiles/IMPORT/Payment.png)

## Backup & Recovery

!["Backup Screenshot"](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.1/Backup/backup.png)

!["Backup Screenshot"](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.1/Backup/recovery.png)

16/6/24

## Stage 2:

## Queries

**Select without parameters:**

1. The employee with the highest total salary including bonuses.
```sql
-- Query 1: Find the employee who has received the highest total payment in the current year.
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
![first query](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.2/ScreenShots/Queries/first_query.png)

2. The employee with the largest number of orders.
```sql
-- Query 2: Find the employee who has the most orders. Return the employee ID, employee name, and the number of orders. If there are multiple employees with the same number of orders, return all of them.
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
![second query](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.2/ScreenShots/Queries/second_query.png)

3. Employee and supplier are linked to each other and both have email.
```sql
-- Query 3: Get the email addresses of the employees and suppliers involved in orders where both the employee and supplier have an email address. The result should include the order ID, employee email, and supplier email.
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
![third query](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.2/ScreenShots/Queries/third_query.png)

4. Employees who exceeded the annual budget in the last year by a certain percentage.

```sql
-- Query 4: List the employees who have generated revenue greater than 0.5% of the budget for the previous year.
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
```
![four query](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.2/ScreenShots/Queries/four_query.png)

5. Some workers their salary is less than the average.
```sql
-- Query 5: Find the number of employees whose total salary is less than the average salary of all employees.
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
![five query](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.2/ScreenShots/Queries/five_query.png)

**Update without parameters:**

6. Updates a job name for an employee under certain conditions.

```sql
-- Query 6: Update the job title of employees with a seniority of less than 5 years to 'Worker' if they have received less than 4500 in payments in the current year. Also, list the employees with a seniority of less than 5 years and a job title of 'Budget Committee' or 'Procurement Manager' who have received less than 4500 in payments in the current year.
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

7. Increases an Supplier's inventory under certain conditions.
```sql
-- Query 7: Update the inventory of suppliers by 10% if the supplier has more than 35 orders and the difference between the inventory and the total quantity of orders is less than 20. Return the updated inventory of the suppliers.
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

**Delete without parameters:**

8. Deletes purchasing managers under certain conditions if they have not made any orders at all.
```sql
-- Query 8: Delete all Procurement Managers with seniority greater than 8 years who have not made any payments or received any orders.
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


9. Deletes all suppliers who have not issued an invoice over 5 in the last 20 years.
```sql
-- Query 9: Delete all suppliers that have not supplied any orders with an invoice cost greater than $5.00 in the last 20 years.
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

(less)

## ParamsQueries

1. All suppliers and the identification number of the orders they provided, the user should enter the order quantity date and stock of the order at the supplier.
```sql
-- Query 1: Find all orders that were made between two dates, with a quantity greater than a given value, and a supplier with an inventory greater than a given value. Return the supplier ID, supplier name, and order ID. Order the results by the invoice date.
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
![first ParamsQuery](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.2/ScreenShots/ParamsQueries/first_ParamsQuery.png)

2. All employees who ordered from a certain supplier, the user must enter the name of the supplier and data about the employee.
```sql
-- Query 2: Find the employee who has the most orders. Return the employee ID, employee name, and the number of orders. If there are multiple employees with the same number of orders, return all of them.
SELECT e.Employee_ID, e.Employee_Name
FROM Orders o
JOIN Supplier s ON o.Supplier_ID = s.Supplier_ID
JOIN Employee e ON o.Employee_ID = e.Employee_ID
WHERE e.job_title =  &< name = "title" list =  "Budget Committee, Procurement Manager, Worker" type = "string" > 
 AND e.seniority = &< name = �seniority� list = "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20" > 
 AND s.supplier_name = &< name = �supplierName� list = "SELECT DISTINCT Supplier_Name FROM Supplier" type = "string" >
ORDER BY e.Employee_ID;
```
![second ParamsQuery](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.2/ScreenShots/ParamsQueries/second_ParamsQuery.png)

3. A vendor with invoice prices for orders it has supplied, the user must enter date and order details.
```sql
-- Query 3: Display the supplier ID, supplier name, and invoice cost for all invoices between two dates, where the invoice cost is equal to a user-defined value. Order the results by invoice cost in descending order.
SELECT s.supplier_id, s.Supplier_Name, i.Invoice_Cost
FROM Invoice i
JOIN Supplier s ON i.Supplier_ID = s.Supplier_ID
WHERE i.Invoice_Date BETWEEN TO_DATE (&from, 'DD-MM-YYYY') AND TO_DATE (&to, 'DD-MM-YYYY')
 AND i.invoice_cost = &< name = "cost" list = "SELECT DISTINCT Invoice_Cost FROM Invoice" >
ORDER BY i.Invoice_Cost DESC;
```
![third ParamsQuery](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.2/ScreenShots/ParamsQueries/third_ParamsQuery.png)

4. Employees who exceeded the annual budget in the last year by a certain percentage.
```sql
-- Query 4: Find the employees who have generated more than a certain percentage of the budget in the previous year. The percentage is a parameter that the user can input
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
![four ParamsQuery](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.2/ScreenShots/ParamsQueries/four_ParamsQuery.png)

5. All employees whose bonus price they received in a certain year is greater than the average of the bonuses received in that year.
```sql
-- Query 5: Find all employees who have received a bonus between two dates, where the total bonus received is greater than the average bonus received between those dates. Return the employee ID, employee name, and total bonus received. Order the results by the total bonus received in descending order.
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
![five ParamsQuery](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.2/ScreenShots/ParamsQueries/five_ParamsQuery.png)

## Constraints

1. **Constraint for Employee table:**
```sql
-- Constraint for Employee table
ALTER TABLE Employee
ADD CONSTRAINT Job_Title
CHECK (Job_Title IN ('Budget Committee', 'Procurement Manager', 'Worker'));
```
**prove:**

![first prove](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.2/ScreenShots/Constraints/first_prove.png)

2. **Constraint for Orders table:**
```sql
-- Constraint for Orders table
ALTER TABLE Orders
MODIFY Quantity DEFAULT 1;
```

3. **Constraint for Payment table:**
```sql
-- Constraint for Payment table
ALTER TABLE Payment
ADD CONSTRAINT Payment_Purpose
CHECK (Payment_Purpose IN ('Salary', 'Bonus', 'Grant'));
```
**prove:**

![third prove](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.2/ScreenShots/Constraints/third_prove.png)

## Stage 3:

1. **Budget**

```sql
CREATE OR REPLACE FUNCTION calculate_budget_total(
    p_employee_id NUMBER, 
    p_budget_year NUMBER, 
    p_expense_category VARCHAR2
) 
RETURN NUMBER 
IS
    v_total_budget NUMBER := 0; 
BEGIN
    SELECT NVL(SUM(BUDGET_AMOUNT), 0)  -- Use NVL to handle NULL cases
    INTO v_total_budget
    FROM Budget
    WHERE EMPLOYEE_ID = p_employee_id
      AND BUDGET_YEAR = p_budget_year
      AND EXPENSE_CATEGORY = p_expense_category;

    RETURN v_total_budget;
END calculate_budget_total;
/
```
**Procedures:** Update budget's amount
```sql
CREATE OR REPLACE PROCEDURE update_budget_amount(
    p_employee_id NUMBER, 
    p_budget_year NUMBER, 
    p_expense_category VARCHAR2, 
    p_new_amount NUMBER
)
IS
BEGIN
    UPDATE Budget
    SET BUDGET_AMOUNT = p_new_amount
    WHERE EMPLOYEE_ID = p_employee_id
      AND BUDGET_YEAR = p_budget_year
      AND EXPENSE_CATEGORY = p_expense_category;

    -- Optionally, you can choose to commit here if this procedure is standalone and handles its own transactions.
    -- COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred in update_budget_amount: ' || SQLERRM);
        -- Optionally, you could handle rollback here if needed.
        -- ROLLBACK;
        RAISE;
END update_budget_amount;
/


CREATE OR REPLACE PROCEDURE list_budget_items(
    p_employee_id NUMBER, 
    p_budget_year NUMBER
)
IS -- IS: Declare the procedure
    CURSOR budget_cursor IS -- IS: Declare a cursor
        SELECT EXPENSE_CATEGORY, BUDGET_AMOUNT
        FROM Budget
        WHERE EMPLOYEE_ID = p_employee_id
          AND BUDGET_YEAR = p_budget_year;
   
    budget_rec budget_cursor%ROWTYPE; -- Record type to hold cursor data
BEGIN
    OPEN budget_cursor;
    LOOP
        FETCH budget_cursor INTO budget_rec; -- Fetch into the record type, because the cursor is strongly typed.
        EXIT WHEN budget_cursor%NOTFOUND; -- Exit the loop when no more rows are found.
        DBMS_OUTPUT.PUT_LINE('Category: ' || budget_rec.EXPENSE_CATEGORY || ', Amount: ' || budget_rec.BUDGET_AMOUNT);
    END LOOP;
    CLOSE budget_cursor;
END list_budget_items;
/
```
**Main:**
```sql
DECLARE
   v_employee_id NUMBER := 1500;
   v_budget_year NUMBER := 2014;
   v_expense_category VARCHAR2(50) := 'Rent or Lease Payments';
   v_total_budget NUMBER;
   v_new_amount NUMBER := 15000;
   v_threshold NUMBER := 10000;
BEGIN
   -- Call the function to get the total budget
   v_total_budget := calculate_budget_total(v_employee_id, v_budget_year, v_expense_category);
   DBMS_OUTPUT.PUT_LINE('Total budget for employee ID ' || v_employee_id || ' in year ' || v_budget_year || ' for category ' || v_expense_category || ': ' || v_total_budget);

   -- Check if the total budget is below the threshold
   IF v_total_budget < v_threshold THEN
      -- Call the procedure to update the budget amount
      update_budget_amount(v_employee_id, v_budget_year, v_expense_category, v_new_amount);
      DBMS_OUTPUT.PUT_LINE('Budget amount updated for year ' || v_budget_year || ' and category ' || v_expense_category || ' to ' || v_new_amount);
   ELSE
      DBMS_OUTPUT.PUT_LINE('No update needed. Total budget is above the threshold.');
   END IF;

   -- Call the procedure to list all budget items
   list_budget_items(v_employee_id, v_budget_year);
END;
/
```
![Output:](<https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.3/Program.01/Output.png>)

2. **Payments**

**Function:** Get payments on a period.
```sql
CREATE OR REPLACE FUNCTION get_payments_in_period(start_date DATE, end_date DATE) 
RETURN SYS_REFCURSOR IS -- Return a cursor type to allow the result set to be fetched
    payment_cursor SYS_REFCURSOR;
BEGIN
    OPEN payment_cursor FOR
        SELECT PAYMENT_ID, EMPLOYEE_ID, PAYMENT_DATE, AMOUNT, PAYMENT_PURPOSE
        FROM Payment
        WHERE PAYMENT_DATE BETWEEN start_date AND end_date
        ORDER BY PAYMENT_DATE;
    RETURN payment_cursor;
END;
/
```
**Procedure:** Display payments on a period.
```sql
CREATE OR REPLACE PROCEDURE display_payments(start_date DATE, end_date DATE) IS
    payment_cursor SYS_REFCURSOR;
    
    -- Define a record type that matches the structure of the Payment table
    TYPE payment_record IS RECORD (
        PAYMENT_ID Payment.PAYMENT_ID%TYPE,
        EMPLOYEE_ID Payment.EMPLOYEE_ID%TYPE,
        PAYMENT_DATE Payment.PAYMENT_DATE%TYPE,
        AMOUNT Payment.AMOUNT%TYPE,
        PAYMENT_PURPOSE Payment.PAYMENT_PURPOSE%TYPE
    );
    
    payment_rec payment_record; -- Create a variable of the record type
BEGIN
    -- Get the cursor from the function
    payment_cursor := get_payments_in_period(start_date, end_date);
    
    -- Fetch and display payments
    LOOP
        FETCH payment_cursor INTO payment_rec;
        EXIT WHEN payment_cursor%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('Payment ID: ' || payment_rec.PAYMENT_ID || 
                             ', Employee ID: ' || payment_rec.EMPLOYEE_ID || 
                             ', Payment Date: ' || TO_CHAR(payment_rec.PAYMENT_DATE, 'YYYY-MM-DD') || 
                             ', Amount: ' || payment_rec.AMOUNT ||
                             ', Purpose: ' || payment_rec.PAYMENT_PURPOSE);
    END LOOP;
    
    -- Close the cursor
    CLOSE payment_cursor;
END;
/
```
Main:
```sql
-- Demonstration block
DECLARE
    v_start_date DATE := TO_DATE('2024-01-01', 'YYYY-MM-DD');
    v_end_date DATE := TO_DATE('2024-12-31', 'YYYY-MM-DD');
BEGIN
    -- Call the procedure to display payments
    display_payments(v_start_date, v_end_date);
END;
/
```
![Output:](<https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.3/Program.02/Output.png>)

3. **Inventory**

**Function:**  Brings all the orders of a certain employee that occurred between certain dates.
```sql
CREATE OR REPLACE FUNCTION get_employee_orders(p_employee_id NUMBER, p_start_date DATE, p_end_date DATE)
RETURN SYS_REFCURSOR
IS
   v_orders SYS_REFCURSOR;
BEGIN
   OPEN v_orders FOR
      SELECT o.Order_ID
      FROM Orders o
      JOIN Invoice i ON o.Invoice_ID = i.Invoice_ID
      WHERE o.Employee_ID = p_employee_id
       AND i.Invoice_Date BETWEEN p_start_date AND p_end_date
      ORDER BY i.Invoice_Date;

   RETURN v_orders;
END get_employee_orders;
/
```
**Procedure:** Receives an order and updates a supplier's inventory for that order
```sql
CREATE OR REPLACE PROCEDURE update_inventory_after_order(p_order_id NUMBER)
IS
   v_supplier_id NUMBER;
   v_quantity NUMBER;
   CURSOR order_cursor IS
      SELECT Supplier_ID, Quantity
      FROM Orders
      WHERE Order_ID = p_order_id;
BEGIN
   OPEN order_cursor;
   FETCH order_cursor INTO v_supplier_id, v_quantity;
   CLOSE order_cursor;

   UPDATE Supplier
   SET Inventory = Inventory - v_quantity
   WHERE Supplier_ID = v_supplier_id;

   COMMIT;
END update_inventory_after_order;
/
```
**Main:**

```sql
DECLARE
   v_employee_id NUMBER := 1883;
   v_start_date DATE := TO_DATE('01-01-2017', 'DD-MM-YYYY');
   v_end_date DATE := TO_DATE('01-04-2017', 'DD-MM-YYYY');
   v_order_id NUMBER;
   v_orders SYS_REFCURSOR;
BEGIN
   v_orders := get_employee_orders(v_employee_id, v_start_date, v_end_date);

   LOOP
      FETCH v_orders INTO v_order_id;
      EXIT WHEN v_orders%NOTFOUND;

      update_inventory_after_order(v_order_id);
   END LOOP;

   CLOSE v_orders;
END;
/
```
Quantity:

![Quantity](https://github.com/shay0129/DBProject_315689042_314695438/assets/116823605/2610b6a8-456c-4fc6-b633-05bf769737a9)


Before:

![Before](https://github.com/shay0129/DBProject_315689042_314695438/assets/116823605/9a13450a-7852-4ff7-bbd7-7db1aba3ed5e)


After:

![After](https://github.com/shay0129/DBProject_315689042_314695438/assets/116823605/9850a177-b672-4036-a3f8-c4dfb5a016bf)

## Stage 3:

### 1. **Main** Budget Management Program

**Program**: Checking the total budget and adding additional budget if needed

**Description**: 
This program checks the total budget amount for a specific employee in a given fiscal year and category. If the total amount is below a certain threshold, the program updates the budget amount and prints the updated amount. The main program uses a function to calculate the total amount and a procedure to list the budget items.

**Code**:
```sql
DECLARE
   v_employee_id NUMBER := 1920;
   v_budget_year NUMBER := 2015;
   v_expense_category VARCHAR2(50) := 'PC Services';
   v_total_budget NUMBER;
   v_new_amount NUMBER := 15000;
   v_threshold NUMBER := 10000;
BEGIN
   BEGIN
      v_total_budget := calculate_budget_total(v_employee_id, v_budget_year, v_expense_category);
      DBMS_OUTPUT.PUT_LINE('Total budget for employee ID ' || v_employee_id || ' in year ' || v_budget_year || ' for category ' || v_expense_category || ': ' || v_total_budget);

      IF v_total_budget < v_threshold THEN
         update_budget_amount(v_employee_id, v_budget_year, v_expense_category, v_new_amount);
         DBMS_OUTPUT.PUT_LINE('Budget amount updated for year ' || v_budget_year || ' and category ' || v_expense_category || ' to ' || v_new_amount);
      ELSE
         DBMS_OUTPUT.PUT_LINE('No update needed. Total budget is above the threshold.');
      END IF;

      list_budget_items(v_employee_id, v_budget_year);
   EXCEPTION
      WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
   END;
END;
/
```

**Function:** `calculate_budget_total`

**Description**: 
This function calculates the total budget amount for a specific employee in a given fiscal year and category.

**Code**:
```sql
CREATE OR REPLACE FUNCTION calculate_budget_total(
    p_employee_id NUMBER, 
    p_budget_year NUMBER, 
    p_expense_category VARCHAR2
) 
RETURN NUMBER 
IS
    v_total_budget NUMBER := 0; 
BEGIN
    SELECT NVL(SUM(BUDGET_AMOUNT), 0)  -- Use NVL to handle NULL cases
    INTO v_total_budget
    FROM Budget
    WHERE EMPLOYEE_ID = p_employee_id
      AND BUDGET_YEAR = p_budget_year
      AND EXPENSE_CATEGORY = p_expense_category;

    RETURN v_total_budget;
END calculate_budget_total;
/
```

**Procedure:** `list_budget_items`

**Description**: 
This procedure displays the budget items for a specific employee in a given fiscal year.

**Code**:
```sql
CREATE OR REPLACE PROCEDURE list_budget_items(
    p_employee_id NUMBER,
    p_budget_year NUMBER
)
IS
    CURSOR budget_cursor IS
        SELECT EXPENSE_CATEGORY, BUDGET_AMOUNT
        FROM Budget
        WHERE EMPLOYEE_ID = p_employee_id
          AND BUDGET_YEAR = p_budget_year;

    budget_rec budget_cursor%ROWTYPE;
BEGIN
    OPEN budget_cursor;
    LOOP
        FETCH budget_cursor INTO budget_rec;
        EXIT WHEN budget_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Category: ' || budget_rec.EXPENSE_CATEGORY || ', Amount: ' || budget_rec.BUDGET_AMOUNT);
    END LOOP;
    CLOSE budget_cursor;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
        IF budget_cursor%ISOPEN THEN
            CLOSE budget_cursor;
        END IF;
END list_budget_items;
/
```

**Procedure:** `update_budget_amount`

**Description**: 
This procedure updates the budget amount for a specific employee in a given fiscal year and category.

**Code**:
```sql
CREATE OR REPLACE PROCEDURE update_budget_amount(
    p_employee_id NUMBER,
    p_budget_year NUMBER,
    p_expense_category VARCHAR2,
    p_new_amount NUMBER
)
IS
BEGIN
    UPDATE Budget
    SET BUDGET_AMOUNT = p_new_amount
    WHERE EMPLOYEE_ID = p_employee_id
      AND BUDGET_YEAR = p_budget_year
      AND EXPENSE_CATEGORY = p_expense_category;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
        ROLLBACK;
END update_budget_amount;
/
```

![Output](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.3/Program.01/Output.png)

### 2. **Main** Payment Management Program

**Program**: Retrieving and displaying payments for a given period

**Description**: 
This program includes a function to retrieve a list of payments for a given period using a Ref Cursor, and a procedure to display the payments retrieved by the function in a structured format. The main program sets the desired period, calls the procedure to display the payments, and handles errors if necessary.

**Code**:
```sql
DECLARE
    v_start_date DATE := TO_DATE('2024-01-01', 'YYYY-MM-DD');
    v_end_date DATE := TO_DATE('2024-12-31', 'YYYY-MM-DD');
    payment_cursor SYS_REFCURSOR;
BEGIN
    BEGIN
        display_payments(v_start_date, v_end_date);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error in display_payments: ' || SQLERRM);
    END;

    BEGIN
        payment_cursor := get_payments_in_period(v_start_date, v_end_date);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error in get_payments_in_period: ' || SQLERRM);
    END;
END;
/
```

**Function:** `get_payments_in_period`

**Description**: 
This function receives a start date and an end date, and returns a list of payments within those dates using a Ref Cursor.

**Code**:
```sql
CREATE OR REPLACE FUNCTION get_payments_in_period(
       start_date DATE,
       end_date DATE
)
RETURN SYS_REFCURSOR IS
    payment_cursor SYS_REFCURSOR;
BEGIN
    OPEN payment_cursor FOR
        SELECT PAYMENT_ID, EMPLOYEE_ID, PAYMENT_DATE, AMOUNT, PAYMENT_PURPOSE
        FROM Payment
        WHERE PAYMENT_DATE BETWEEN start_date AND end_date
        ORDER BY PAYMENT_DATE;
    RETURN payment_cursor;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
        RETURN NULL;
END get_payments_in_period;
/
```

**Procedure:** `display_payments`

**Description**: 
This procedure receives a start date and an end date, uses the `get_payments_in_period` function to retrieve payments for the given period, and displays the details of each payment.

**Code**:
```sql
CREATE OR REPLACE PROCEDURE display_payments(
       start_date DATE,
       end_date DATE
)
IS
    payment_cursor SYS_REFCURSOR;

    TYPE payment_record IS RECORD (
        PAYMENT_ID Payment.PAYMENT_ID%TYPE,
        EMPLOYEE_ID Payment.EMPLOYEE_ID%TYPE,
        PAYMENT_DATE Payment.PAYMENT_DATE%TYPE,
        AMOUNT Payment.AMOUNT%TYPE,
        PAYMENT_PURPOSE Payment.PAYMENT_PURPOSE%TYPE
    );

    payment_rec payment_record;
BEGIN
    payment_cursor := get_payments_in_period(start_date, end_date);

    LOOP
        FETCH payment_cursor INTO payment_rec;
        EXIT WHEN payment_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Payment ID: ' || payment_rec.PAYMENT_ID ||
                             ', Employee ID: ' || payment_rec.EMPLOYEE_ID ||
                             ', Payment Date: ' || TO_CHAR(payment_rec.PAYMENT_DATE, 'YYYY-MM-DD') ||
                             ', Amount: ' || payment_rec.AMOUNT ||
                             ', Purpose: ' || payment_rec.PAYMENT_PURPOSE);
    END LOOP;

    CLOSE payment_cursor;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
        IF payment_cursor%ISOPEN THEN
            CLOSE payment_cursor;
        END IF;
END display_payments;
/
```

![Output](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.3/Program.02/Output.png)

---

## Stage 4:

We chose to integrate with the student services department

1. **Part 1** - Reverse Engineering:

DSD before integration: ![alt text](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.4/DSD/DSD_from_backup.png)

ERD: ![alt text](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.4/ERD/ERD_from_backup.png)

---

At this stage, we used an automatic PL/SQL tool to create a Data Structure (DS) Diagram from the backup of the table creation scripts. The algorithm we used for generating the ERD is described below:

---

1. **Create Table (`create_table`)**:
   - **Action**: Create an entity in the ERD.
   - **Explanation**: When a table is created, it represents a new entity in the diagram.

2. **Alter Table (`alter_table`)**:
   - **Action**: Create a connector in the ERD.
   - **Explanation**: When a table is altered, it typically means an existing entity's structure is modified, which might affect the relationships or constraints of the entity.

3. **Table with Foreign Key**:
   - **Action**: Create a "one to many" relationship.
   - **For us**: Create an entity in the ERD to reflect the addition of COUNSELOR_ID as a foreign key.
   - **One-Side**: **STUDENT** (a student can only be associated with one counselor).
   - **Many-Side**: **COUNSELOR** (one counselor can have many students).


2. **Part 2** - Integrated:


DSD after integration: ![alt text](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.4/DSD/DSD_integrated.png)

ERD: ![alt text](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.4/ERD/ERD_integrated.png)

### Integration Decisions

**1. Renaming Table:**
```sql
ALTER TABLE Student_
RENAME TO Student;
```
- **Reason**: This rename operation was performed to standardize and correct the naming convention of the table. The updated name `Student` aligns with conventional naming practices and improves consistency across the schema.

**2. Creating the `Kind` Connector Table:**
```sql
CREATE TABLE Kind (
    order_id INT,
    meal_id INTEGER,
    CONSTRAINT pk_kind PRIMARY KEY (order_id, meal_id),
    CONSTRAINT fk_order FOREIGN KEY (order_id) REFERENCES Orders (Order_ID),
    CONSTRAINT fk_meal FOREIGN KEY (meal_id) REFERENCES Meals (meal_id)
);
```
- **Reason for Addition**: 
  - The `Kind` table represents a many-to-many relationship between `Orders` and `Meals`. This relationship captures the association where each order can include multiple meals and each meal can be part of multiple orders.
  - **Columns**:
    - `order_id`: This foreign key references the `Order_ID` in the `Orders` table.
    - `meal_id`: This foreign key references the `meal_id` in the `Meals` table.
  - **Constraints**:
    - **Primary Key**: Composite primary key on `(order_id, meal_id)` ensures uniqueness of the combination of an order and a meal.
    - **Foreign Keys**: Ensures referential integrity by linking `order_id` to `Orders` and `meal_id` to `Meals`.

**3. Creating the `Learn` Connector Table:**
```sql
CREATE TABLE Learn (
    subject_name VARCHAR(30),
    student_id INTEGER,
    CONSTRAINT pk_learn PRIMARY KEY (subject_name, student_id),
    CONSTRAINT fk_subject FOREIGN KEY (subject_name) REFERENCES Subjects_Taught (Subject_Name),
    CONSTRAINT fk_student FOREIGN KEY (student_id) REFERENCES Student (student_id)
);
```
- **Reason for Addition**: 
  - The `Learn` table represents a many-to-many relationship between `Subjects_Taught` and `Student`. This relationship captures the association where each student can be enrolled in multiple subjects, and each subject can have multiple students.
  - **Columns**:
    - `subject_name`: This foreign key references the `Subject_Name` in the `Subjects_Taught` table.
    - `student_id`: This foreign key references the `student_id` in the `Student` table.
  - **Constraints**:
    - **Primary Key**: Composite primary key on `(subject_name, student_id)` ensures uniqueness of the combination of a subject and a student.
    - **Foreign Keys**: Ensures referential integrity by linking `subject_name` to `Subjects_Taught` and `student_id` to `Student`.

### Summary

- **Renaming of `Student_` Table**: Improved naming convention for consistency.
- **`Kind` Connector Table**: Establishes a many-to-many relationship between `Orders` and `Meals`, enabling comprehensive tracking of meal orders.
- **`Learn` Connector Table**: Establishes a many-to-many relationship between `Subjects_Taught` and `Student`, allowing for tracking of student enrollments in subjects.

These changes are aimed at enhancing the relational database schema to capture and enforce the complex many-to-many relationships between the various entities involved.


3. **Views**

Here’s an explanation for each view and the corresponding queries that follow, including their purposes, the SQL code, and examples of what the results might look like.

### 1. View: `SubjectTeacherDetails`

**Description**: 
The `SubjectTeacherDetails` view provides detailed information about the subjects taught by each employee. It combines data from the `Subjects_Taught`, `Teach`, and `Employee` tables to provide a comprehensive view of the subject details along with the associated teacher's information.

**SQL Code**:
```sql
CREATE VIEW SubjectTeacherDetails AS
SELECT 
    s.Subject_Name,
    s.students_studying_number,
    s.Difficulty_level,
    t.Employee_ID,
    e.Employee_Name,
    e.Job_Title,
    e.Seniority
FROM 
    Subjects_Taught s
JOIN 
    Teach t ON s.Subject_Name = t.Subject_Name
JOIN 
    Employee e ON t.Employee_ID = e.Employee_ID;
```

**Queries on `SubjectTeacherDetails` View**:

1. **Query 1: Total Students and Average Difficulty by Employee**

   **Description**: Retrieves each employee's total number of students and the average difficulty level of the subjects they teach.

   **SQL Code**:
   ```sql
   SELECT 
       Employee_ID,
       Employee_Name,
       Job_Title,
       Seniority,
       SUM(students_studying_number) AS Total_Students,
       AVG(Difficulty_level) AS Average_Difficulty
   FROM 
       SubjectTeacherDetails
   GROUP BY 
       Employee_ID, Employee_Name, Job_Title, Seniority;
   ```

   **Sample Output**:
   ```
   EMPLOYEE_ID | EMPLOYEE_NAME | JOB_TITLE | SENIORITY | TOTAL_STUDENTS | AVERAGE_DIFFICULTY
   ----------------------------------------------------------------------------------------------
   101         | John Doe      | Professor | Senior    | 150            | 4.5
   102         | Jane Smith    | Lecturer   | Junior    | 120            | 3.8
   ```

2. **Query 2: Employees Teaching More Than 2 Subjects with Difficulty Level > 4**

   **Description**: Lists employees who teach more than two subjects with an average difficulty level greater than 4.

   **SQL Code**:
   ```sql
   SELECT 
       Employee_ID,
       Employee_Name,
       COUNT(Subject_Name) AS Number_of_Subjects
   FROM 
       SubjectTeacherDetails
   WHERE 
       Difficulty_level > 4
   GROUP BY 
       Employee_ID, Employee_Name
   HAVING 
       COUNT(Subject_Name) > 2;
   ```

   **Sample Output**:
   ```
   EMPLOYEE_ID | EMPLOYEE_NAME | NUMBER_OF_SUBJECTS
   ---------------------------------------------------
   101         | John Doe      | 3
   ```
   ![alt text](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.4/SQL/View1_output.png)

### 2. View: `StudentActivityDetails`

**Description**: 
The `StudentActivityDetails` view provides information about activities and students participating in those activities. It merges data from the `Activity`, `Active`, and `Student` tables to offer a detailed overview of student involvement in activities.

**SQL Code**:
```sql
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
```

**Queries on `StudentActivityDetails` View**:

1. **Query 1: Total Students and Average Grade by Activity**

   **Description**: Retrieves the total number of students and average grade for each activity.

   **SQL Code**:
   ```sql
   SELECT 
       activity_id,
       activity_name,
       COUNT(student_id) AS Total_Students,
       AVG(grade) AS Average_Grade
   FROM 
       StudentActivityDetails
   GROUP BY 
       activity_id, activity_name;
   ```

   **Sample Output**:
   ```
   ACTIVITY_ID | ACTIVITY_NAME | TOTAL_STUDENTS | AVERAGE_GRADE
   ---------------------------------------------------------------
   201         | Soccer         | 25             | 8.2
   202         | Chess           | 18             | 7.9
   ```

2. **Query 2: Activities with More Than 20 Students and Average Grade > 8**

   **Description**: Lists activities where the number of students is greater than 20 and the average grade of participants is above 8.

   **SQL Code**:
   ```sql
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
   ```

   **Sample Output**:
   ```
   ACTIVITY_ID | ACTIVITY_NAME | NUMBER_OF_STUDENTS | AVERAGE_GRADE
   --------------------------------------------------------------
   201         | Soccer         | 25                 | 8.2
   ```
![alt text](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.4/SQL/View2_output.png)
