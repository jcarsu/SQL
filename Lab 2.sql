#Lab | SQL Queries - Lesson 2.5

#In this lab, you will be using the Sakila database of movie rentals. 
#You can follow the steps listed here to get the data locally: Sakila sample database - installation.

#Instructions

SHOW DATABASES;
USE sakila;
SHOW TABLES;

#1. Select all the actors with the first name ‘Scarlett’.
SELECT * FROM actor
WHERE first_name='Scarlett';

#2. How many films (movies) are available for rent and how many films have been rented?
SELECT COUNT(inventory_id) 
FROM inventory;
SELECT COUNT(inventory_id)
FROM rental;

#3. What are the shortest and longest movie duration? Name the values max_duration and min_duration.
SELECT title, length 
FROM film
WHERE length IN ((SELECT MAX(length) FROM film AS max_duration), 
(SELECT MIN(length) FROM film AS min_duration));

#4. What's the average movie duration expressed in format (hours, minutes)?
SELECT TIME_FORMAT(sec_to_time((AVG(length))*60), "%H:%i") 
FROM film;

#5. How many distinct (different) actors' last names are there?
SELECT COUNT(DISTINCT last_name) 
FROM actor;

#6. Since how many days has the company been operating (check DATEDIFF() function)?
SELECT DATEDIFF(MAX(last_update),MIN(rental_date)) AS No_Of_days
FROM rental;

#7. Show rental info with additional columns month and weekday. Get 20 results.
#Extra para extraer meses:
ALTER TABLE rental
DROP COLUMN month;
ALTER TABLE rental
DROP COLUMN weekday;
select *, date_format(rental_date, '%M') as month , date_format(rental_date, '%W') as weekday
from rental
limit 20;

#8. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
SELECT *,
CASE WHEN DATE_FORMAT(rental_date, '%W') IN ('Saturday', 'Sunday') THEN 'Weekend' 
       ELSE 'Workday' END AS day_type
FROM rental;       

#9. How many rentals were in the last month of activity?
SELECT DATE_SUB(MAX(rental_date), INTERVAL 30 DAY)
FROM rental;
SELECT rental_date FROM rental 
WHERE 
COUNT(rental_date) BETWEEN
'2006-01-15 15:16:03' AND
 '2006-02-14 15:16:03';
#SELECT COUNT(rental_id)
#FROM rental
#WHERE rental_date BETWEEN '2006-02-14' AND '2006-01-15';