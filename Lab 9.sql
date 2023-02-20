
# Lab | SQL Self and cross join
#In this lab, you will be using the Sakila database of movie rentals.

#Instructions

#1. Get all pairs of actors that worked together.

use sakila;
select fa1.actor_id as actor_1, concat(a.first_name,' ',a.last_name) as full_name, fa2.film_id as film, fa2.actor_id as actor_2, 
concat(ac.first_name,' ',a.last_name) as full_name
from film_actor fa1
join film_actor fa2
on fa1.film_id=fa2.film_id and fa1.actor_id<>fa2.actor_id
join actor a on fa1.actor_id=a.actor_id
join actor ac on fa2.actor_id=ac.actor_id
order by fa1.film_id;

#2. Get all pairs of customers that have rented the same film more than 3 times.

#select r.customer_id as customer1, re.customer_id as customer2, count(r.rental_id) as rental
#from rental r
#join rental re
#on r.inventory_id = re.inventory_id
#group by r.rental_id, r.customer_id, re.customer_id
#having rental>3
#order by rental DESC;

#select r.customer_id as customer1, re.customer_id as customer2, r.inventory_id, count(r.inventory_id) 
#over (partition by r.inventory_id) as rental
#from rental r
#join rental re
#on r.inventory_id = re.inventory_id AND r.customer_id>re.customer_id
#GROUP BY r.rental_id, r.customer_id, re.customer_id
#Order by rental desc;

SELECT inventory_id, COUNT(rental_id) FROM sakila.rental
GROUP BY inventory_id
order by COUNT(rental_id) DESC;

#R= No hay pelicula que se haya rentado mas de 5 veces por lo que no puede pareja que rentara 3 veces o mas el filme.

#3. Get all possible pairs of actors and films.

SELECT a.actor_id, a.first_name, a.last_name, f.title
FROM actor a
CROSS JOIN film f
order by title;

#Prueba si funciona

SELECT a.actor_id, a.first_name, a.last_name, f.title
FROM actor a
CROSS JOIN film f
where f.title= 'WINDOW SIDE';
