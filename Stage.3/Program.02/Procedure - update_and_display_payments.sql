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