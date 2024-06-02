2/6/24

•	Shay Mordechai			315689042

•	Yair Miller			314695438

                                                  School Management System

## Description:

This system is designed to manage a school's administrative operations, including employee information, budgeting, procurement, and financial transactions.

Data Entities:

•	__Employee__ ( ***Employee_ID***,Employee_Name, Seniority, Contact_Information )

•	__Budget__ ( ***Budget_Code***, _Employee_ID_, Expense_Category, Budget_Amount, Budget_Year)

•	__Supplier__ ( ***Supplier_ID***, Supplier_Name, Contact_Information, Inventory )

•	__Invoice__ ( ***Invoice_ID***, _Supplier_ID_, Invoice_Cost, Invoice_Date )

•	__Orders__ ( ***Order_ID***, _Supplier_ID_, _Employee_ID_, Quantity )

•	__Payment__ ( ***Payment_ID***, _Employee_ID_, Amount, Payment_Purpose, Payment_Date )


## Relationships:

• An _Employee_ may be associated with multiple _Budgets_ (via Employee_ID in Budget).

• An _Employee_ can initiate multiple Orders and receive multiple _Payments_ (via Employee_ID in Orders and Payment).

• A _Supplier_ can have multiple _Orders_ placed with them (via Supplier_ID in Orders).

• Each _Order_ is tied to a single Supplier and a single _Invoice_ (via Supplier_ID and Order_ID in foreign keys).

• Each _Invoice_ is linked to a single _Order_ (via Order_ID in foreign key).

• Each _Supplier_ must have exactly one Invoice associated with them, and each Invoice must be associated with exactly one _Supplier_.

**Functionality:**

This database schema allows you to manage various aspects of a school's financial operations:

•	 Record and manage employee information, including their roles and contact details.

• Define and track budgets allocated to different expense categories, ensuring efficient financial management.

• Maintain supplier details, including their names, contact information, and inventory levels (if applicable).

• Create and manage purchase orders placed with suppliers, tracking details such as order quantities and delivery dates.

• Process invoices received from suppliers for placed orders, ensuring accurate billing and payment reconciliation.

• Record payments made to employees for salaries, bonuses, or grants, enabling efficient payroll processing and financial reporting.

## ERD:
 ![Entity-Relationship Diagram](Stage.1/ERD/ERD.png)


## DSD:
 !["Data Structure Diagram"](Stage.1/DSD/DSD.png)

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

## Drop Tables:
DROP TABLE Payment;
DROP TABLE Orders;
DROP TABLE Invoice;
DROP TABLE Supplier;
DROP TABLE Budget;
DROP TABLE Employee;
```

## Insert Tables:

___Employee Insert Statements___
```sql
INSERT INTO Employee (Employee_ID, Employee_Name, Seniority, Contact_Information, Job_Title)
VALUES (1500, 'Brandon Peake', 17, '555-555-6139', 'Worker');

INSERT INTO Employee (Employee_ID, Employee_Name, Seniority, Contact_Information, Job_Title)
VALUES (1501, 'Nicholas Jones', NULL, 'NicholasJones@example.com', 'Procurement Manager');

INSERT INTO Employee (Employee_ID, Employee_Name, Seniority, Contact_Information, Job_Title)
VALUES (1502, 'Brandon Skinner', 13, '555-555-4690', 'Procurement Manager');

INSERT INTO Employee (Employee_ID, Employee_Name, Seniority, Contact_Information, Job_Title)
VALUES (1503, 'Sandra Stevens', 8, 'SandraStevens@example.com', 'Software Engineer');

INSERT INTO Employee (Employee_ID, Employee_Name, Seniority, Contact_Information, Job_Title)
VALUES (1504, 'Diana Ray', 5, '555-555-9876', 'Human Resources Manager');

INSERT INTO Employee (Employee_ID, Employee_Name, Seniority, Contact_Information, Job_Title)
VALUES (1505, 'Patrick Stone', 10, 'PatrickStone@example.com', 'Marketing Specialist');

