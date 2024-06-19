-- Desc: This script creates a function that returns a ref cursor containing all payments made to a specific employee.
CREATE OR REPLACE FUNCTION get_employee_payments(p_employee_id NUMBER)
RETURN SYS_REFCURSOR
IS
   v_cursor SYS_REFCURSOR;
BEGIN
   OPEN v_cursor FOR
      SELECT Payment_ID, Amount, Payment_Purpose, Payment_Date
      FROM Payment
      WHERE Employee_ID = p_employee_id;

   RETURN v_cursor;
EXCEPTION
   WHEN OTHERS THEN
      RAISE;
END get_employee_payments;
/

-- Test the function
CREATE OR REPLACE FUNCTION get_employee_payments(p_employee_id NUMBER)
RETURN SYS_REFCURSOR
IS
v_cursor SYS_REFCURSOR;
BEGIN
OPEN v_cursor FOR
SELECT Payment_ID, Amount, Payment_Purpose, Payment_Date
FROM Payment
WHERE Employee_ID = p_employee_id;

RETURN v_cursor;
EXCEPTION
WHEN OTHERS THEN
RAISE;
END get_employee_payments;
/