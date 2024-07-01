-- This program demonstrates how to use functions and procedures in PL/SQL.
DECLARE
    payment_cursor SYS_REFCURSOR;
    payment_rec Payments%ROWTYPE;
BEGIN
    payment_cursor := get_payments_in_period(TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'));
    
    LOOP
        FETCH payment_cursor INTO payment_rec;
        EXIT WHEN payment_cursor%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('Payment ID: ' || payment_rec.payment_id || ', Amount: ' || payment_rec.amount);
    END LOOP;
    CLOSE payment_cursor;
    
    update_and_display_payments(TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'));
END;
