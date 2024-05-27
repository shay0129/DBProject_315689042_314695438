-- Drop tables in the reverse order they were created in your schema 
-- (to avoid foreign key constraint errors)

DROP TABLE Invoice;
DROP TABLE Payment;
DROP TABLE Order;
DROP TABLE Supplier;

-- Revoke grants before dropping tables
REVOKE UPDATE ON Budget FROM 'Budget Committee';
REVOKE UPDATE ON Order FROM 'Procurement Manager';

DROP TABLE Employee;
DROP TABLE Budget;
