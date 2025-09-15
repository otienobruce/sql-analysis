show databases;

use Chinook;

show tables;

-- overview of the available table

select * from Album;

select * from Artist;

select * from Customer;

select * from Employee;

select * from Genre;

select * from Invoice;

select * from InvoiceLine;

select * from MediaType;

select * from Playlist;

select * from PlaylistTrack;

select * from Track;


-- There are some tables which have relationships.
--  1 - the Albums and Artist tables
-- 2 - Customer and Invoice tables
-- 3 - InvoiceLine and Invoice tables
-- 4 - Track - Album,mediatype,genreid

-- Artist and Album joins

select Artist.ArtistId,Artist.Name,Album.AlbumId,Album.Title
from Artist
INNER JOIN Album
ON Artist.ArtistId = Album.AlbumId;

-- From the inner join of artists, we can actually check some few things,
-- We can check for - The number of Albums released by each artist helping
-- us to know productivity of each artist as shown below.

select Artist.ArtistId, Artist.Name, COUNT(Album.AlbumId) as Album_count
from Artist
INNER JOIN Album
ON Album.ArtistId = Artist.ArtistId
GROUP BY Artist.ArtistId
ORDER BY Album_count;

select * 
from Customer
inner join Invoice
on Customer.CustomerId = Invoice.CustomerId
Order by Invoice.Total;

-- joins from customer -> invoice relationship
select Customer.CustomerId,Customer.FirstName,Customer.LastName,Customer.Country,Invoice.InvoiceId,Invoice.BillingCity,Invoice.Total
from Customer
INNER JOIN Invoice
on Customer.CustomerId = Invoice.CustomerId
ORDER BY CustomerId;

select * 
from InvoiceLine
inner JOIN Invoice
on Invoice.InvoiceId = InvoiceLine.InvoiceId
ORDER BY InvoiceLineId;

SELECT 
    t.TrackId,
    t.Name AS TrackName,
    a.Title AS AlbumTitle,
    g.Name AS Genre,
    m.Name AS MediaType
FROM Track t
INNER JOIN Album a ON t.AlbumId = a.AlbumId
INNER JOIN Genre g ON t.GenreId = g.GenreId
INNER JOIN MediaType m ON t.MediaTypeId = m.MediaTypeId;


SELECT 
    g.Name AS Genre,
    SUM(il.UnitPrice * il.Quantity) AS Revenue
FROM InvoiceLine il
INNER JOIN Track t ON il.TrackId = t.TrackId
INNER JOIN Genre g ON t.GenreId = g.GenreId
GROUP BY g.Name
ORDER BY Revenue DESC;

-- Above are some of the join statements that we have used,
-- This are not all, we will go into full analysis later on,
-- for now we are just doing an overall analysis of the joins,
-- so we ca get a clear picture of what they look like