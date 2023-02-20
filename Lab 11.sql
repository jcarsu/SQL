# Lab | SQL Subqueries
#In this lab, you will be using the Sakila database of movie rentals. Create appropriate joins wherever necessary.

#Instructions

#1. How many copies of the film Hunchback Impossible exist in the inventory system?

use sakila;
select count(i.inventory_id) as copies, i.film_id, f.title from inventory i
join film f
on i.film_id=f.film_id
where f.title= 'HUNCHBACK IMPOSSIBLE';

#2. List all films whose length is longer than the average of all the films.

#Opcion 1
select avg(length) from film;
select title, length from film
where length > 115.2720
order by length desc;

#Opcion 2
select title, length from film
where length > (
select avg(length)
from film) 
order by length desc;

#3. Use subqueries to display all actors who appear in the film Alone Trip.

select * from (
select a.first_name, a.last_name, f.title as film 
from actor a
join film_actor fa on a.actor_id=fa.actor_id
join film f on fa.film_id=f.film_id) sub1
where film= 'ALONE TRIP';

#4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
#Identify all movies categorized as family films.

select * from (
select fc.category_id, c.name as category, f.title as film 
from category c
join film_category fc on c.category_id=fc.category_id
join film f on fc.film_id=f.film_id) sub1
where category= 'Family';

#5. Get name and email from customers from Canada using subqueries. Do the same with joins. 
#Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys,
#that will help you get the relevant information.

select * from (
select c.first_name, c.last_name, c.email, ci.city, co.country as country
from customer c
join address a on a.address_id=c.address_id
join city ci on a.city_id=ci.city_id
join country co on ci.country_id=co.country_id) sub1
where country= 'Canada';

select c.first_name, c.last_name, c.email, ci.city, co.country as country
from customer c
join address a on a.address_id=c.address_id
join city ci on a.city_id=ci.city_id
join country co on ci.country_id=co.country_id
where country='Canada';

#6. Which are films starred by the most prolific actor? 
#Most prolific actor is defined as the actor that has acted in the most number of films. 
#First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.

select a.first_name, a.last_name, fa.actor_id, count(fa.film_id) as number_of_films
from actor a
join film_actor fa
on a.actor_id=fa.actor_id
group by actor_id
order by number_of_films desc;

select fa.actor_id, a.first_name, a.last_name, fa.film_id, f.title as film
from film_actor fa
join actor a on fa.actor_id=a.actor_id
join film f on fa.film_id=f.film_id
where a.actor_id=107;


#7. Films rented by most profitable customer. 
#You can use the customer table and payment table to find the most profitable customer 
#ie the customer that has made the largest sum of payments.

SELECT DISTINCT f.title AS title, COUNT(r.customer_id) OVER (PARTITION BY r.customer_id) AS rented_films, r.customer_id as client
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
WHERE r.customer_id = (select ID FROM (
SELECT c.customer_id AS ID,  CONCAT( c.first_name, ' ' , c.last_name) AS Nombre , SUM(p.amount)  AS Monto
FROM customer AS c
JOIN payment as p ON c.customer_id = p.customer_id
GROUP BY c.first_name, c.last_name, c.customer_id
ORDER BY Monto DESC LIMIT 1) as sub1)
GROUP BY r.customer_id, f.title;

#8. Get the client_id and the total_amount_spent of those clients 
#who spent more than the average of the total_amount spent by each client.

select c.customer_id as client_id, sum(p.amount) as total_amount_spent
from customer c
join payment p on c.customer_id=p.customer_id
group by c.customer_id
having sum(p.amount) > (select avg(total_amount_spent) from (select c.customer_id as client_id,
sum(p.amount) as total_amount_spent
from customer c
join payment p on c.customer_id=p.customer_id
group by c.customer_id
order by total_amount_spent desc) sub1)
order by total_amount_spent desc;


