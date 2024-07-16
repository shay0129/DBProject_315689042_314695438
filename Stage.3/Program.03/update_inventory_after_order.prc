CREATE OR REPLACE NONEDITIONABLE PROCEDURE update_inventory_after_order(p_order_id NUMBER)
IS
   v_supplier_id NUMBER;
   v_quantity NUMBER;
   CURSOR order_cursor IS
      SELECT Supplier_ID, Quantity
      FROM Orders
      WHERE Order_ID = p_order_id;
BEGIN
   OPEN order_cursor;
   FETCH order_cursor INTO v_supplier_id, v_quantity;
   CLOSE order_cursor;

   UPDATE Supplier
   SET Inventory = Inventory - v_quantity
   WHERE Supplier_ID = v_supplier_id;

   COMMIT;
END update_inventory_after_order;
/
