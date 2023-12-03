use sakila;
Select * from actor;
Select * from address;
Select * from category;
Select * from city;
Select * from country;
Select * from customer;
Select * from film;
Select * from film_actor;
Select * from film_category;
Select * from film_text;
Select * from inventory;
Select * from language;
Select * from payment;
Select * from rental;
Select * from staff;
Select * from store;

-- Task-1- Display the full names of actors availbale in the database.
Select * from actor;

-- Task-2.i- Display the number of times each first name appears in the database.
SELECT first_name, COUNT(*) AS Count
FROM actor
GROUP BY first_name;

-- Task-2.ii- display the count of actors with unique first name in the data base. 
-- Display the first name of all these actors.
SELECT first_name, COUNT(*) AS Count
FROM actor
GROUP BY first_name
HAVING COUNT(*) = 1;

-- Task-3.i- Display the number of times each last name has appeared.
Select last_name, COUNT(*) AS Count
FROM actor
Group By last_name;

-- Task-3.ii- Display all unique last names in the database.
SELECT last_name, COUNT(*) AS Count
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;

-- Task-4.i- Display the list of records for the movies with the rating "R".
SELECT film_id, title, rating
FROM film
WHERE rating = 'R';

-- Task-4.ii- Display the list of records that are not rated "R".
Select film_id, title, rating
From film
where NOT rating = "R";

-- Task-4.iii- Display the list of records for the movies that are suitable for
-- audience below 13 years of age.
Select film_id, title, rating
From film
where rating = "G";

-- Task-5.i- Display the list of records for the movies where replacement cost ids upto $11.
Select film_id, title, replacement_cost
From film
where replacement_cost<=11;

-- Task-5.ii- Display the list of records for the movies where replacement cost ids 
-- upto $11 and $20.
Select film_id, title, replacement_cost
From film
where replacement_cost between 11 and 20;

-- Task-5.iii- Display the list of the records for all the movies in descending 
-- order of their replacement costs.
Select film_id, title, replacement_cost
from film
order by replacement_cost desc; 

-- Task-6- Display the names of top 3 movies with the greatest number of actors.
SELECT film.title, COUNT(actor.actor_id) AS actor_count
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
GROUP BY film.film_id
ORDER BY actor_count DESC
LIMIT 3;

-- Task-7
Select title
from film
where title like 'K%' or title like 'Q%';

-- Task-8
SELECT actor.actor_id, actor.first_name, actor.last_name
FROM actor 
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film  ON film_actor.film_id = film.film_id
WHERE film.title = 'Agent Truman';

-- Task-9 
Select film.title
from film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
where category.name = 'Family';

-- Task-10.i 
SELECT film.rating, MAX(rental_rate) AS max_rental_rate, MIN(rental_rate) AS min_rental_rate, AVG(rental_rate) AS avg_rental_rate
FROM film
GROUP BY film.rating
ORDER BY avg_rental_rate DESC;

-- Task-10.ii
SELECT film.film_id, title, COUNT(rental_id) AS rental_count
FROM rental
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
GROUP BY film.film_id, title
ORDER BY rental_count DESC;

-- Task-11
SELECT category.name AS category_name, AVG(film.replacement_cost - film.rental_rate) AS cost_rate_difference
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category_name
HAVING AVG(film.replacement_cost - film.rental_rate) > 15;

-- Task-12
SELECT category.name AS category_name, COUNT(film.film_id) AS movie_count
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id = film.film_id
GROUP BY category_name
HAVING movie_count > 70;

-- Task-13 Retrieve a list of all the customers in the database, including their names and contact information.
Select customer_id, first_name, last_name, email
from customer;

-- Task-14 Show the 10 most active customers based on the number of rentals. Include their names and the number of 
-- rentals they've made.
SELECT customer.customer_id, customer.first_name,customer.last_name, COUNT(rental.rental_id) AS number_of_rentals
FROM customer 
INNER JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id
ORDER BY number_of_rentals DESC
LIMIT 10;

-- Task-15 Find the total number of films in each category. Display the category name and the number of films in that category. 
SELECT category.name AS category_name, COUNT(film_category.film_id) AS number_of_films
FROM category
LEFT JOIN film_category ON category.category_id = film_category.category_id
GROUP BY category_name;
