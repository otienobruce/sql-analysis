-- Total revenue
select sum(Total) as total_revenue
from Invoice;

-- Total revenue per city
select BillingCity as City, sum(Total) as total_revenue
from Invoice
GROUP BY BillingCity
ORDER BY total_revenue;

-- Total Revenue per country
select BillingCountry as Country, sum(Total) as total_revenue
from Invoice
GROUP BY BillingCountry
ORDER BY total_revenue;

-- Revenue by day of the month over the years 2021 - 2025
select DAY(InvoiceDate) as Day, sum(Total) as total_revenue
from Invoice
GROUP BY DAY
ORDER BY Day;

-- Revenue day of the week over the years 2021 - 2025
select DATE(InvoiceDate) as Day, sum(Total) as total_revenue
from Invoice
GROUP BY DAY
ORDER BY Day;

-- Top 10 customers by revenue
SELECT C.CustomerId,C.FirstName,C.LastName,C.Country,sum(Invoice.Total) as total_revenue
from Customer as C
INNER JOIN Invoice
on C.CustomerId = Invoice.CustomerId
GROUP BY CustomerId
ORDER BY total_revenue DESC
LIMIT 10;

-- Bottom 10 cutomers by revenue
SELECT C.CustomerId,C.FirstName,C.LastName,C.Country,sum(Invoice.Total) as total_revenue
from Customer as C
INNER JOIN Invoice
on C.CustomerId = Invoice.CustomerId
GROUP BY CustomerId
ORDER BY total_revenue 
LIMIT 10;

-- Revenue per employee (SupportRepId links Employee → Customer → Invoice)
select E.EmployeeId,E.LastName, E.FirstName,E.Title,sum(Invoice.Total) as total_revenue
from Customer as C
INNER join Employee as E 
 On C.SupportRepId = E.EmployeeId
Inner JOIN Invoice
 on C.CustomerId = Invoice.CustomerId
GROUP BY EmployeeId
ORDER BY total_revenue;

-- Revenue by genre (InvoiceLine → Track → Genre)
select Genre.GenreId, Genre.Name,sum(InvoiceLine.UnitPrice * InvoiceLine.Quantity) as revenue
from InvoiceLine
inner join Track 
 on Track.TrackId = InvoiceLine.TrackId
inner join Genre
 on Genre.GenreId = Track.GenreId
GROUP BY GenreId
ORDER BY revenue DESC;

-- Revenue by media type (InvoiceLine → Track → MediaType)
SELECT MediaType.MediaTypeId, MediaType.Name, sum(InvoiceLine.UnitPrice * InvoiceLine.Quantity) as revenue
from InvoiceLine
Inner join Track
 on Track.TrackId = InvoiceLine.TrackId
Inner Join MediaType
 on Track.MediaTypeId = MediaType.MediaTypeId
Group by MediaTypeId
Order by revenue