INSERT INTO Employee (Employee_ID, Employee_Name, Seniority, Contact_Information, Job_Title)
VALUES (1506, 'Ashley Brown', 7, '555-555-7765', 'Finance Analyst');

INSERT INTO Employee (Employee_ID, Employee_Name, Seniority, Contact_Information, Job_Title)
VALUES (1507, 'Emily Davis', 12, 'EmilyDavis@example.com', 'Sales Executive');

INSERT INTO Employee (Employee_ID, Employee_Name, Seniority, Contact_Information, Job_Title)
VALUES (1508, 'Joshua Green', NULL, 'JoshuaGreen@example.com', 'IT Support');

INSERT INTO Employee (Employee_ID, Employee_Name, Seniority, Contact_Information, Job_Title)
VALUES (1509, 'Sophia Taylor', 3, '555-555-3344', 'Administrative Assistant');
```
___Budget Insert Statements___
```sql
INSERT INTO Budget (Budget_Code, Employee_ID, Expense_Category, Budget_Amount, Budget_Year)
VALUES (1, 1500, 'Rent or Lease Payments', 3086.49, 2014);

INSERT INTO Budget (Budget_Code, Employee_ID, Expense_Category, Budget_Amount, Budget_Year)
VALUES (2, 1501, 'Special Education', 6240.90, 2023);

INSERT INTO Budget (Budget_Code, Employee_ID, Expense_Category, Budget_Amount, Budget_Year)
VALUES (3, 1502, 'Food Services', 6831.72, 2011);

INSERT INTO Budget (Budget_Code, Employee_ID, Expense_Category, Budget_Amount, Budget_Year)
VALUES (4, 1503, 'Transportation', 4520.00, 2019);

INSERT INTO Budget (Budget_Code, Employee_ID, Expense_Category, Budget_Amount, Budget_Year)
VALUES (5, 1504, 'Salaries and Wages', 7200.50, 2022);

INSERT INTO Budget (Budget_Code, Employee_ID, Expense_Category, Budget_Amount, Budget_Year)
VALUES (6, 1505, 'Utilities', 3100.75, 2021);

INSERT INTO Budget (Budget_Code, Employee_ID, Expense_Category, Budget_Amount, Budget_Year)
VALUES (7, 1506, 'Professional Development', 2890.25, 2020);

INSERT INTO Budget (Budget_Code, Employee_ID, Expense_Category, Budget_Amount, Budget_Year)
VALUES (8, 1507, 'Technology', 8500.00, 2023);

INSERT INTO Budget (Budget_Code, Employee_ID, Expense_Category, Budget_Amount, Budget_Year)
VALUES (9, 1508, 'Office Supplies', 1200.40, 2018);

INSERT INTO Budget (Budget_Code, Employee_ID, Expense_Category, Budget_Amount, Budget_Year)
VALUES (10, 1509, 'Maintenance', 5000.00, 2017);
```
___Supplier Insert Statements___
```sql
INSERT INTO Supplier (Supplier_ID, Supplier_Name, Contact_Information, Inventory)
VALUES (3000, 'Scholarly Supplies Stop', 'CrayonsSolutions@example.com', 95.35);

INSERT INTO Supplier (Supplier_ID, Supplier_Name, Contact_Information, Inventory)
VALUES (3001, 'IntelliSupplies Shack', 'StudySmartStation@example.com', 62.85);

INSERT INTO Supplier (Supplier_ID, Supplier_Name, Contact_Information, Inventory)
VALUES (3002, 'Academic Essentials', 'SchoolSavvyStorefront@example.com', 97.51);

INSERT INTO Supplier (Supplier_ID, Supplier_Name, Contact_Information, Inventory)
VALUES (3003, 'Knowledge Hub Supplies', 'EduEssentials@example.com', 120.40);

INSERT INTO Supplier (Supplier_ID, Supplier_Name, Contact_Information, Inventory)
VALUES (3004, 'Learning Central', 'LearningCentral@example.com', 150.00);

