-- Constraint for Employee table
ALTER TABLE Employee
ADD CONSTRAINT Job_Title
CHECK (Job_Title IN ('Budget Committee', 'Procurement Manager', 'Worker'));

-- Constraint for Orders table
ALTER TABLE Orders
MODIFY Quantity DEFAULT 1;

-- Constraint for Payment table
ALTER TABLE Payment
ADD CONSTRAINT Payment_Purpose
CHECK (Payment_Purpose IN ('Salary', 'Bonus', 'Grant'));

