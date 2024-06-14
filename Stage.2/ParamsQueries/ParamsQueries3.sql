SELECT s.supplier_id, s.Supplier_Name, i.Invoice_Cost
FROM Invoice i
JOIN Supplier s ON i.Supplier_ID = s.Supplier_ID
WHERE i.Invoice_Date BETWEEN TO_DATE (&from, 'DD-MM-YYYY') AND TO_DATE (&to, 'DD-MM-YYYY')
 AND i.invoice_cost = &< name = "cost" list = "SELECT DISTINCT Invoice_Cost FROM Invoice" >
ORDER BY i.Invoice_Cost DESC;
