-- MUSIC STORE ANALYSIS
-- -----------------------------------------------------------------------------
-- Who is the senior most employee based on job title? 
select * from employee;

select * from employee
order by levels desc
limit 1;

-- ----------------------------------------------------------------------------
-- Which countries have the most Invoices?
select * from invoice;

select billing_country, count(*) as total_invoice
from invoice
group by billing_country
order by total_invoice desc
limit 1;

-- ---------------------------------------------------------------------------
-- What are top 3 values of total invoice?
select * from invoice;

select total from invoice
order by total desc
limit 3;

-- ---------------------------------------------------------------------------
/* Which city has the best customers? We would like to throw a promotional Music 
Festival in the city we made the most money. Write a query that returns one city that 
has the highest sum of invoice totals. Return both the city name & sum of all invoice 
totals */
select * from invoice;

select billing_city, round(sum(total), 2) as invoice_total
from invoice
group by billing_city
order by invoice_total desc
limit 5;

-- ---------------------------------------------------------------------------
/* Who is the best customer? The customer who has spent the most money will be 
declared the best customer. Write a query that returns the person who has spent the 
most money */
select * from customer;
select * from invoice;

select concat(first_name,' ', last_name) as full_name,
round(sum(total), 2) as total_amount from customer as c
join invoice as i
on c.customer_id = i.customer_id
group by full_name
order by total_amount desc
limit 1;

-- -----------------------------------------------------------------------
/* Write query to return the email, first name, last name, & Genre of all Rock Music 
listeners. Return your list ordered alphabetically by email starting with A */
select * from genre;
select * from customer;
select * from track;
select * from invoice_line;

select distinct first_name, last_name, email from customer c
join invoice i on c.customer_id = i.customer_id
join invoice_line il on i.invoice_id = il.invoice_id
where track_id in (
			select track_id from track t
			join genre g on t.genre_id = g.genre_id
			where g.name like 'Rock'
)
order by email;

-- --------------------------------------------------------------------------------
/* Let's invite the artists who have written the most rock music in our dataset. Write a 
query that returns the Artist name and total track count of the top 10 rock bands */
select * from track;
select * from genre;
select * from artist;
select * from album;

select ar.artist_id, ar.name, count(ar.artist_id) as no_of_songs
from track as t
join album2 as ab on ab.album_id= t.album_id
join artist as ar on ab.artist_id= ar.artist_id
join genre g on g.genre_id= t.genre_id
where g.name like 'Rock'
group by ar.artist_id, ar.name
order by no_of_songs desc
limit 10;

-- ----------------------------------------------------------------------------
/* Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the 
longest songs listed first */
select * from track;

select name, milliseconds
from track
where milliseconds > 
	(select avg(milliseconds) as avg_track_length from track)
order by milliseconds desc;

-- ----------------------------------------------------------------------------
/* Find how much amount each customer spent by each customer on artists?
-- Write a query to return customer name, artist name and total spent */
select * from artist;
select * from customer;

select 
	at.artist_id as artist_id, 
    at.name as artist_name, 
    round(sum(il.unit_price * il.quantity),2) as total_sales
from invoice_line as il
join track as t on t.track_id= il.track_id
join album2 as a on a.album_id= t.album_id
join artist as at on at.artist_id = a.artist_id
group by at.artist_id, at.name
order by total_sales desc;


with best_selling_artist as (
	select 
		at.artist_id as artist_id, 
		at.name as artist_name, 
		sum(il.unit_price * il.quantity) as total_sales
	from invoice_line as il
		join track as t on t.track_id= il.track_id
		join album2 as a on a.album_id= t.album_id
		join artist as at on at.artist_id= a.artist_id
	group by at.artist_id, at.name
	order by total_sales desc)
select 
	c.customer_id, 
    c.first_name, 
    c.last_name, 
    bsa.artist_name, 
    round(sum(il.unit_price*il.quantity),2) as amount_spent
from invoice as i
join customer as c on c.customer_id= i.customer_id
join invoice_line as il on il.invoice_id= i.invoice_id
join track as t on t.track_id = il.track_id
join album2 as alb on alb.album_id = t.album_id
join best_selling_artist as bsa on bsa.artist_id= alb.artist_id
group by c.customer_id, c.first_name, c.last_name, bsa.artist_name
order by amount_spent desc;

-- ----------------------------------------------------------------------------
/* We want to find out the most popular music Genre for each country. We determine the 
most popular genre as the genre with the highest amount of purchases. Write a query 
that returns each country along with the top Genre. For countries where the maximum 
number of purchases is shared return all Genres */
with popular_genre as (
 	select 
		count(invoice_line.quantity) as purchases, 
        customer.country, genre.name, genre.genre_id,	
		row_number() over(partition by customer.country order by count(invoice_line.quantity) desc) as RowNo
 	from invoice_line
		join invoice on invoice.invoice_id= invoice_line.invoice_id
		join customer on customer.customer_id= invoice.customer_id
		join track on track.track_id= invoice_line.track_id
		join genre on genre.genre_id= track.genre_id
 	group by 2,3,4
 	order by 2 asc, 1 desc
 )
 select * from popular_genre where RowNo <= 1;
 
 -- ---------------------------------------------------------------------------
/* Write a query that determines the customer that has spent the most on music for each 
country. Write a query that returns the country along with the top customer and how 
much they spent. For countries where the top amount spent is shared, provide all 
customers who spent this amount  */
with customer_with_country as(
	select 
		customer.customer_id, 
        first_name, last_name, 
        billing_country, 
        round(sum(total),2) as total_spending,
		row_number() over (partition  by billing_country
	order by sum(total) desc) as RowNo
	from invoice
		join customer on customer.customer_id= invoice.customer_id
	group by 1,2,3,4
	order by 4 asc, 5 desc)
select * from customer_with_country where RowNo <= 1;