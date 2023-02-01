#Lab | SQL Queries 8
#In this lab, you will be using the Sakila database of movie rentals.

#Instructions

#1. Rank films by length (filter out the rows with nulls or zeros in length column).
#Select only columns title, length and rank in your output.

USE sakila;
SELECT title, length, rank() over(order by length desc) as 'RANK'
FROM film
WHERE length IS NOT NULL;

#2. Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). 
#In your output, only select the columns title, length, rating and rank.

SELECT title, length, rating, rank() over(order by length desc) as 'RANK'
FROM film
WHERE length IS NOT NULL;

#3. How many films are there for each of the categories in the category table? 
#Hint: Use appropriate join between the tables "category" and "film_category".

SELECT DISTINCT title, category_id, rating AS category, RANK() OVER(ORDER BY rating DESC) as 'RANK'
FROM film f
INNER JOIN film_category AS fc ON f.rating=fc.category_id;

#4. Which actor has appeared in the most films?
#Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor 
#appears.

SELECT first_name, last_name, a.actor_id, count(*) AS total_films
FROM actor a
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.last_name
ORDER BY count(*) DESC;

#5. Which is the most active customer (the customer that has rented the most number of films)? 
#Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.

SELECT first_name, last_name, c.customer_id, COUNT(*) AS total_rentals
FROM customer c
INNER JOIN rental r ON c.customer_id=r.customer_id
GROUP BY c.last_name
ORDER BY COUNT(*) DESC;

#Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).
#This query might require using more than one join statement. Give it a try. 
#We will talk about queries with multiple join statements later in the lessons.
#Hint: You can use join between three tables - 
#"Film", "Inventory", and "Rental" and count the rental ids for each film.

SELECT i.film_id, f.title, 
COUNT(*) AS times_rented FROM rental r
JOIN inventory i ON r.inventory_id=i.inventory_id
JOIN film f ON i.film_id=f.film_id
GROUP BY f.title
ORDER BY COUNT(*) DESC;