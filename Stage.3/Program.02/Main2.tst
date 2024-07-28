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