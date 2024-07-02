CREATE OR REPLACE FUNCTION get_employee_orders(p_employee_id NUMBER, p_start_date DATE, p_end_date DATE)
RETURN SYS_REFCURSOR
IS
   v_orders SYS_REFCURSOR;
BEGIN
   OPEN v_orders FOR
      SELECT o.Order_ID
      FROM Orders o
      JOIN Invoice i ON o.Invoice_ID = i.Invoice_ID
      WHERE o.Employee_ID = p_employee_id
       AND i.Invoice_Date BETWEEN p_start_date AND p_end_date
      ORDER BY i.Invoice_Date;

   RETURN v_orders;
END get_employee_orders;
/


