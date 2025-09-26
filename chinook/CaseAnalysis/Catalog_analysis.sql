-- 1.Track-Level

-- List of top-selling tracks by revenue.
-- The below approach is when we dont want to change modularity
SELECT
   T.TrackId,
   T.Name,
   sum(Inv.UnitPrice*Inv.Quantity) OVER(PARTITION BY T.TrackId) as trackrevenue
from Track T
INNER JOIN InvoiceLine Inv
on T.TrackId = Inv.TrackId

-- this other one is when we are intrested in the specific columns like the ondensed data.
 SELECT
   T.TrackId,
   T.Name,
   sum(Inv.UnitPrice*Inv.Quantity) as trackrevenue
from Track T
INNER JOIN InvoiceLine Inv
on T.TrackId = Inv.TrackId
GROUP BY T.TrackId,T.Name
ORDER BY trackrevenue DESC
LIMIT 10

-- Most purchased tracks (by quantity).
SELECT
   T.TrackId,
   T.Name,
   sum(Inv.Quantity) as trackquantity
from Track T
INNER JOIN InvoiceLine Inv
on T.TrackId = Inv.TrackId
GROUP BY T.TrackId,T.Name
ORDER BY trackquantity DESC
LIMIT 10

-- Average unit price per track purchase.
SELECT
   T.TrackId,
   T.Name,
   avg(Inv.UnitPrice*Inv.Quantity) as avgunitquantity
from Track T
INNER JOIN InvoiceLine Inv
on T.TrackId = Inv.TrackId
GROUP BY T.TrackId,T.Name
ORDER BY avgunitquantity DESC

-- 2. Album-Level

-- Revenue per album.
 select
  A.AlbumId,
  A.Title,
  sum(Inv.Quantity*Inv.UnitPrice) albumrevenue
 from InvoiceLine Inv
 inner join Track T
 on T.TrackId = Inv.TrackId
 INNER join Album A
 on T.AlbumId = A.AlbumId
 GROUP by A.AlbumId,A.Title
Order by A.AlbumId

-- Top-selling albums.
select
  A.AlbumId,
  A.Title,
  sum(Inv.Quantity*Inv.UnitPrice) albumrevenue
 from InvoiceLine Inv
 inner join Track T
 on T.TrackId = Inv.TrackId
 INNER join Album A
 on T.AlbumId = A.AlbumId
 GROUP by A.AlbumId,A.Title
 Having sum(Inv.Quantity*Inv.UnitPrice) > 10.00
Order by albumrevenue DESC

-- 3. Artist-Level

-- Revenue per artist.
select 
    Ar.ArtistId,
    Ar.Name artist,
    sum(Inv.Quantity*Inv.UnitPrice) revenue
from Artist Ar
inner join Album A
on Ar.ArtistId = A.ArtistId
inner join Track T
on T.AlbumId = A.AlbumId
inner join InvoiceLine Inv
on Inv.TrackId = T.TrackId
GROUP by Ar.ArtistId,Ar.Name
order by Ar.ArtistId

-- Top-selling artists by revenue.
select 
    Ar.ArtistId,
    Ar.Name artist,
    sum(Inv.Quantity*Inv.UnitPrice) revenue,
    Rank() OVER (order by  sum(Inv.Quantity*Inv.UnitPrice) ) as ranked
from Artist Ar
inner join Album A
on Ar.ArtistId = A.ArtistId
inner join Track T
on T.AlbumId = A.AlbumId
inner join InvoiceLine Inv
on Inv.TrackId = T.TrackId
GROUP by Ar.ArtistId,Ar.Name
Order by revenue Desc

-- Artists with the most albums in the catalog.
select
    A.ArtistId,
    A.Name,
    count(A.ArtistId) as numberofalbums
from Artist A
inner join Album Al
on A.ArtistId = Al.ArtistId
GROUP by A.ArtistId,A.Name
order by numberofalbums Desc

-- 4. Genre-Level

-- Revenue per genre.
select 
    G.GenreId,
    G.Name,
    sum(Inv.Quantity*Inv.UnitPrice) as genrevenue,
    rank() over(order by sum(Inv.Quantity*Inv.UnitPrice) desc) as grank
from Genre G
inner join Track T
on G.GenreId = T.GenreId
inner join InvoiceLine Inv
on Inv.TrackId = T.TrackId
GROUP by G.genreId,G.Name
order by genrevenue Desc
  

-- Most popular genre overall.
with revenue as (
select 
    G.GenreId,
    G.Name,
    sum(Inv.Quantity*Inv.UnitPrice) as genrevenue,
    rank() over(order by G.GenreId) as grank
from Genre G
inner join Track T
on G.GenreId = T.GenreId
inner join InvoiceLine Inv
on Inv.TrackId = T.TrackId
GROUP by G.genreId,G.Name
order by genrevenue Desc
)

select * from revenue Having grank = 1

-- Most popular genre by country
WITH GenreRank AS (
    SELECT 
        G.GenreId,
        G.Name AS GenreName,
        C.Country,
        COUNT(G.GenreId) AS GenreCount,
        row_number() OVER (
            PARTITION BY C.Country 
            order by COUNT(G.GenreId) desc
        ) AS rn
    FROM Genre G
    INNER JOIN Track T
        ON G.GenreId = T.GenreId
    INNER JOIN InvoiceLine Inv
        ON Inv.TrackId = T.TrackId
    INNER JOIN Invoice I
        ON Inv.InvoiceId = I.InvoiceId
    INNER JOIN Customer C
        ON C.CustomerId = I.CustomerId
    GROUP BY G.GenreId, G.Name, C.Country
)
SELECT GenreId, GenreName, Country, GenreCount,rn
FROM GenreRank
WHERE rn = 1
ORDER BY GenreCount DESC;

-- 5. MediaType-Level

-- Revenue by media type.
select 
    Mt.MediaTypeId,
    Mt.Name,
    sum(Inv.Quantity*Inv.UnitPrice) as revenue
from MediaType Mt
inner join Track T
 on T.MediaTypeId = Mt.MediaTypeId
inner join InvoiceLine Inv
 on Inv.TrackId = T.TrackId
GROUP by Mt.MediaTypeId,Mt.Name
order by revenue desc
   
-- Most popular media type by sales.
with popularank as (
select 
    Mt.MediaTypeId,
    Mt.Name,
    sum(Inv.Quantity*Inv.UnitPrice) as revenue,
    row_number() over (order by sum(Inv.Quantity*Inv.UnitPrice) desc) as rn
from MediaType Mt
inner join Track T
 on T.MediaTypeId = Mt.MediaTypeId
inner join InvoiceLine Inv
 on Inv.TrackId = T.TrackId
GROUP by Mt.MediaTypeId,Mt.Name
order by revenue desc
)

select * from popularank where rn = 1



