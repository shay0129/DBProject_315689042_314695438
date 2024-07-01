-- This procedure updates the amount of payments made within a specified period and displays the total amount.
CREATE OR REPLACE PROCEDURE update_and_display_payments(start_date DATE, end_date DATE) IS
    CURSOR payment_cursor IS
        SELECT payment_id, employee_id, payment_date, amount
        FROM Payments
        WHERE payment_date BETWEEN start_date AND end_date
        FOR UPDATE;
    
    payment_rec payment_cursor%ROWTYPE;
    total_amount DECIMAL(10, 2) := 0;
    v_exception EXCEPTION;
BEGIN
    OPEN payment_cursor;
    LOOP
        FETCH payment_cursor INTO payment_rec;
        EXIT WHEN payment_cursor%NOTFOUND;
        
        -- דוגמה לעדכון פרטים של תשלום
        UPDATE Payments
        SET amount = amount * 1.1 -- מעלה את הסכום ב-10%
        WHERE CURRENT OF payment_cursor;
        
        -- מחשב את הסכום הכולל של התשלומים
        total_amount := total_amount + payment_rec.amount;
        
        -- דוגמה להסתעפות
        IF payment_rec.amount > 1000 THEN
            DBMS_OUTPUT.PUT_LINE('High payment: ' || payment_rec.payment_id);
        END IF;
    END LOOP;
    CLOSE payment_cursor;
    
    DBMS_OUTPUT.PUT_LINE('Total amount of payments in period: ' || total_amount);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        RAISE v_exception;
END;
