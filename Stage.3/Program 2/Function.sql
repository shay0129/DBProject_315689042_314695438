CREATE OR REPLACE FUNCTION calculate_total_invoice_cost(p_supplier_id INT)
RETURN DECIMAL
IS
    v_total_cost DECIMAL := 0;
BEGIN
    SELECT SUM(Invoice_Cost)
    INTO v_total_cost
    FROM Invoice
    WHERE Supplier_ID = p_supplier_id;
    
    RETURN v_total_cost;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        RAISE;
END calculate_total_invoice_cost;
