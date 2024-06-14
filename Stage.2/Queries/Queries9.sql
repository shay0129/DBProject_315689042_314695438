DELETE FROM Supplier
WHERE Supplier_ID NOT IN (
    SELECT DISTINCT s.Supplier_ID
    FROM Orders o
    JOIN Supplier s ON o.Supplier_ID = s.Supplier_ID
    JOIN Invoice i ON o.Invoice_ID = i.Invoice_ID
    WHERE i.Invoice_Cost > 5.0
      AND EXTRACT(YEAR FROM i.Invoice_Date) >= EXTRACT(YEAR FROM SYSDATE) - 20
);

SELECT *
FROM Supplier s
WHERE Supplier_ID NOT IN (
    SELECT DISTINCT s2.Supplier_ID
    FROM Orders o
    JOIN Supplier s2 ON o.Supplier_ID = s2.Supplier_ID
    JOIN Invoice i ON o.Invoice_ID = i.Invoice_ID
    WHERE  i.Invoice_Cost > 5.0
      AND EXTRACT(YEAR FROM i.Invoice_Date) >= EXTRACT(YEAR FROM SYSDATE) - 20
);
