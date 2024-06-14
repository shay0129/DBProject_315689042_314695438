3/6/24

•	Shay Mordechai			315689042

•	Yair Miller			314695438

                                                  School Management System

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
 ![Entity-Relationship Diagram](Stage.1/ERD/ERD.png)

The ERD was chosen to accurately represent the key components and relationships involved in the procurement process, employee payroll process, and budget management process.

1. Procurement Process:

Suppliers, Orders, Invoices.

2. Employee Payroll Process:

Employees, Payments, Budget.

3. Management Process:

Budgets, Employees.


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
## Desc. commands:

!["Employee Table"](Stage.1\SQL\DESC\Employee.png)

!["Budget Table"](Stage.1\SQL\DESC\Budget.png)

!["Supplier Table"](Stage.1\SQL\DESC\Supplier.png)

!["Invoice Table"](Stage.1\SQL\DESC\Invoice.png)

!["Orders Table"](Stage.1\SQL\DESC\Orders.png)

!["Payment Table"](Stage.1\SQL\DESC\Payment.png)

## Data Generate – Three Ways:

 !["Python Script"](Stage.1/TABLES/GENERATE/ERD.png)
 
!["Mockaroo’s website"](Stage.1/TABLES/GENERATE/DSD.png)

 !["PLSQL's Data-Generator"](Stage.1/TABLES/GENERATE/PLSQL_Data_Generator.png)
 
## Text Importer - PLSQL:

!["Employee – 500 records."](Stage.1/TABLES/IMPORT/Employee.png)
 
!["Budget – 482 records."](Stage.1/TABLES/IMPORT/Budget.png)
. 
!["Supplier – 500 records."](Stage.1/TABLES/IMPORT/Budget.png)
 
!["Invoice – 500 records."](Stage.1/TABLES/IMPORT/Invoice.png)
 
!["Orders – 497 records."](Stage.1/TABLES/IMPORT/Orders.png)

!["Payment – 499 records."](Stage.1/TABLES/IMPORT/Payment.png)

## Backup & Recovery

!["Backup screenshot"](Stage.1\Backup\backup.png)

!["Backup screenshot"](Stage.1\Backup\recovery.png)

## Queries

The employee with the highest total salary including bonuses.

![‏‏צילום מסך (5)](https://github.com/shay0129/DBProject_315689042_314695438/assets/116823605/3f33a9b6-8356-4f51-913f-9864e0d2d3c5)




The employee with the largest number of orders.

![‏‏צילום מסך (6)](https://github.com/shay0129/DBProject_315689042_314695438/assets/116823605/16a2bf44-37df-4695-823d-99680ce682c0)




Employee and supplier are linked to each other and both have email.

![‏‏צילום מסך (7)](https://github.com/shay0129/DBProject_315689042_314695438/assets/116823605/ed83b183-06dc-4ce5-90aa-21cd260b214d)




Employees who exceeded the annual budget in the last year by a certain percentage.

![‏‏צילום מסך (8)](https://github.com/shay0129/DBProject_315689042_314695438/assets/116823605/ab36befe-1dcd-47e5-aebd-5246a337ab2d)




Some workers their salary is less than the average.

![‏‏צילום מסך (9)](https://github.com/shay0129/DBProject_315689042_314695438/assets/116823605/3eb55b5b-ddef-430e-b116-f66732fe71b3)




Increases an employee's inventory under certain conditions.

![‏‏צילום מסך (25)](https://github.com/shay0129/DBProject_315689042_314695438/assets/116823605/6fa335ce-ffce-47d5-824e-23fb06600c26)

before

![‏‏צילום מסך (16)](https://github.com/shay0129/DBProject_315689042_314695438/assets/116823605/e7f8ea3e-1094-496a-8a53-5a0c69ae2baf)

after

![‏‏צילום מסך (17)](https://github.com/shay0129/DBProject_315689042_314695438/assets/116823605/54816b7e-b7b4-41d9-891a-6c620d03544e)




Updates a job name for an employee under certain conditions.

![‏‏צילום מסך (24)](https://github.com/shay0129/DBProject_315689042_314695438/assets/116823605/10dadae9-4441-41de-9c41-7246af82afa9)

before

![‏‏צילום מסך (18)](https://github.com/shay0129/DBProject_315689042_314695438/assets/116823605/7ed92f30-2332-4af3-8956-ee0bceabe0c0)

after

![‏‏צילום מסך (19)](https://github.com/shay0129/DBProject_315689042_314695438/assets/116823605/45391057-01b1-4bbe-b277-d6a68da7d027)




Deletes purchasing managers under certain conditions if they have not made any orders at all.

![‏‏צילום מסך (26)](https://github.com/shay0129/DBProject_315689042_314695438/assets/116823605/8026fe81-6b81-46a2-87c0-293ac9530a9b)

before

![‏‏צילום מסך (20)](https://github.com/shay0129/DBProject_315689042_314695438/assets/116823605/0d4968e6-a486-41b8-95f8-005bb66a6cc6)

after

![‏‏צילום מסך (27)](https://github.com/shay0129/DBProject_315689042_314695438/assets/116823605/af63aad5-106d-4273-aad6-f21b44e5f28f)




Deletes all suppliers who have not issued an invoice over 5 in the last 20 years.





![‏‏צילום מסך (29)](https://github.com/shay0129/DBProject_315689042_314695438/assets/116823605/14855565-fcfc-49d2-a7ff-8918456b8190)

before

![‏‏צילום מסך (28)](https://github.com/shay0129/DBProject_315689042_314695438/assets/116823605/94685e45-9d44-46f3-9735-62b7fddd63a1)

after





## ParamsQueries









