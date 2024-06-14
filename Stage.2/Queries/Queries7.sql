UPDATE Supplier
SET Inventory = Inventory * 1.10
WHERE Supplier_ID IN (
    SELECT o.Supplier_ID
    FROM Orders o
    JOIN Supplier s ON o.Supplier_ID = s.Supplier_ID
    GROUP BY o.Supplier_ID, s.Inventory
    HAVING SUM(o.Quantity) > 35
    AND ABS(s.Inventory - SUM(o.Quantity)) < 20
);

SELECT *
FROM Supplier s
SET Inventory = Inventory * 1.10
WHERE Supplier_ID IN (
    SELECT o.Supplier_ID
    FROM Orders o
    JOIN Supplier s ON o.Supplier_ID = s.Supplier_ID
    GROUP BY o.Supplier_ID, s.Inventory
    HAVING SUM(o.Quantity) > 35
    AND ABS(s.Inventory - SUM(o.Quantity)) < 20
);