INSERT INTO Supplier (Supplier_ID, Supplier_Name, Contact_Information, Inventory)
VALUES (3005, 'Academic Assets', 'AcademicAssets@example.com', 85.75);

INSERT INTO Supplier (Supplier_ID, Supplier_Name, Contact_Information, Inventory)
VALUES (3006, 'Scholars Supply Co.', 'ScholarsSupply@example.com', 99.99);

INSERT INTO Supplier (Supplier_ID, Supplier_Name, Contact_Information, Inventory)
VALUES (3007, 'Classroom Necessities', 'ClassNecessities@example.com', 70.25);

INSERT INTO Supplier (Supplier_ID, Supplier_Name, Contact_Information, Inventory)
VALUES (3008, 'Study Supplies', 'StudySupplies@example.com', 112.30);

INSERT INTO Supplier (Supplier_ID, Supplier_Name, Contact_Information, Inventory)
VALUES (3009, 'Edu Equip', 'EduEquip@example.com', 68.45);
```
___Invoice Insert Statements___
```sql
INSERT INTO Invoice (Invoice_ID, Supplier_ID, Invoice_Cost, Invoice_Date)
VALUES (5000, 3000, 1200.50, '2023-01-25');

INSERT INTO Invoice (Invoice_ID, Supplier_ID, Invoice_Cost, Invoice_Date)
VALUES (5001, 3001, 650.75, '2023-02-25');

INSERT INTO Invoice (Invoice_ID, Supplier_ID, Invoice_Cost, Invoice_Date)
VALUES (5002, 3002, 985.30, '2023-03-20');

INSERT INTO Invoice (Invoice_ID, Supplier_ID, Invoice_Cost, Invoice_Date)
VALUES (5003, 3003, 1120.40, '2023-04-15');

INSERT INTO Invoice (Invoice_ID, Supplier_ID, Invoice_Cost, Invoice_Date)
VALUES (5004, 3004, 750.00, '2023-05-10');

INSERT INTO Invoice (Invoice_ID, Supplier_ID, Invoice_Cost, Invoice_Date)
VALUES (5005, 3005, 875.25, '2023-06-05');

INSERT INTO Invoice (Invoice_ID, Supplier_ID, Invoice_Cost, Invoice_Date)
VALUES (5006, 3006, 1345.99, '2023-07-01');

INSERT INTO Invoice (Invoice_ID, Supplier_ID, Invoice_Cost, Invoice_Date)
VALUES (5007, 3007, 950.60, '2023-08-20');

INSERT INTO Invoice (Invoice_ID, Supplier_ID, Invoice_Cost, Invoice_Date)
VALUES (5008, 3008, 1125.30, '2023-09-15');

INSERT INTO Invoice (Invoice_ID, Supplier_ID, Invoice_Cost, Invoice_Date)
VALUES (5009, 3009, 680.45, '2023-10-10');
```
___Orders Insert Statements___
```sql
INSERT INTO Orders (Order_ID, Supplier_ID, Employee_ID, Invoice_ID, Quantity)
VALUES (4000, 3000, 1500, 5000, 10);

INSERT INTO Orders (Order_ID, Supplier_ID, Employee_ID, Invoice_ID, Quantity)
VALUES (4001, 3001, 1501, 5001, 15);

INSERT INTO Orders (Order_ID, Supplier_ID, Employee_ID, Invoice_ID, Quantity)
VALUES (4002, 3002, 1502, 5002, 20);

INSERT INTO Orders (Order_ID, Supplier_ID, Employee_ID, Invoice_ID, Quantity)
VALUES (4003, 3003, 1503, 5003, 25);

INSERT INTO Orders (Order_ID, Supplier_ID, Employee_ID, Invoice_ID, Quantity)
VALUES (4004, 3004, 1504, 5004, 30);

