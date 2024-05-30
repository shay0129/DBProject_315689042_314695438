•	**Shay Mordechai**			315689042

•	**Yair Miller**				314695438

***School Management System***

**Description:**

This system is designed to manage a school's administrative operations, including employee information, budgeting, procurement, and financial transactions.

Data Entities:

•	***Employee*** ( **Employee_ID**,Employee_Name, Seniority, Contact_Information )

•	***Budget*** ( **Budget_Code**, Employee_ID, Expense_Category, Budget_Amount, Budget_Year)

•	***Supplier*** ( **Supplier_ID**, Supplier_Name, Contact_Information, Inventory )

•	***Orders*** ( **Order_ID**, Supplier_ID, Employee_ID, Quantity )

•	***Invoice*** ( **Invoice_ID**, Order_ID, Invoice_Cost, Invoice_Date )

•	***Payment*** ( **Payment_ID**, Employee_ID, Amount, Payment_Purpose, Payment_Date )


**Relationships:**

•	An Employee can be linked to multiple Budgets (through Employee_ID in Budget).

•	An Employee can place multiple Orders and receive multiple Payments (through Employee_ID in Orders and Payment).

•	A Supplier can have many Orders placed with them (through Supplier_ID in Orders).

•	An Order is linked to a single Supplier and a single Invoice (through Supplier_ID and Order_ID in foreign keys).

•	An Invoice is linked to a single Order (through Order_ID in foreign key).

**Functionality:**

This database schema allows you to manage various aspects of a school's financial operations:

•	Track employee information and their roles.

•	Define and manage budgets for different expense categories.

•	Maintain supplier details and their inventory (if relevant).

•	Create and track purchase orders placed with suppliers.

•	Process invoices received from suppliers for placed orders.

•	Record payments made to employees for salaries, bonuses, or grants.

By querying and manipulating data in these tables, you can generate reports, analyze spending patterns, track budget utilization, and manage employee finances effectively.


**Create Tables:**

CREATE TABLE Employee (
   Employee_ID NUMBER(4) PRIMARY KEY,
   Employee_Name VARCHAR(30),
   Seniority NUMBER(5),
   Contact_Information VARCHAR(50),
   Job_Title  VARCHAR(30) CHECK (Job_Title IN ('Budget Committee', 'Procurement Manager', 'Worker'))
);

CREATE TABLE Budget (
   Budget_Code INT PRIMARY KEY,
   Employee_ID NUMBER(4),
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

CREATE TABLE Orders (
   Order_ID INT PRIMARY KEY,
   Supplier_ID INT,
   Employee_ID INT,
   Quantity INT,
   FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID),
   FOREIGN KEY (Supplier_ID) REFERENCES Supplier(Supplier_ID)
);

CREATE TABLE Invoice (
   Invoice_ID INT PRIMARY KEY,
   Order_ID INT,
   Invoice_Cost DECIMAL(10,2),
   Invoice_Date DATE,
   FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID)
);

CREATE TABLE Payment (
   Payment_ID INT PRIMARY KEY,
   Employee_ID INT,
   Amount DECIMAL(10,2),
   Payment_Purpose VARCHAR(20) CHECK (Payment_Purpose IN ('Salary', 'Bonus', 'Grant')),
   Payment_Date DATE,
   FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);

**ERD:**
 !["Image description"](Stage.1/ERD/ERD.png)

**DSD:**
 !["Image description"](Stage.1/DSD/DSD.png)

**Data Generate – Three Ways:**
•	Generate Budget data with Python Script.
 !["Image description"](Stage.1/TABLES/Python Script.png)
 
•	Generate Invoice data with Mockaroo’s website.
!["Image description"](Stage.1/TABLES/Mockaroo Generator.png)

•	Generate Payment data with Data Generator of PLSQL.
 !["Image description"](Stage.1/TABLES/PLSQL Data Generator.png)
 
**Six data imports with PLSQL:**

Employee – 500 records. 
!["Image description"](path/to/your/image.png)
Budget – 477 records. 
!["Image description"](path/to/your/image.png)
Orders – 500 records. 
!["Image description"](path/to/your/image.png)
Payment – 500 records. 
!["Image description"](path/to/your/image.png)
Orders – 500 records. 
!["Image description"](path/to/your/image.png)



