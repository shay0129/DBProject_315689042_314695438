SELECT e.Employee_ID, e.Employee_Name
FROM Orders o
JOIN Supplier s ON o.Supplier_ID = s.Supplier_ID
JOIN Employee e ON o.Employee_ID = e.Employee_ID
WHERE e.job_title =  &< name = "title" list =  "Budget Committee, Procurement Manager, Worker" type = "string" > 
 AND e.seniority = &< name = ”seniority” list = "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20" > 
 AND s.supplier_name = &< name = ”supplierName” list = "SELECT DISTINCT Supplier_Name FROM Supplier" type = "string" >
ORDER BY e.Employee_ID;
