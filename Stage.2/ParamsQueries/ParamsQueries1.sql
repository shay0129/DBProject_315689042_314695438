SELECT s.Supplier_ID, s.Supplier_Name, o.Order_ID
FROM Orders o
JOIN Supplier s ON o.Supplier_ID = s.Supplier_ID
JOIN Employee e ON o.Employee_ID = e.Employee_ID
JOIN Invoice i ON o.Invoice_ID = i.Invoice_ID
WHERE i.Invoice_Date BETWEEN TO_DATE (&from, 'DD-MM-YYYY') AND TO_DATE (&to, 'DD-MM-YYYY')
 AND o.quantity > &quantityMin 
 AND s.inventory > &inventoryMin
ORDER BY i.Invoice_Date;
