-- Insert data into Employee table
INSERT INTO Employee (Employee_Name, Seniority, Contact_Information, Role)
VALUES ('John Doe', 10, '052-1111111', 'Budget Committee'),
       ('Jane Smith', 5, 'Jane@example.com', 'Procurement Manager'),
       ('Michael Jones', 2, 'Michael@example.com', 'Worker');

-- Insert data into Supplier table
INSERT INTO Supplier (Supplier_Name, Contact_Information, Inventory)
VALUES ('Acme Inc.', 'Acme@example.com', 10000.00),
       ('Tech', '050-2222222', 5000.00);

-- Insert data into Budget table (assuming Employee IDs already exist)
INSERT INTO Budget (Employee_ID, Category, Sum, Year)
VALUES (1, 'Marketing', 5000.00, 2024),
       (2, 'Research & Development', 8000.00, 2024),
       (3, 'Operations', 12000.00, 2024);

-- Insert data into Order table (assuming Employee Names and Supplier IDs already exist)
INSERT INTO Order (Employee_Name, Quantity, Supplier_ID)
VALUES ('John Doe', 100, 1),
       ('Jane Smith', 50, 2),
       ('Michael Jones', 25, 1);

-- Insert data into Invoice table (assuming Order IDs already exist)
INSERT INTO Invoice (Order_ID, Cost, Date)
VALUES (1, 1000.00, '2024-05-28'),
       (2, 750.00, '2024-05-29'),
       (3, 250.00, '2024-05-30');

-- Insert data into Payment table (assuming Employee IDs already exist)
INSERT INTO Payment (Employee_ID, Amount, Payment_Purpose, Date)
VALUES (1, 2000.00, 'Salary', '2024-05-31'),
       (2, 1500.00, 'Salary', '2024-05-31'),
       (3, 1000.00, 'Salary', '2024-05-31');
