-- Revoke grants before dropping tables
REVOKE UPDATE (Budget_Code, Sum) ON Budget FROM 'Budget Committee';
REVOKE UPDATE (Quantity) ON `Order` FROM 'Procurement Manager';

-- Drop tables in the reverse order they were created in your schema 
-- (to avoid foreign key constraint errors)
DROP TABLE IF EXISTS Invoice;
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS `Order`;
DROP TABLE IF EXISTS Supplier;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Budget;
