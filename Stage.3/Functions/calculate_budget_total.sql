-- Desc: This script creates a function that calculates the total budget for a given employee.
CREATE OR REPLACE FUNCTION calculate_budget_total(p_employee_id NUMBER)
RETURN DECIMAL
IS
   v_total_budget DECIMAL := 0;
BEGIN
   SELECT SUM(Budget_Amount)
   INTO v_total_budget
   FROM Budget
   WHERE Employee_ID = p_employee_id;

   RETURN v_total_budget;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      RETURN 0;
   WHEN OTHERS THEN
      RAISE;
END calculate_budget_total;
/

-- Test the function
SELECT calculate_budget_total(1500) AS total_budget_for_employee_1500 FROM dual;
