-- Select all columns from Employee table
SELECT * FROM Employee;

-- Select all columns from Budget table
SELECT * FROM Budget;

-- Select all columns from Order table
SELECT * FROM Order;

-- Select all columns from Supplier table
SELECT * FROM Supplier;

-- Select all columns from Invoice table
SELECT * FROM Invoice;

-- Select all columns from Payment table
SELECT * FROM Payment;

-- More specific selections (optional):

-- Select specific columns from Employee table (e.g., Name and Role)
SELECT Name, Role FROM Employee;

-- Select Budget details for a specific Employee (replace 1 with desired Employee_ID)
SELECT * FROM Budget WHERE Employee_ID = 1;

-- Select Orders placed with a specific Supplier (replace 1 with desired Supplier_ID)
SELECT * FROM Order WHERE Supplier_ID = 1;
