PL/SQL Developer Test script 3.0
25
DECLARE
   v_employee_id NUMBER := 1500;
   v_budget_year NUMBER := 2014;
   v_expense_category VARCHAR2(50) := 'Rent or Lease Payments';
   v_total_budget NUMBER;
   v_new_amount NUMBER := 15000;
   v_threshold NUMBER := 10000;
BEGIN
   -- Call the function to get the total budget
   v_total_budget := calculate_budget_total(v_employee_id, v_budget_year, v_expense_category);
   DBMS_OUTPUT.PUT_LINE('Total budget for employee ID ' || v_employee_id || ' in year ' || v_budget_year || ' for category ' || v_expense_category || ': ' || v_total_budget);

   -- Check if the total budget is below the threshold
   IF v_total_budget < v_threshold THEN
      -- Call the procedure to update the budget amount
      update_budget_amount(v_employee_id, v_budget_year, v_expense_category, v_new_amount);
      DBMS_OUTPUT.PUT_LINE('Budget amount updated for year ' || v_budget_year || ' and category ' || v_expense_category || ' to ' || v_new_amount);
   ELSE
      DBMS_OUTPUT.PUT_LINE('No update needed. Total budget is above the threshold.');
   END IF;

   -- Call the procedure to list all budget items
   list_budget_items(v_employee_id, v_budget_year);
END;
/
0
0
