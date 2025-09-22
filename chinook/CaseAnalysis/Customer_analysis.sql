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

-- Top 5 customers by revenue
SELECT C.CustomerId as Cid,C.FirstName,C.Lastname,C.Country as Country,sum(Iv.Total) as total_revenue
from Customer as C
INNER JOIN Invoice as Iv
on C.CustomerId = Iv.CustomerId
Group by Cid
ORDER BY total_revenue DESC
LIMIT 10;

-- Bottom 10 customers by revenue
SELECT C.CustomerId as Cid,C.FirstName,C.Lastname,C.Country as Country,sum(Iv.Total) as total_revenue
from Customer as C
INNER JOIN Invoice as Iv
on C.CustomerId = Iv.CustomerId
Group by Cid
ORDER BY total_revenue ASC
LIMIT 10;

-- Number of customers per country.
select C.Country, count(C.Country) as NumberOfCustomers
from Customer as C
GROUP BY Country
ORDER BY NumberOfCustomers;

-- Top 5 countries with the most customers.
select C.Country, count(C.Country) as NumberOfCustomers
from Customer as C
GROUP BY Country
ORDER BY NumberOfCustomers DESC
LIMIT 5;

-- Which cities have the highest concentration of customers?
SELECT City,Count(City) as NumberOfCustomers
from Customer 
GROUP BY City
ORDER BY NumberOfCustomers DESC;

-- Customers who made < 7 purchase.
select C.FirstName,C.LastName,count(Iv.InvoiceId) as PurchaseCount
from Customer as C
LEFT JOIN Invoice as Iv
on C.CustomerId = Iv.CustomerId
GROUP BY C.FirstName,C.LastName
HAVING PurchaseCount < 7
ORDER BY PurchaseCount;

-- Customers grouped by their assigned SupportRep (Employee table).
Select C.FirstName as CustomerFirstName, C.LastName as CustomerLastName, E.FirstName as EmployeeFirstName, E.LastName as EmployeeLastName
from Customer C
LEFT JOIN Employee E
on C.SupportRepId = E.EmployeeId;

-- Total number of customers handled by each SupportRep.
select E.FirstName as EmployeeFirstName, E.LastName as EmployeeLastName, count(C.CustomerId) as NumberOfCustomers
from Employee as E
LEFT JOIN Customer as C
on E.EmployeeId = C.SupportRepId
Group by EmployeeFirstName,EmployeeLastName
ORDER by NumberOfCustomers DESC;

-- Most popular genre by customer.
SELECT 
  C.CustomerId,
  C.FirstName,
  C.LastName,
  G.Name AS GenreName,
  COUNT(Inv.InvoiceLineId) AS TimesPurchased
FROM Customer AS C
INNER JOIN Invoice AS Iv
  ON C.CustomerId = Iv.CustomerId
INNER JOIN InvoiceLine AS Inv
  ON Iv.InvoiceId = Inv.InvoiceId
INNER JOIN Track AS T
  ON Inv.TrackId = T.TrackId
INNER JOIN Genre AS G
  ON T.GenreId = G.GenreId
GROUP BY C.CustomerId, C.FirstName, C.LastName, G.Name
ORDER BY C.CustomerId, TimesPurchased DESC;

-- To get only the top genre per customer (one per person):
SELECT *
FROM (
SELECT 
 C.CustomerId as Cid,
 C.FirstName as Fname,
 C.LastName Lname,
 G.Name as GenreName,
 count(G.Name) as GenreCount,
 Rank() OVER (PARTITION BY C.CustomerId ORDER BY count(G.Name) DESC) as GenreRank
FROM Customer C
INNER JOIN Invoice Iv
 ON Iv.CustomerId = C.CustomerId
INNER JOIN InvoiceLine Inv
 on Iv.InvoiceId = Inv.InvoiceId
INNER JOIN Track T
 ON T.TrackId = Inv.TrackId
INNER JOIN Genre G
 ON T.GenreId = G.GenreId
GROUP BY C.CustomerId,C.FirstName,C.LastName,G.Name
)Ranked
Having GenreRank = 1

-- Customers who purchased across multiple genres.
select C.CustomerId as Cid, C.FirstName Fname, C.LastName as Lname,
 count(Distinct(G.Name)) as GenreCount
FROM Customer C
INNER JOIN Invoice Iv
 ON Iv.CustomerId = C.CustomerId
INNER JOIN InvoiceLine Inv
 on Iv.InvoiceId = Inv.InvoiceId
INNER JOIN Track T
 ON T.TrackId = Inv.TrackId
INNER JOIN Genre G
 ON T.GenreId = G.GenreId
GROUP BY C.CustomerId,C.FirstName,C.LastName
having GenreCount > 1

-- Which media type (MP3, AAC, etc.) each customer prefers.
WITH MediaCounts AS (
  SELECT 
    C.CustomerId AS Cid,
    C.FirstName AS Fname,
    C.LastName AS Lname,
    M.Name AS Mediatype,
    COUNT(*) AS PurchaseCount,
    ROW_NUMBER() OVER (
      PARTITION BY C.CustomerId 
      ORDER BY COUNT(*) DESC
    ) AS rn
  FROM Customer C
  INNER JOIN Invoice Iv
    ON Iv.CustomerId = C.CustomerId
  INNER JOIN InvoiceLine Inv
    ON Iv.InvoiceId = Inv.InvoiceId
  INNER JOIN Track T
    ON T.TrackId = Inv.TrackId
  INNER JOIN MediaType M
    ON T.MediaTypeId = M.MediaTypeId
  GROUP BY C.CustomerId, C.FirstName, C.LastName, M.Name
)
SELECT Cid, Fname, Lname, Mediatype, PurchaseCount
FROM MediaCounts
WHERE rn = 1;
