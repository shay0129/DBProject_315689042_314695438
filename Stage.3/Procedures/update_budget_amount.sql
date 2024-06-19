-- Desc: This script creates a procedure to update the budget amount for a given budget code.
CREATE OR REPLACE PROCEDURE update_budget_amount(p_budget_code INT, p_new_amount DECIMAL)
IS
BEGIN
   UPDATE Budget
   SET Budget_Amount = p_new_amount
   WHERE Budget_Code = p_budget_code;

   COMMIT;
EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      RAISE;
END update_budget_amount;
/

-- Test the procedure
--STEP1: Insert a new record into the Budget table
INSERT INTO Budget (Budget_Code, Employee_ID, Expense_Category, Budget_Amount, Budget_Year)
VALUES (1001, 1500, 'Office Supplies', 500.00, 2024);

COMMIT;
--STEP2: Call the procedure to update the budget amount
BEGIN
   update_budget_amount(1001, 1000.00); -- Update the budget amount to 1000.00 for Budget_Code 1001
END;
/
--STEP3: Verify the update
SELECT Budget_Code, Employee_ID, Expense_Category, Budget_Amount, Budget_Year
FROM Budget
WHERE Budget_Code = 1001;
