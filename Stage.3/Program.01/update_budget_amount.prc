CREATE OR REPLACE PROCEDURE update_budget_amount(
    p_employee_id NUMBER,
    p_budget_year NUMBER,
    p_expense_category VARCHAR2,
    p_new_amount NUMBER
)
IS
BEGIN
    UPDATE Budget
    SET BUDGET_AMOUNT = p_new_amount
    WHERE EMPLOYEE_ID = p_employee_id
      AND BUDGET_YEAR = p_budget_year
      AND EXPENSE_CATEGORY = p_expense_category;

    -- Optionally, you can choose to commit here if this procedure is standalone and handles its own transactions.
    -- COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred in update_budget_amount: ' || SQLERRM);
        -- Optionally, you could handle rollback here if needed.
        -- ROLLBACK;
        RAISE;
END update_budget_amount;
/
