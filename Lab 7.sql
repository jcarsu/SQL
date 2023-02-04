# Lab | SQL Join
#In this lab, you will be using the Sakila database of movie rentals.

#Instructions

#1. List the number of films per category.

use sakila;
select distinct c.name as category, count(fc.film_id) as number_of_films
from category c
inner join film_category as fc
on fc.category_id=c.category_id
group by name;

#2. Display the first and the last names, as well as the address, of each staff member.

select s.first_name, s.last_name, a.address, s.address_id 
from staff s
inner join address as a
on s.address_id=a.address_id
group by staff_id;

#3. Display the total amount rung up by each staff member in August 2005.

select distinct staff_id as staff_member, sum(amount) as amount_proccessed 
from payment
where month(payment_date)=8
group by staff_member;

#4. List all films and the number of actors who are listed for each film.

select f.film_id, title, count(actor_id) as actors
from film f
inner join film_actor fa
on f.film_id=fa.film_id
group by actor_id;


#5. Using the payment and the customer tables as well as the JOIN command, 
#list the total amount paid by each customer. List the customers alphabetically by their last names.

select c.customer_id, first_name, last_name, sum(p.amount) as amount_paid
from customer c
inner join payment p
on c.customer_id=p.customer_id
group by last_name
order by last_name asc;

