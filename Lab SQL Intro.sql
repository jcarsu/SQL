SHOW DATABASES;
USE sakila;
SHOW tables;
SELECT * FROM actor;
SELECT * FROM film;
SELECT * FROM customer;
SELECT title 
FROM film;
SELECT language_id AS language
FROM film;
SELECT COUNT(*) 
FROM sales_by_store;
SELECT COUNT(*) 
FROM staff_list;
SELECT (first_name) 
FROM staff;