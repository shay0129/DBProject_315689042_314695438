CREATE OR REPLACE NONEDITIONABLE PROCEDURE list_budget_items(
    p_employee_id NUMBER,
    p_budget_year NUMBER
)
IS -- IS: Declare the procedure
    CURSOR budget_cursor IS -- IS: Declare a cursor
        SELECT EXPENSE_CATEGORY, BUDGET_AMOUNT
        FROM Budget
        WHERE EMPLOYEE_ID = p_employee_id
          AND BUDGET_YEAR = p_budget_year;

    budget_rec budget_cursor%ROWTYPE; -- Record type to hold cursor data
BEGIN
    OPEN budget_cursor;
    LOOP
        FETCH budget_cursor INTO budget_rec; -- Fetch into the record type, because the cursor is strongly typed.
        EXIT WHEN budget_cursor%NOTFOUND; -- Exit the loop when no more rows are found.
        DBMS_OUTPUT.PUT_LINE('Category: ' || budget_rec.EXPENSE_CATEGORY || ', Amount: ' || budget_rec.BUDGET_AMOUNT);
    END LOOP;
    CLOSE budget_cursor;
END list_budget_items;
/
