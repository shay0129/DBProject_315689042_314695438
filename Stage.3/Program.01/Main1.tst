DECLARE
   v_employee_id NUMBER := 1920;
   v_budget_year NUMBER := 2015;
   v_expense_category VARCHAR2(50) := 'PC Services';
   v_total_budget NUMBER;
   v_new_amount NUMBER := 15000;
   v_threshold NUMBER := 10000;
BEGIN
   BEGIN
      v_total_budget := calculate_budget_total(v_employee_id, v_budget_year, v_expense_category);
      DBMS_OUTPUT.PUT_LINE('Total budget for employee ID ' || v_employee_id || ' in year ' || v_budget_year || ' for category ' || v_expense_category || ': ' || v_total_budget);

      IF v_total_budget < v_threshold THEN
         update_budget_amount(v_employee_id, v_budget_year, v_expense_category, v_new_amount);
         DBMS_OUTPUT.PUT_LINE('Budget amount updated for year ' || v_budget_year || ' and category ' || v_expense_category || ' to ' || v_new_amount);
      ELSE
         DBMS_OUTPUT.PUT_LINE('No update needed. Total budget is above the threshold.');
      END IF;

      list_budget_items(v_employee_id, v_budget_year);
   EXCEPTION
      WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
   END;
END;
/