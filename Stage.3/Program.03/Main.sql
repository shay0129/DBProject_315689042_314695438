DECLARE
   v_employee_id NUMBER := 1883;
   v_start_date DATE := TO_DATE('01-01-2017', 'DD-MM-YYYY');
   v_end_date DATE := TO_DATE('01-04-2017', 'DD-MM-YYYY');
   v_order_id NUMBER;
   v_orders SYS_REFCURSOR;
BEGIN
   v_orders := get_employee_orders(v_employee_id, v_start_date, v_end_date);

   LOOP
      FETCH v_orders INTO v_order_id;
      EXIT WHEN v_orders%NOTFOUND;

      update_inventory_after_order(v_order_id);
   END LOOP;

   CLOSE v_orders;
END;
/
