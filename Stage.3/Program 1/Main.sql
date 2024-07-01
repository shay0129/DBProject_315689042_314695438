DECLARE
   v_employee_id NUMBER := 1500;
   v_budget_year NUMBER := 2023;
   v_expense_category VARCHAR(50) := 'Travel';
   v_total_budget DECIMAL;
   v_new_amount DECIMAL := 15000;
   v_threshold DECIMAL := 10000;
   is_worker BOOLEAN := TRUE; -- Example worker status
BEGIN
   -- Call the function to get the total budget for the given employee ID, budget year, and expense category
   v_total_budget := calculate_budget_total(v_employee_id, v_budget_year, v_expense_category);
   DBMS_OUTPUT.PUT_LINE('Total budget for employee ID ' || v_employee_id || ' in year ' || v_budget_year || ' for category ' || v_expense_category || ': ' || v_total_budget);

   -- Check if the total budget is below the threshold
   IF v_total_budget < v_threshold AND is_worker THEN
      -- Call the procedure to update the budget amount for the given budget year and expense category
      update_budget_amount(v_budget_year, v_expense_category, v_new_amount);
      DBMS_OUTPUT.PUT_LINE('Budget amount updated for year ' || v_budget_year || ' and category ' || v_expense_category || ' to ' || v_new_amount);
   ELSE
      DBMS_OUTPUT.PUT_LINE('No update needed. Total budget is above the threshold.');
   END IF;

   -- Call the procedure to list all budget items for the given employee ID and budget year
   list_budget_items(v_employee_id, v_budget_year);
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/
