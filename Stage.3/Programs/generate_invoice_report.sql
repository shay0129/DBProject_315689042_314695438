-- Desc: This program generates a report of all invoices for a given supplier.

CREATE OR REPLACE FUNCTION generate_invoice_report(p_supplier_id INT)
RETURN SYS_REFCURSOR
IS
   v_cursor SYS_REFCURSOR;
BEGIN
   OPEN v_cursor FOR
      SELECT Invoice_ID, Invoice_Cost, Invoice_Date
      FROM Invoice
      WHERE Supplier_ID = p_supplier_id;

   RETURN v_cursor;
EXCEPTION
   WHEN OTHERS THEN
      RAISE;
END generate_invoice_report;
/

-- Step 1: Insert Test Data
INSERT INTO Supplier (Supplier_ID, Supplier_Name, Contact_Information, Inventory)
VALUES (1234, 'Test Supplier', '123 Test St', 5000);

INSERT INTO Invoice (Invoice_ID, Supplier_ID, Invoice_Cost, Invoice_Date)
VALUES (1001, 1234, 500.00, TO_DATE('2024-01-01', 'YYYY-MM-DD'));

INSERT INTO Invoice (Invoice_ID, Supplier_ID, Invoice_Cost, Invoice_Date)
VALUES (1002, 1234, 1500.00, TO_DATE('2024-02-01', 'YYYY-MM-DD'));

INSERT INTO Invoice (Invoice_ID, Supplier_ID, Invoice_Cost, Invoice_Date)
VALUES (1003, 1234, 2000.00, TO_DATE('2024-03-01', 'YYYY-MM-DD'));

COMMIT;

-- Step 2: Call the Function and Fetch the Results
DECLARE
   v_invoice_cursor SYS_REFCURSOR;
   v_invoice_id     Invoice.Invoice_ID%TYPE;
   v_invoice_cost   Invoice.Invoice_Cost%TYPE;
   v_invoice_date   Invoice.Invoice_Date%TYPE;
BEGIN
   v_invoice_cursor := generate_invoice_report(1234);

   LOOP
      FETCH v_invoice_cursor INTO v_invoice_id, v_invoice_cost, v_invoice_date;
      EXIT WHEN v_invoice_cursor%NOTFOUND;

      -- Display the results
      DBMS_OUTPUT.PUT_LINE('Invoice ID: ' || v_invoice_id || ', Cost: ' || v_invoice_cost || ', Date: ' || v_invoice_date);
   END LOOP;

   CLOSE v_invoice_cursor;
END;
/
