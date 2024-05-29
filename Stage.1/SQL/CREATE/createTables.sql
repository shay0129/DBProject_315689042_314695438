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
   Payment_Purpose VARCHAR(15),
   Payment_Date DATE,
   FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);
