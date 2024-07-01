CREATE OR REPLACE FUNCTION calculate_budget_total(p_employee_id NUMBER, p_budget_year NUMBER, p_expense_category VARCHAR)
RETURN DECIMAL
IS
   v_total_budget DECIMAL := 0; 
BEGIN
   SELECT SUM(Budget_Amount)
   INTO v_total_budget
   FROM Budget
   WHERE Employee_ID = p_employee_id
     AND Budget_Year = p_budget_year
     AND Expense_Category = p_expense_category;

   RETURN v_total_budget;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      RETURN 0;
   WHEN OTHERS THEN
      RAISE;
END calculate_budget_total;
/
