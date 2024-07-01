DECLARE
    v_supplier_id INT := 123; -- Example supplier ID
    v_invoice_cursor SYS_REFCURSOR;
    v_invoice_rec Invoice%ROWTYPE;
    v_total_cost DECIMAL;
BEGIN
    -- Call the function to generate the invoice report for the given supplier ID
    v_invoice_cursor := generate_invoice_report(v_supplier_id);

    -- Fetch and display each invoice from the cursor
    LOOP
        FETCH v_invoice_cursor INTO v_invoice_rec;
        EXIT WHEN v_invoice_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Invoice ID: ' || v_invoice_rec.Invoice_ID || ', Cost: ' || v_invoice_rec.Invoice_Cost || ', Date: ' || v_invoice_rec.Invoice_Date);
    END LOOP;

    -- Close the cursor
    CLOSE v_invoice_cursor;

    -- Calculate and display total invoice cost
    v_total_cost := calculate_total_invoice_cost(v_supplier_id);
    DBMS_OUTPUT.PUT_LINE('Total Invoice Cost: ' || v_total_cost);

    -- Call the procedure to delete the supplier and its invoices
    delete_supplier_with_invoices_v2(v_supplier_id);
    DBMS_OUTPUT.PUT_LINE('Supplier and its invoices deleted successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
