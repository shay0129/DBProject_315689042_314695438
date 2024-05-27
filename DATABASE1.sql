CREATE TABLE Budget
(
  Budget_Code INT NOT NULL AUTO_INCREMENT,
  Employee_ID INT NOT NULL,
  Category VARCHAR(255) NOT NULL,
  Sum DECIMAL(10,2) NOT NULL,
  Year INT NOT NULL,
  PRIMARY KEY (Budget_Code),
  FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);

GRANT UPDATE (Budget_Code, Sum) ON Budget TO 'Budget Committee';

CREATE TABLE Employee (
  Employee_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  Seniority INT NOT NULL,
  Name VARCHAR(255) NOT NULL,
  Contact_Information ENUM('Email', 'Phone Number') NOT NULL,
  Role ENUM('Budget Committee', 'Procurement Manager', 'Worker') NOT NULL
);

CREATE TABLE Order (
  Order_ID INT NOT NULL AUTO_INCREMENT,
  Cost DECIMAL(10,2) NOT NULL,
  Quantity INT NOT NULL,
  Supplier_ID INT NOT NULL,
  PRIMARY KEY (Order_ID),
  FOREIGN KEY (Supplier_ID) REFERENCES Supplier(Supplier_ID)
);

GRANT UPDATE (Quantity) ON Order TO 'Procurement Manager';

CREATE TABLE Supplier (
  Supplier_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  Supllier_Name VARCHAR(255) NOT NULL,
  Inventory DECIMAL(10,2) NOT NULL,
  Type VARCHAR(255) NOT NULL,
  Company VARCHAR(255) NOT NULL
);

CREATE TABLE Invoice (
  Invoice_ID INT NOT NULL AUTO_INCREMENT,
  Order_ID INT NOT NULL,
  Date DATE NOT NULL,
  Amount DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (Invoice_ID),
  FOREIGN KEY (Order_ID) REFERENCES Order(Order_ID)
);

CREATE TABLE Payment 
(
  Payment_ID INT NOT NULL AUTO_INCREMENT,
  Date DATE NOT NULL,
  Amount DECIMAL(10,2) NOT NULL,
  Employee_ID INT NOT NULL,
  Payment_Purpose ENUM('Salary', 'Bonus', 'Grant') NOT NULL,
  PRIMARY KEY (Payment_ID),
  FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);
