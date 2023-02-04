# Lab | SQL Joins on multiple tables
#In this lab, you will be using the Sakila database of movie rentals.

#Instructions

#1. Write a query to display for each store its store ID, city, and country.

use sakila;
select store_id, c.city, co.country from store s
inner join address a on a.address_id=s.address_id
inner join city c on a.city_id=c.city_id
inner join country co on c.country_id=co.country_id;

#2. Write a query to display how much business, in dollars, each store brought in.

select st.store_id as store, sum(p.amount) as dollars from payment p
inner join staff s on p.staff_id=s.staff_id
inner join store st on s.store_id=st.store_id
group by st.store_id;

#3. What is the average running time of films by category?

select fc.category_id as category, c.name, avg(f.length) as running_time 
from film f
inner join film_category fc on f.film_id=fc.film_id
inner join category c on fc.category_id=c.category_id
group by c.name;

#4. Which film categories are longest?

select fc.category_id as category, c.name, avg(f.length) as running_time 
from film f
inner join film_category fc on f.film_id=fc.film_id
inner join category c on fc.category_id=c.category_id
group by c.name
order by running_time desc;

#5. Display the most frequently rented movies in descending order.

select count(r.rental_id) as times_rented, f.title from rental r
inner join payment p on r.rental_id=p.rental_id
inner join inventory i on r.inventory_id=i.inventory_id
inner join film f on i.film_id=f.film_id
group by title
order by times_rented desc;

#6. List the top five genres in gross revenue in descending order.

select sum(p.amount) as gross_revenue, c.name as genres from payment p
inner join rental r on p.rental_id=r.rental_id
inner join inventory i on r.inventory_id=i.inventory_id
inner join film_category fc on i.film_id=fc.film_id
inner join category c on fc.category_id=c.category_id
group by genres
order by gross_revenue desc
limit 5;

#7. Is "Academy Dinosaur" available for rent from Store 1?

# A= Yes, it is available on store 1.
select f.title, i.store_id as store from inventory i
inner join film f on i.film_id=f.film_id
where f.title='ACADEMY DINOSAUR'
group by store;


