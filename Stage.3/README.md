**1/7/24**

- **Shay Mordechai** - 315689042
- **Yair Miller** - 314695438

# School Management System

## Stage 3:

### 1. **Main** Budget Management Program

**Program**: Checking the total budget and adding additional budget if needed

**Description**: 
This program checks the total budget amount for a specific employee in a given fiscal year and category. If the total amount is below a certain threshold, the program updates the budget amount and prints the updated amount. The main program uses a function to calculate the total amount and a procedure to list the budget items.

**Code**:
```sql
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
```

**Function:** `calculate_budget_total`

**Description**: 
This function calculates the total budget amount for a specific employee in a given fiscal year and category.

**Code**:
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
END calculate_budget_total;
/
```

**Procedure:** `list_budget_items`

**Description**: 
This procedure displays the budget items for a specific employee in a given fiscal year.

**Code**:
```sql
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
```

**Procedure:** `update_budget_amount`

**Description**: 
This procedure updates the budget amount for a specific employee in a given fiscal year and category.

**Code**:
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
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
        ROLLBACK;
END update_budget_amount;
/
```

![Output](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.3/Program.01/Output.png)

### 2. **Main** Payment Management Program

**Program**: Retrieving and displaying payments for a given period

**Description**: 
This program includes a function to retrieve a list of payments for a given period using a Ref Cursor, and a procedure to display the payments retrieved by the function in a structured format. The main program sets the desired period, calls the procedure to display the payments, and handles errors if necessary.

**Code**:
```sql
DECLARE
    v_start_date DATE := TO_DATE('2024-01-01', 'YYYY-MM-DD');
    v_end_date DATE := TO_DATE('2024-12-31', 'YYYY-MM-DD');
    payment_cursor SYS_REFCURSOR;
BEGIN
    BEGIN
        display_payments(v_start_date, v_end_date);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error in display_payments: ' || SQLERRM);
    END;

    BEGIN
        payment_cursor := get_payments_in_period(v_start_date, v_end_date);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error in get_payments_in_period: ' || SQLERRM);
    END;
END;
/
```

**Function:** `get_payments_in_period`

**Description**: 
This function receives a start date and an end date, and returns a list of payments within those dates using a Ref Cursor.

**Code**:
```sql
CREATE OR REPLACE FUNCTION get_payments_in_period(
       start_date DATE,
       end_date DATE
)
RETURN SYS_REFCURSOR IS
    payment_cursor SYS_REFCURSOR;
BEGIN
    OPEN payment_cursor FOR
        SELECT PAYMENT_ID, EMPLOYEE_ID, PAYMENT_DATE, AMOUNT, PAYMENT_PURPOSE
        FROM Payment
        WHERE PAYMENT_DATE BETWEEN start_date AND end_date
        ORDER BY PAYMENT_DATE;
    RETURN payment_cursor;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
        RETURN NULL;
END get_payments_in_period;
/
```

**Procedure:** `display_payments`

**Description**: 
This procedure receives a start date and an end date, uses the `get_payments_in_period` function to retrieve payments for the given period, and displays the details of each payment.

**Code**:
```sql
CREATE OR REPLACE PROCEDURE display_payments(
       start_date DATE,
       end_date DATE
)
IS
    payment_cursor SYS_REFCURSOR;

    TYPE payment_record IS RECORD (
        PAYMENT_ID Payment.PAYMENT_ID%TYPE,
        EMPLOYEE_ID Payment.EMPLOYEE_ID%TYPE,
        PAYMENT_DATE Payment.PAYMENT_DATE%TYPE,
        AMOUNT Payment.AMOUNT%TYPE,
        PAYMENT_PURPOSE Payment.PAYMENT_PURPOSE%TYPE
    );

    payment_rec payment_record;
BEGIN
    payment_cursor := get_payments_in_period(start_date, end_date);

    LOOP
        FETCH payment_cursor INTO payment_rec;
        EXIT WHEN payment_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Payment ID: ' || payment_rec.PAYMENT_ID ||
                             ', Employee ID: ' || payment_rec.EMPLOYEE_ID ||
                             ', Payment Date: ' || TO_CHAR(payment_rec.PAYMENT_DATE, 'YYYY-MM-DD') ||
                             ', Amount: ' || payment_rec.AMOUNT ||
                             ', Purpose: ' || payment_rec.PAYMENT_PURPOSE);
    END LOOP;

    CLOSE payment_cursor;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
        IF payment_cursor%ISOPEN THEN
            CLOSE payment_cursor;
        END IF;
END display_payments;
/
```

![Output](https://github.com/shay0129/DBProject_315689042_314695438/blob/main/Stage.3/Program.02/Output.png)

---

This README now includes a complete and correct description in English, with SQL code and explanations for each part of the system.