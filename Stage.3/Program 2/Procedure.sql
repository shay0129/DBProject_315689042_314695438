CREATE OR REPLACE PROCEDURE delete_supplier_with_invoices_v2(p_supplier_id INT)
IS
    CURSOR invoice_cursor IS
        SELECT Invoice_ID
        FROM Invoice
        WHERE Supplier_ID = p_supplier_id;
    
    invoice_rec invoice_cursor%ROWTYPE;
BEGIN
    OPEN invoice_cursor;
    LOOP
        FETCH invoice_cursor INTO invoice_rec;
        EXIT WHEN invoice_cursor%NOTFOUND;
        
        DELETE FROM Invoice
        WHERE Invoice_ID = invoice_rec.Invoice_ID;
    END LOOP;
    CLOSE invoice_cursor;
    
    DELETE FROM Supplier
    WHERE Supplier_ID = p_supplier_id;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END delete_supplier_with_invoices_v2;
