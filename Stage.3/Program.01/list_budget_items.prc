CREATE OR REPLACE PROCEDURE list_budget_items(
    p_employee_id NUMBER,
    p_budget_year NUMBER
)
IS
    CURSOR budget_cursor IS
        SELECT EXPENSE_CATEGORY, BUDGET_AMOUNT
        FROM Budget
        WHERE EMPLOYEE_ID = p_employee_id
          AND BUDGET_YEAR = p_budget_year;

    budget_rec budget_cursor%ROWTYPE;
BEGIN
    OPEN budget_cursor;
    LOOP
        FETCH budget_cursor INTO budget_rec;
        EXIT WHEN budget_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Category: ' || budget_rec.EXPENSE_CATEGORY || ', Amount: ' || budget_rec.BUDGET_AMOUNT);
    END LOOP;
    CLOSE budget_cursor;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
        IF budget_cursor%ISOPEN THEN
            CLOSE budget_cursor;
        END IF;
END list_budget_items;
/