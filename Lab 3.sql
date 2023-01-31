# Lab | SQL Queries - Lesson 2.6

#In this lab, you will be using the Sakila database of movie rentals. 
#You have been using this database for a couple labs already, 
#but if you need to get the data again, refer to the official installation link.

#The database is structured as follows: DB schema

#Instructions

#1. Get release years.

USE sakila;
SELECT title, release_year as realease 
FROM film;

#2. Get all films with ARMAGEDDON in the title.

SELECT *
FROM film
WHERE title REGEXP 'ARMAGEDDON';

#3. Get all films which title ends with APOLLO.

SELECT * FROM film
WHERE title REGEXP 'APOLO$';

#4. Get 10 the longest films.

SELECT max(length) from film;

SELECT title, length FROM film
WHERE length>=185
LIMIT 10;

#5. How many films include Behind the Scenes content?

SELECT COUNT(special_features) AS bs_content, title
FROM film
WHERE special_features REGEXP 'Behind the Scenes'
ORDER BY title;

#6. Drop column picture from staff.

ALTER TABLE staff
DROP COLUMN picture;
SELECT * FROM staff;

#7. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. 
	#Update the database accordingly.
    
UPDATE staff
SET first_name= COALESCE(NULL,'Tammy'), last_name= COALESCE(NULL,'Sanders'), address_id= COALESCE(NULL,7), 
email= COALESCE(NULL,'tammy.sanders@sakilastaff.com'), store_id= COALESCE(NULL,2), active= COALESCE(NULL,1), 
username= COALESCE(NULL,'Tammy'), last_update= COALESCE(NULL,'2023-02-15 13:50:40')
WHERE staff_id IS NULL;

SELECT * FROM staff;
    
#8. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. 
	#You can use current date for the rental_date column in the rental table. 
    #Hint: Check the columns in the table rental and see what information you would need to add there. 
    #You can query those pieces of information. 
    #For eg., you would notice that you need customer_id information as well. 
    #To get that you can use the following query:
		select customer_id from sakila.customer
		where first_name = 'CHARLOTTE' and last_name = 'HUNTER';

#Use similar method to get inventory_id, film_id, and staff_id.

SELECT film_id FROM film
WHERE title='Academy Dinosaur';

SELECT inventory_id FROM inventory
WHERE film_id=1;

select staff_id FROM staff
WHERE first_name='Mike';

UPDATE rental
SET rental_id=1002, rental_date='2023-01-30 22:18:40', inventory_id=1, customer_id=130, 
return_date='2023-02-05 22:05:00', staff_id=1, last_update='2023-02-15 13:50:40'
WHERE rental_id IS NULL;

INSERT INTO rental (rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
VALUES (1003, '2023-01-30 22:18:40', 1, 130, '2023-02-05 22:05:00', 1, '2023-02-15 13:50:40');

SELECT * FROM rental;

#9. Delete non-active users, but first, create a backup table deleted_users to store 
#customer_id, email, and the date for the users that would be deleted. Follow these steps:

	#Check if there are any non-active users
    
SELECT DISTINCT *, active AS non_active FROM customer
WHERE active=0;

	#Create a table backup table as suggested

CREATE DATABASE deleted_users;
USE deleted_users;
CREATE TABLE deleted_users (
`customer_id` int(11) UNIQUE NOT NULL,
`email` text,
`date` text,
CONSTRAINT PRIMARY KEY (`customer_id`));

	#Insert the non active users in the table backup table

INSERT INTO deleted_users VALUES
(16, 'SANDRA.MARTIN@sakilacustomer.org', '2006-02-14 22:04:36'),
(64, 'JUDITH.COX@sakilacustomer.org', '2006-02-14 22:04:36'),
(124, 'SHEILA.WELLS@sakilacustomer.org', '2006-02-14 22:04:36'),
(169, 'ERICA.MATTHEWS@sakilacustomer.org', '2006-02-14 22:04:36'),
(241, 'HEIDI.LARSON@sakilacustomer.org', '2006-02-14 22:04:36'),
(271, 'PENNY.NEAL@sakilacustomer.org', '2006-02-14 22:04:36'),
(315, 'KENNETH.GOODEN@sakilacustomer.org', '2006-02-14 22:04:36'),
(368, 'HARRY.ARCE@sakilacustomer.org', '2006-02-14 22:04:36'),
(406, 'NATHAN.RUNYON@sakilacustomer.org', '2006-02-14 22:04:36'),
(446, 'THEODORE.CULP@sakilacustomer.org', '2006-02-14 22:04:36'),
(482, 'MAURICE.CRAWLEY@sakilacustomer.org', '2006-02-14 22:04:36'),
(510, 'BEN.EASTER@sakilacustomer.org', '2006-02-14 22:04:36'),
(534, 'CHRISTIAN.JUNG@sakilacustomer.org', '2006-02-14 22:04:36'),
(558, 'JIMMIE.EGGLESTON@sakilacustomer.org', '2006-02-14 22:04:36'),
(592, 'TERRANCE.ROUSH@sakilacustomer.org', '2006-02-14 22:04:36');

SELECT * FROM deleted_users;

	#Delete the non active users from the table customer

USE sakila;
SET FOREIGN_KEY_CHECKS=0;
DELETE FROM customer 
WHERE active=0;

SELECT * FROM customer;