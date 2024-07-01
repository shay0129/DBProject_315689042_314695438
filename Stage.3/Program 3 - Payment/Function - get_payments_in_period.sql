-- This function retrieves payments made within a specified period.
CREATE OR REPLACE FUNCTION get_payments_in_period(start_date DATE, end_date DATE) 
RETURN SYS_REFCURSOR IS
    payment_cursor SYS_REFCURSOR;
BEGIN
    OPEN payment_cursor FOR
        SELECT payment_id, employee_id, payment_date, amount
        FROM Payments
        WHERE payment_date BETWEEN start_date AND end_date;
    RETURN payment_cursor;
END;
