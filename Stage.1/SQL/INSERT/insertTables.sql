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

-- Orders Insert

-- Invoice Insert

--Payment Insert

