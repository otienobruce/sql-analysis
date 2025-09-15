-- Revenue by customer
select C.CustomerId as Cid,C.FirstName,C.Lastname,C.Country,Iv.Total as total_revenue
from Customer as C
INNER JOIN Invoice as Iv
on C.CustomerId = Iv.CustomerId
ORDER BY Cid DESC;

-- total revenue per customer
select C.CustomerId as Cid,C.FirstName,C.Lastname,C.Country as Country,sum(Iv.Total) as total_revenue
from Customer as C
INNER JOIN Invoice as Iv
on C.CustomerId = Iv.CustomerId
Group by Cid
ORDER BY total_revenue DESC;

-- Customers who never placed an order
select C.CustomerId,C.FirstName,C.LastName
from Customer AS C
left JOIN Invoice as Iv
on C.CustomerId = Iv.CustomerId
where Iv.CustomerId is null;

-- Active Customers. - Which Customers Placed the most invoices
select C.CustomerID,C.FirstName,C.LastName, count(Iv.InvoiceId) as OrderCount
from Customer as C
Inner JOIN Invoice as Iv
Where C.CustomerID = Iv.CustomerId
GROUP BY C.CustomerID,C.FirstName,C.LastName
ORDER BY OrderCount;

-- Total number of invoices per customer.
select C.CustomerID,C.FirstName,C.LastName, count(Iv.InvoiceId) as InvoiceCount
from Customer as C
Inner JOIN Invoice as Iv
Where C.CustomerID = Iv.CustomerId
GROUP BY C.CustomerID,C.FirstName,C.LastName
ORDER BY InvoiceCount;

-- Average invoice value per customer.
select C.CustomerID,C.FirstName,C.LastName, AVG(Iv.Total) as AvgTotal
from Customer as C
Inner JOIN Invoice as Iv
Where C.CustomerID = Iv.CustomerId
GROUP BY C.CustomerID,C.FirstName,C.LastName
ORDER BY AvgTotal;

-- Agg comparison per customer
SELECT 
    C.CustomerID,
    C.FirstName,
    C.LastName,
    COUNT(Iv.InvoiceId) AS InvoiceCount,
    SUM(Iv.Total) AS TotalRevenue,
    AVG(Iv.Total) AS AvgInvoiceValue,
    min(Iv.Total) as MinSpend,
    MAX(Iv.Total) as MaxSpend
FROM Customer AS C
INNER JOIN Invoice AS Iv
    ON C.CustomerID = Iv.CustomerId
GROUP BY C.CustomerID, C.FirstName, C.LastName
ORDER BY TotalRevenue DESC;