INSERT INTO Orders (Order_ID, Supplier_ID, Employee_ID, Invoice_ID, Quantity)
VALUES (4005, 3005, 1505, 5005, 35);

INSERT INTO Orders (Order_ID, Supplier_ID, Employee_ID, Invoice_ID, Quantity)
VALUES (4006, 3006, 1506, 5006, 40);

INSERT INTO Orders (Order_ID, Supplier_ID, Employee_ID, Invoice_ID, Quantity)
VALUES (4007, 3007, 1507, 5007, 45);

INSERT INTO Orders (Order_ID, Supplier_ID, Employee_ID, Invoice_ID, Quantity)
VALUES (4008, 3008, 1508, 5008, 50);

INSERT INTO Orders (Order_ID, Supplier_ID, Employee_ID, Invoice_ID, Quantity)
VALUES (4009, 3009, 1509, 5009, 55);
```

___Payment Insert Statements___
```sql
INSERT INTO Payment (Payment_ID, Employee_ID, Amount, Payment_Purpose, Payment_Date)
VALUES (6000, 1500, 1200.50, 'Salary', '30-01-2023');

INSERT INTO Payment (Payment_ID, Employee_ID, Amount, Payment_Purpose, Payment_Date)
VALUES (6001, 1501, 650.75, 'Bonus', '01-03-2023');

INSERT INTO Payment (Payment_ID, Employee_ID, Amount, Payment_Purpose, Payment_Date)
VALUES (6002, 1502, 985.30, 'Grant', '25-03-2023');

INSERT INTO Payment (Payment_ID, Employee_ID, Amount, Payment_Purpose, Payment_Date)
VALUES (6003, 1503, 1500.00, 'Salary', '28-02-2023');

INSERT INTO Payment (Payment_ID, Employee_ID, Amount, Payment_Purpose, Payment_Date)
VALUES (6004, 1504, 200.00, 'Salary', '10-03-2023');

INSERT INTO Payment (Payment_ID, Employee_ID, Amount, Payment_Purpose, Payment_Date)
VALUES (6005, 1505, 750.00, 'Bonus', '15-04-2023');

INSERT INTO Payment (Payment_ID, Employee_ID, Amount, Payment_Purpose, Payment_Date)
VALUES (6006, 1506, 500.00, 'Salary', '20-05-2023');

INSERT INTO Payment (Payment_ID, Employee_ID, Amount, Payment_Purpose, Payment_Date)
VALUES (6007, 1507, 1250.00, 'Salary', '30-06-2023');

INSERT INTO Payment (Payment_ID, Employee_ID, Amount, Payment_Purpose, Payment_Date)
VALUES (6008, 1508, 300.00, 'Bonus', '01-07-2023');

INSERT INTO Payment (Payment_ID, Employee_ID, Amount, Payment_Purpose, Payment_Date)
VALUES (6009, 1509, 650.00, 'Bonus', '05-08-2023');
```

## Data Generate – Three Ways:
•	Generate Budget data with Python Script.
 !["Image description"](Stage.1/TABLES/GENERATE/ERD.png)
 
!["Generate Invoice data with Mockaroo’s website."](Stage.1/TABLES/GENERATE/DSD.png)

 !["Generate Payment data with Data Generator of PLSQL."](Stage.1/TABLES/GENERATE/PLSQL_Data_Generator.png)
 
## Text Importer - PLSQL:

!["Employee – 500 records."](Stage.1/TABLES/IMPORT/Employee.png)
 
!["Budget – 477 records."](Stage.1/TABLES/IMPORT/Budget.png)
. 
!["Supplier – 500 records."](Stage.1/TABLES/IMPORT/Budget.png)
 
!["Invoice – 500 records."](Stage.1/TABLES/IMPORT/Invoice.png)
 
!["Orders – 500 records."](Stage.1/TABLES/IMPORT/Orders.png)

!["Payment – 500 records."](Stage.1/TABLES/IMPORT/Payment.png)

## New Section
This is a new section added to the README file.