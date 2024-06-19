-- Desc: This script creates a procedure that deletes a supplier and all of its invoices
CREATE OR REPLACE PROCEDURE delete_supplier_with_invoices(p_supplier_id INT)
IS
BEGIN
   DELETE FROM Invoice
   WHERE Supplier_ID = p_supplier_id;

   DELETE FROM Supplier
   WHERE Supplier_ID = p_supplier_id;

   COMMIT;
EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      RAISE;
END delete_supplier_with_invoices;
/

-- Test the procedure
--STEP1: Insert a new supplier and invoices
INSERT INTO Supplier (Supplier_ID, Supplier_Name, Contact_Information, Inventory)
VALUES (999, 'Test Supplier', '123 Test St', 1000);

INSERT INTO Invoice (Invoice_ID, Supplier_ID, Invoice_Cost, Invoice_Date)
VALUES (1001, 999, 500.00, TO_DATE('2024-01-01', 'YYYY-MM-DD'));

INSERT INTO Invoice (Invoice_ID, Supplier_ID, Invoice_Cost, Invoice_Date)
VALUES (1002, 999, 1500.00, TO_DATE('2024-02-01', 'YYYY-MM-DD'));

COMMIT;

--STEP2: Verify the records
select * from Invoice t WHERE Supplier_ID=999;

--STEP3: Call the procedure to delete the supplier and invoices
BEGIN
   delete_supplier_with_invoices(999);
END;
/

