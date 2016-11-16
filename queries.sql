--JOINS
-- * Get all invoices where the unit price on the invoice line is greater than $0.99
Select * from InvoiceLine il join invoice i
on il.invoiceid = i.invoiceid
where unitprice > 0.99;

--* Get all invoices and show me their invoice date, customer first and last names, and total
Select i.invoicedate, c.firstname,
c.lastname, i.total
from customer c join invoice i
on c.customerid = i.customerid;

--* Get all customers and show me their first name, last name, and support rep first name and last name (support reps are on the Employees table)
Select c.firstname, c.lastname,
e.firstname, e.lastname
from customer c join employee e
on e.employeeid = c.supportrepid;

--* Get all Albums and show me the album title and the artist name
Select al.title, a.name
from album al join artist a
on al.artistid = a.artistid;

--* Get all Playlist Tracks where the playlist name is Music

Select p.playlistid, p.name, pl.trackid from playlist p join playlisttrack pl
on p.playlistid = pl.playlistid
where p.name = "Music";

--* Get all Tracknames for playlistId 5

Select p.playlistid, t.name trackName
from track t join playlisttrack p
on p.trackid = t.trackid
where p.playlistid = 5;

--* Now we want all tracknames and the playlist name that they're on (You'll have to use 2 joins)

Select p.name playlist, t.name track
from track t join playlisttrack pt
on pt.trackid = t.trackid
join playlist p
on pt.playlistid = p.playlistid
order by p.name;

--* Get all Tracks that are alternative and show me the track name and the album name (2 joins)
Select t.name, a.title
from genre g join track t
on g.genreid = t.genreid
join album a
on t.albumid = a.albumid
where g.name like "alternative";

--#### Black Diamond :
--* Get all tracks on the playlist(s) called Music and show their name, genre name, album name, and artist name (at least 5 joins)
Select t.name trackName, g.name genre,
al.title album, ar.name artist,
p.name playlist
from genre g join track t
on g.genreid = t.genreid
join playlisttrack pt
on pt.trackid = t.trackid
join playlist p
on p.playlistid = pt.playlistid
join album al
on t.albumid = al.albumid
join artist ar
on ar.artistid = al.artistid
where p.name like "music";

--SUBQUERIES
--* Get all invoices where the unit price on the invoice line is greater than $0.99
Select * from invoice
where invoiceid in
(select invoiceId from invoiceline
where unitprice > 0.99);

--* Get all Playlist Tracks where the playlist name is Music
Select * from playlisttrack
where playlistid in
(select playlistId from playlist
where name like "music");

--* Get all Tracknames for playlistId 5
Select name from track
where trackid in
(select trackId from playlisttrack
where playlistid = 5);

--* Get all tracks where the genre is comedy
Select * from track
where genreid in
(select genreId from genre
where name like "comedy");

--* Get all tracks where the album is Fireball
Select * from track
where albumid in
(select albumId from album
where title like "fireball");

--* Get all tracks for the artist queen Queen (2 nested subqueries)
Select * from track
where albumid in
(select albumId from album
where artistid in
 (select artistid
 from artist where name like "queen"));

--* Find all customers with fax numbers and set those numbers to null
update customer
set fax = null
where fax is not null;

--* Find all customers with no company (null) and set their company to self
update customer
set company = "self"
where company is null;

--* Find the customer `Julia Barnett` and change her last name to `Thompson`
update customer
set lastname = "Thompson"
where firstname like "Julia"
and lastname like "barnett";

--* Find the customer with this email `luisrojas@yahoo.cl` and change his support rep to rep 4
update customer
set supportrepid = 4
where email like "luisrojas@yahoo.cl";

--* Find all tracks that are of the genre `Metal` and that have no composer and set the composer to be 'The darkness around us'
update track
set composer = "The darkness around us"
where genreid = 3
and composer is null;

--* Find a count of how many tracks there are per genre
select count(*) from track
group by genreid;

--* Find a count of all Tracks where the Genre is pop
select g.name, count(*) from track t
join genre g
on t.genreid = g.genreid
where g.name like "pop";

--* Find a list of all artist and how many albums they have
select ar.name, count(*) from album al
join artist ar
on ar.artistid = al.artistid
group by ar.name;

--* From the tracks table find a unique list of all composers
select distinct composer from track;

--* From the Invoice table find a unique list of all Billing postal codes
select distinct billingpostalcode
from invoice;

--* From the Customer table find a unique list of all companies
select distinct company
from customer;

--skipped deletes because can't do them on chinook-web
