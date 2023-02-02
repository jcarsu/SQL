# Lab | SQL Queries 9

#Instructions
#In this lab we will find the customers who were active in consecutive months of May and June. 
#Follow the steps to complete the analysis.

#1. Create a table rentals_may to store the data from rental table with information for the month of May.

use sakila;
create table rentals_may (
rental_id int(11) unique not null,
rental_date datetime default null,
inventory_id int(11) default null,
customer_id int(11) default null,
return_date datetime default null,
staff_id int(11) default null,
last_update datetime default null,
constraint primary key (rental_id)
);

select * from rentals_may;

#2. Insert values in the table rentals_may using the table rental, filtering values only for the month of May.

insert into rentals_may
select * from rental
WHERE rental_date between '2005-05-01 00:00:00' and '2005-05-31 23:59:00';

select * from rentals_may;

#3. Create a table rentals_june to store the data from rental table with information for the month of June.

create table rentals_june (
rental_id int(11) unique not null,
rental_date datetime default null,
inventory_id int(11) default null,
customer_id int(11) default null,
return_date datetime default null,
staff_id int(11) default null,
last_update datetime default null,
constraint primary key (rental_id)
);

select * from rentals_june;

#4. Insert values in the table rentals_june using the table rental, filtering values only for the month of June.

insert into rentals_june
select * from rental
WHERE rental_date between '2005-06-01 00:00:00' and '2005-06-30 23:59:59';

select * from rentals_june;

#5. Check the number of rentals for each customer for May.

select rental_date, customer_id, COUNT(*) as rentals from rentals_may
group by customer_id
order by COUNT(*) DESC;

#6. Check the number of rentals for each customer for June.

select rental_date, customer_id, COUNT(*) as rentals from rentals_june
group by customer_id
order by COUNT(*) DESC; 

#7. Create a Python connection with SQL database and retrieve the results of the last two queries 
# (also mentioned below) as dataframes:

	#Check the number of rentals for each customer for May
    
		#A= result is in a python lab
        
	#Check the number of rentals for each customer for June
    
		#A= result is in a python lab
        
	#Hint: You can store the results from the two queries in two separate dataframes.

#8. Write a function that checks if customer borrowed more or less films in the month of June as compared to May.
	#Hint: For this part, you can create a join between the two dataframes created before, 
    #using the merge function available for pandas dataframes. Here is a link to the documentation for the merge function.
    
		#A= result is in a python lab