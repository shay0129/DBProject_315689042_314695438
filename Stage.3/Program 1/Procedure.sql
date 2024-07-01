-- First procedure
CREATE OR REPLACE PROCEDURE update_budget_amount(p_budget_year INT, p_expense_category VARCHAR2, p_new_amount DECIMAL)
IS
BEGIN
   UPDATE Budget
   SET Budget_Amount = p_new_amount
   WHERE Budget_Year = p_budget_year AND Expense_Category = p_expense_category;

   COMMIT;
EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      RAISE;
END update_budget_amount;
/
-- Second procedure
CREATE OR REPLACE PROCEDURE list_budget_items(p_employee_id NUMBER, p_budget_year NUMBER)
IS
   CURSOR budget_cursor IS
      SELECT Expense_Category, Budget_Amount
      FROM Budget
      WHERE Employee_ID = p_employee_id AND Budget_Year = p_budget_year;
   
   budget_rec budget_cursor%ROWTYPE;
BEGIN
   OPEN budget_cursor;
   LOOP
      FETCH budget_cursor INTO budget_rec;
      EXIT WHEN budget_cursor%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE('Category: ' || budget_rec.Expense_Category || ', Amount: ' || budget_rec.Budget_Amount);
   END LOOP;
   CLOSE budget_cursor;
EXCEPTION
   WHEN OTHERS THEN
      RAISE;
END list_budget_items;
/
