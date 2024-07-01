18/6/24

•	Shay Mordechai			315689042

•	Yair Miller			314695438

                                                  School Management System

Stage 3:

1. **Invoice**

```sql
CREATE OR REPLACE FUNCTION calculate_budget_total(
    p_employee_id NUMBER, 
    p_budget_year NUMBER, 
    p_expense_category VARCHAR2
) 
RETURN NUMBER 
IS
    v_total_budget NUMBER := 0; 
BEGIN
    SELECT NVL(SUM(BUDGET_AMOUNT), 0)  -- Use NVL to handle NULL cases
    INTO v_total_budget
    FROM Budget
    WHERE EMPLOYEE_ID = p_employee_id
      AND BUDGET_YEAR = p_budget_year
      AND EXPENSE_CATEGORY = p_expense_category;

    RETURN v_total_budget;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred in calculate_budget_total: ' || SQLERRM);
        RETURN 0;
END calculate_budget_total;
/
```
Procedures:
```sql
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
        -- Optionally, log the error before re-raising it.
        DBMS_OUTPUT.PUT_LINE('An error occurred in update_budget_amount: ' || SQLERRM);
        -- Optionally, you could handle rollback here if needed.
        -- ROLLBACK;
        RAISE;
END update_budget_amount;
/


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
        -- Log the error before re-raising.
        DBMS_OUTPUT.PUT_LINE('An error occurred in list_budget_items: ' || SQLERRM);
        -- Ensure the cursor is closed in case of an error.
        IF budget_cursor%ISOPEN THEN
            CLOSE budget_cursor;
        END IF;
        RAISE;
END list_budget_items;
/
```
Main:
```sql
DECLARE
   v_employee_id NUMBER := 1500;
   v_budget_year NUMBER := 2014;
   v_expense_category VARCHAR2(50) := 'Rent or Lease Payments';
   v_total_budget NUMBER;
   v_new_amount NUMBER := 15000;
   v_threshold NUMBER := 10000;
   is_worker BOOLEAN := TRUE; -- Example worker status
BEGIN
   -- Call the function to get the total budget
   v_total_budget := calculate_budget_total(v_employee_id, v_budget_year, v_expense_category);
   DBMS_OUTPUT.PUT_LINE('Total budget for employee ID ' || v_employee_id || ' in year ' || v_budget_year || ' for category ' || v_expense_category || ': ' || v_total_budget);

   -- Check if the total budget is below the threshold
   IF v_total_budget < v_threshold AND is_worker THEN
      -- Call the procedure to update the budget amount
      update_budget_amount(v_employee_id, v_budget_year, v_expense_category, v_new_amount);
      DBMS_OUTPUT.PUT_LINE('Budget amount updated for year ' || v_budget_year || ' and category ' || v_expense_category || ' to ' || v_new_amount);
   ELSE
      DBMS_OUTPUT.PUT_LINE('No update needed. Total budget is above the threshold.');
   END IF;

   -- Call the procedure to list all budget items
   list_budget_items(v_employee_id, v_budget_year);
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/
```
![Output:](<Program 1/Output.png>)
2. **Payments**

Get and Display payments on a period.

Function:
```sql
CREATE OR REPLACE FUNCTION get_payments_in_period(start_date DATE, end_date DATE) 
RETURN SYS_REFCURSOR IS
    payment_cursor SYS_REFCURSOR;
BEGIN
    OPEN payment_cursor FOR
        SELECT PAYMENT_ID, EMPLOYEE_ID, PAYMENT_DATE, AMOUNT, PAYMENT_PURPOSE
        FROM Payment
        WHERE PAYMENT_DATE BETWEEN start_date AND end_date
        ORDER BY PAYMENT_DATE;
    RETURN payment_cursor;
END;
/
```
Procedure:
```sql
CREATE OR REPLACE PROCEDURE display_payments(start_date DATE, end_date DATE) IS
    payment_cursor SYS_REFCURSOR;
    
    -- Define a record type that matches the structure of the Payment table
    TYPE payment_record IS RECORD (
        PAYMENT_ID Payment.PAYMENT_ID%TYPE,
        EMPLOYEE_ID Payment.EMPLOYEE_ID%TYPE,
        PAYMENT_DATE Payment.PAYMENT_DATE%TYPE,
        AMOUNT Payment.AMOUNT%TYPE,
        PAYMENT_PURPOSE Payment.PAYMENT_PURPOSE%TYPE
    );
    
    payment_rec payment_record;
BEGIN
    -- Get the cursor from the function
    payment_cursor := get_payments_in_period(start_date, end_date);
    
    -- Fetch and display payments
    LOOP
        FETCH payment_cursor INTO payment_rec;
        EXIT WHEN payment_cursor%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('Payment ID: ' || payment_rec.PAYMENT_ID || 
                             ', Employee ID: ' || payment_rec.EMPLOYEE_ID || 
                             ', Payment Date: ' || TO_CHAR(payment_rec.PAYMENT_DATE, 'YYYY-MM-DD') || 
                             ', Amount: ' || payment_rec.AMOUNT ||
                             ', Purpose: ' || payment_rec.PAYMENT_PURPOSE);
    END LOOP;
    
    -- Close the cursor
    CLOSE payment_cursor;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/
```
Main:
```sql
-- Demonstration block
DECLARE
    v_start_date DATE := TO_DATE('2024-01-01', 'YYYY-MM-DD');
    v_end_date DATE := TO_DATE('2024-12-31', 'YYYY-MM-DD');
BEGIN
    -- Call the procedure to display payments
    display_payments(v_start_date, v_end_date);
END;
/
```
![Output:](<Program 2/Output.png>)
