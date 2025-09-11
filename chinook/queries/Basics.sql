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
-- ORDER BY Album_count


