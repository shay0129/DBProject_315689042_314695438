

•	Shay Mordechai			315689042

•	Yair Miller			314695438

                                                  School Management System

3/6/24

## Stage 1:

## Description:

• Employee Management: Storing information about employees, their roles, seniority, and contact details.
• Budgeting: Defining and tracking budgets allocated to different expense categories and years.
• Procurement: Managing suppliers, purchase orders, and invoices.
• Financial Transactions: Recording payments made to employees (salary, bonuses, grants).
• Academic Management: Tracking subjects taught, class sizes, and difficulty levels, as well as assigning subjects to teachers.

Data Entities:

| Table Name       | Description

•	__Employee__ (***Employee_ID***,Employee_Name, Seniority, Contact_Information, Job_Title)

•	__Budget__ (Budget_Code, _Employee_ID_, ***Expense_Category***, Budget_Amount, ***Budget_Year***)

•	__Supplier__ (***Supplier_ID***, Supplier_Name, Contact_Information, Inventory)

•	__Invoice__ (***Invoice_ID***, _Supplier_ID_, Invoice_Cost, Invoice_Date)

•	__Orders__ (***Order_ID***, _Supplier_ID_, _Employee_ID_, Invoice_ID, Quantity)

•	__Payment__ (***Payment_ID***, _Employee_ID_, Amount, Payment_Purpose, Payment_Date)

•	__Subjects Taught__(***Subject Name***, Class Number, Student Count, Difficulty Level)

•	__Teach__(***_Employee_ID_***, ***Subject Name***)


**Relationships:**

• An ***Employee*** may be associated with multiple ***Budgets*** (via Employee_ID in Budget).

• An ***Employee*** can initiate multiple Orders and receive multiple ***Payments*** (via Employee_ID in Orders and Payment).

• A ***Supplier*** can have multiple ***Orders*** placed with them (via Supplier_ID in Orders).

• Each ***Order*** is tied to a single Supplier and a single ***Invoice*** (via Supplier_ID and Order_ID in foreign keys).

• Each ***Invoice*** is linked to a single ***Order*** (via Order_ID in foreign key).

• Each ***Supplier*** must have exactly one Invoice associated with them, and each Invoice must be associated with exactly one 

***Supplier***.

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
   Budget_Code INT,
   Employee_ID NUMBER(4), -- Each budget must be associated with an employee
   Expense_Category VARCHAR(50),
   Budget_Amount DECIMAL(10,2),
   Budget_Year NUMBER(4),
   PRIMARY KEY (Expense_Category, Budget_Year),
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

CREATE TABLE Subjects_Taught (
    Subject_Name VARCHAR(30) PRIMARY KEY,
    Class_number INT,
    Students_studying_number INT,
    Difficulty_level INT
);

CREATE TABLE Teach (
  Employee_ID NUMBER(4),
  Subject_Name VARCHAR(30),
  PRIMARY KEY (Employee_ID, Subject_Name),
  FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID),
  FOREIGN KEY (Subject_Name) REFERENCES Subjects_Taught(Subject_Name)
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

7. Subjects Taught:

!["Payment Table"](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.1/SQL/DESC/Subjects_Taught.png)

8. Teach:

!["Payment Table"](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.1/SQL/DESC/Teach.png)

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

7. Subjects Taught:

![alt text](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.1/DataImporterFiles/GENERATE/Subjects_Taught.png)

8. Teach:

![alt text](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.1/DataImporterFiles/GENERATE/Teach.png)

## Text Importer - PLSQL:

1. Employee:

!["Employee – 500 records."](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.1/DataImporterFiles/IMPORT/Employee.png)
 
 2. Budget:

!["Budget – 388 records."](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.1/DataImporterFiles/IMPORT/Budget.png)

3. Supplier:

![alt text](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.1/DataImporterFiles/GENERATE/Supplier.png)
 
 4. Invoice:

!["Invoice – 500 records."](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.1/DataImporterFiles/IMPORT/Invoice.png)
 
 5. Orders:

!["Orders – 497 records."](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.1/DataImporterFiles/IMPORT/Orders.png)

6. Payment:

!["Payment – 499 records."](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.1/DataImporterFiles/IMPORT/Payment.png)

7. Subjects_Taught:

!["Orders – 348 records."](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.1/DataImporterFiles/IMPORT/Subjects_Taught.png)


8. Teach:

!["Orders – 199 records."](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.1/DataImporterFiles/IMPORT/Teach.png)


## Backup & Recovery

!["Backup Screenshot"](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.1/Backup/backup.png)

!["Backup Screenshot"](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.1/Backup/recovery.png)
