-- Desc: This script demonstrates how to create a PL/SQL procedure to process orders.
CREATE OR REPLACE PROCEDURE process_orders
IS
   v_order_id Orders.Order_ID%TYPE;
   v_supplier_id Orders.Supplier_ID%TYPE;
   v_quantity Orders.Quantity%TYPE;
BEGIN
   FOR order_rec IN (SELECT Order_ID, Supplier_ID, Quantity
                     FROM Orders)
   LOOP
      v_order_id := order_rec.Order_ID;
      v_supplier_id := order_rec.Supplier_ID;
      v_quantity := order_rec.Quantity;

      UPDATE Supplier
      SET Inventory = Inventory - v_quantity
      WHERE Supplier_ID = v_supplier_id;

      COMMIT;
   END LOOP;
EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      RAISE;
END process_orders;
/

-- Test the procedure
-- Step 1: Insert Test Data
INSERT INTO Supplier (Supplier_ID, Supplier_Name, Contact_Information, Inventory)
VALUES (5678, 'Test Supplier', '123 Test St', 1000);

INSERT INTO Orders (Order_ID, Supplier_ID, Employee_ID, Invoice_ID, Quantity)
VALUES (2001, 5678, 100, 3001, 100);

INSERT INTO Orders (Order_ID, Supplier_ID, Employee_ID, Invoice_ID, Quantity)
VALUES (2002, 5678, 101, 3002, 200);

COMMIT;

-- Step 2: Call the Procedure
BEGIN
   process_orders;
END;
/

-- Step 3: Verify Results
SELECT Supplier_ID, Supplier_Name, Inventory
FROM Supplier
WHERE Supplier_ID = 5678;