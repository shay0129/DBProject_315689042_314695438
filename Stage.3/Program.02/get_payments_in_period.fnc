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
