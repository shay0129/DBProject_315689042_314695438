-- Insert into Employee (assuming these IDs don't exist yet)
INSERT INTO Employee (Seniority, Name, Contact_Information, Role)
VALUES (5, 'John Smith', 'Email', 'Budget Committee'),
       (3, 'Jane Doe', 'Phone Number', 'Procurement Manager'),
       (2, 'Michael Jones', 'Email', 'Worker'),
       (1, 'Alice Brown', 'Phone Number', 'Worker');

-- Insert into Budget (using existing or newly inserted Employee IDs)
INSERT INTO Budget (Employee_ID, Category, Sum, Year)
VALUES (1, 'Office Supplies', 1000.00, 2024),  -- Replace 1 with actual Employee ID
       (2, 'Technology', 5000.00, 2024);  -- Replace 2 with actual Employee ID

-- Insert into Supplier
INSERT INTO Supplier (Name, Type, Company)
VALUES ('ABC Stationery', 'Office Supplies', 'ABC Inc.'),
       ('Tech Supplies Inc.', 'Technology', 'Tech Supplies Corp.');

-- Insert into Order (using existing Supplier IDs and replacing category IDs)
INSERT INTO Order (Supplier_ID, Product_Name, Quantity, Category)
VALUES (1, 'Pencils', 100, ?),  -- Replace ? with actual category ID for office supplies
       (2, 'Printer cartridges', 5, ?); -- Replace ? with actual category ID for technology
       
INSERT INTO Invoice (Order_ID, Date, Amount)
VALUES (1, '2024-05-28', 50.00);  -- Replace date and amount with actual values

INSERT INTO Payment (Date, Amount, Employee_ID, Payment_Purpose)
VALUES ('2024-05-27', 2000.00, 1, 'Salary');  -- Replace date, amount, and purpose with actual data
