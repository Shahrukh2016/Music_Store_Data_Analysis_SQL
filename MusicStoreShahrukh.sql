/* BASIC ANALYSIS */
------------------------------------------------------------------
/* 1. Who is the senior most exployee based on job title? */
SELECT FIRST_NAME, LAST_NAME FROM EMPLOYEE
ORDER BY LEVELS DESC
LIMIT 1

/* 2. Which countries have the most invoices? */
SELECT BILLING_COUNTRY, COUNT(INVOICE_ID) FROM INVOICE
GROUP BY BILLING_COUNTRY
ORDER BY COUNT(BILLING_COUNTRY) DESC
LIMIT 1

/* 3. What are top 3 values of total invoice? */
SELECT TOTAL FROM INVOICE
ORDER BY TOTAL DESC
LIMIT 3

/* 4. Which city has the best customers?
	  We would like to throw a promotional Music Festival in the city we made the most money.
	  Write a query that returns one city that has the highest sum of invoice totals.
	  Return both the city name & sum of all invoice totals */
SELECT BILLING_CITY, SUM(TOTAL) FROM INVOICE
GROUP BY BILLING_CITY
ORDER BY SUM(TOTAL) DESC

/* 5. Who is the best customer?
	  The customer who has spent the most money will be declared the best customer.
	  Write a query that returns the person who has spent the most money */
SELECT C.CUSTOMER_ID, C.FIRST_NAME, C.LAST_NAME, SUM(I.TOTAL) AS TOTAL_SPENT
FROM CUSTOMER AS C
INNER JOIN INVOICE AS I
ON C.CUSTOMER_ID=I.CUSTOMER_ID
GROUP BY C.CUSTOMER_ID
ORDER BY TOTAL_SPENT DESC
LIMIT 1

/* MORDERATE ANALYSIS */
------------------------------------------------------------------
/* 1. Write query to return the email, first name, last name, & Genre of all Rock Music listeners.
	  Return your list ordered alphabetically by email starting with A. */
SELECT EMAIL, FIRST_NAME, LAST_NAME FROM CUSTOMER
JOIN INVOICE ON CUSTOMER.CUSTOMER_ID=INVOICE.CUSTOMER_ID
JOIN INVOICE_LINE ON INVOICE.INVOICE_ID=INVOICE_LINE.INVOICE_ID
WHERE TRACK_ID IN (SELECT TRACK_ID FROM TRACK
				  JOIN GENRE ON TRACK.GENRE_ID=GENRE.GENRE_ID
				  WHERE GENRE.NAME ILIKE 'ROCK')
ORDER BY EMAIL ASC

/* 2. Let's invite the artists who have written the most rock music in our dataset.
	  Write a query that returns the Artist name and total track count of the top 10 rock bands */
SELECT ARTIST.ARTIST_ID, ARTIST.NAME, COUNT(ARTIST.ARTIST_ID) AS NUMBER_OF_SONGS
FROM ARTIST
JOIN ALBUM ON ARTIST.ARTIST_ID=ALBUM.ARTIST_ID
JOIN TRACK ON ALBUM.ALBUM_ID=TRACK.ALBUM_ID
JOIN GENRE ON TRACK.GENRE_ID=GENRE.GENRE_ID
WHERE GENRE.NAME ILIKE 'ROCK'
GROUP BY ARTIST.ARTIST_ID
ORDER BY NUMBER_OF_SONGS DESC
LIMIT 10 

/* 3. Return all the track names that have a song length longer than the average song length.
	  Return the Name and Milliseconds for each track.
	  Order by the song length with the longest songs listed first. */
SELECT NAME, MILLISECONDS FROM TRACK
WHERE MILLISECONDS > (SELECT AVG(MILLISECONDS) FROM TRACK)
ORDER BY MILLISECONDS DESC














