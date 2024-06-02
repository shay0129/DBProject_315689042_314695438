--Employee Insert
INSERT INTO Employee (Employee_ID, Employee_Name, Seniority, Contact_Information, Job_Title)
VALUES (1500, 'Brandon Peake', 17, '555-555-6139', 'Worker');

INSERT INTO Employee (Employee_ID, Employee_Name, Seniority, Contact_Information, Job_Title)
VALUES (1501, 'Nicholas Jones', NULL, 'NicholasJones@example.com', 'Procurement Manager');

INSERT INTO Employee (Employee_ID, Employee_Name, Seniority, Contact_Information, Job_Title)
VALUES (1502, 'Brandon Skinner', 13, '555-555-4690', 'Procurement Manager');

-- Budget Insert
INSERT INTO Budget (Budget_Code, Employee_ID, Expense_Category, Budget_Amount, Budget_Year)
VALUES (1, 1500, 'Rent or Lease Payments', 3086.49, 2014);

INSERT INTO Budget (Budget_Code, Employee_ID, Expense_Category, Budget_Amount, Budget_Year)
VALUES (2, 1501, 'Special Education', 6240.90, 2023);

INSERT INTO Budget (Budget_Code, Employee_ID, Expense_Category, Budget_Amount, Budget_Year)
VALUES (3, 1502, 'Food Services', 6831.72, 2011);

-- Supplier Insert
INSERT INTO Supplier (Supplier_ID, Supplier_Name, Contact_Information, Inventory)
VALUES (3000, 'Scholarly Supplies Stop', 'CrayonsSolutions@example.com', 95.35);

INSERT INTO Supplier (Supplier_ID, Supplier_Name, Contact_Information, Inventory)
VALUES (3001, 'IntelliSupplies Shack', 'StudySmartStation@example.com', 62.85);

INSERT INTO Supplier (Supplier_ID, Supplier_Name, Contact_Information, Inventory)
VALUES (3002, 'Academic Essentials', 'SchoolSavvyStorefront@example.com', 97.51);

-- Invoice Insert
INSERT INTO Invoice (Invoice_ID, Supplier_ID, Invoice_Cost, Invoice_Date)
VALUES (5000, 3000, 1200.50, '2023-01-25');

INSERT INTO Invoice (Invoice_ID, Supplier_ID, Invoice_Cost, Invoice_Date)
VALUES (5001, 3001, 650.75, '2023-02-25');

INSERT INTO Invoice (Invoice_ID, Supplier_ID, Invoice_Cost, Invoice_Date)
VALUES (5002, 3002, 985.30, '2023-03-20');

-- Orders Insert
INSERT INTO Orders (Order_ID, Supplier_ID, Employee_ID, Invoice_ID, Quantity)
VALUES (4000, 3000, 1500, 5000, 10);

INSERT INTO Orders (Order_ID, Supplier_ID, Employee_ID, Invoice_ID, Quantity)
VALUES (4001, 3001, 1501, 5001, 15);

INSERT INTO Orders (Order_ID, Supplier_ID, Employee_ID, Invoice_ID, Quantity)
VALUES (4002, 3002, 1502, 5002, 20);

-- Payment Insert
INSERT INTO Payment (Payment_ID, Employee_ID, Amount, Payment_Purpose, Payment_Date)
VALUES (6000, 1500, 1200.50, 'Salary', '2023-01-30');

INSERT INTO Payment (Payment_ID, Employee_ID, Amount, Payment_Purpose, Payment_Date)
VALUES (6001, 1501, 650.75, 'Bonus', '2023-03-01');

INSERT INTO Payment (Payment_ID, Employee_ID, Amount, Payment_Purpose, Payment_Date)
VALUES (6002, 1502, 985.30, 'Grant', '2023-03-25');
