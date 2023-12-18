-- Query data with SQL

USE sakila;

SELECT * FROM rental;
SELECT * FROM inventory;

-- Testing to look at the different tables
DESCRIBE film;
DESCRIBE category;
DESCRIBE film_category;

-- 1. 
SELECT c.name AS category_name, COUNT(fc.film_id) AS num_films
FROM category AS c
JOIN film_category AS fc ON c.category_id = fc.category_id
GROUP BY c.category_id
HAVING num_films BETWEEN 55 AND 65
ORDER BY num_films;
-- From the findings of this query, it was seen that category with the least number of films in this range 
-- between 55 and 65 was Horror at 56, and the category with highest number of films in this category was Action at 64. 
-- Also, there were nine more categories in between randing from 57 to 63. 

-- 2. 
SELECT f.title AS film_title, COUNT(r.rental_id) AS num_rentals
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
JOIN store AS s ON i.store_id = s.store_id
WHERE s.store_id = 1
GROUP BY f.film_id
ORDER BY num_rentals DESC
LIMIT 5;
-- In store 1, the top 5 films rented out were Love Suicides at 20 rentals, Barbarella Streetcar,
-- Movie Shakespeare, Juggler Hardly, and Madness Attakcs at 18 rentals. 

-- 3. 
SELECT c.first_name, c.last_name, SUM(p.amount) AS total_revenue
FROM customer AS c
JOIN payment AS p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY total_revenue DESC
LIMIT 5;
-- Customer Karl Seal has generated the most total revenue at $221.55. Then Eleanor Hunt at a close second with $216.54.
-- Then customers Clara Shaw, Marion Snyder, and Rhonda Kennedy were the next three customers at around $194-$195. 

-- 4. 
SELECT c.name AS category_name, SUM(p.amount) AS total_revenue
FROM category AS c
JOIN film_category AS fc ON c.category_id = fc.category_id
JOIN inventory AS i ON fc.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
JOIN payment AS p ON r.rental_id = p.rental_id
GROUP BY c.category_id
ORDER BY total_revenue DESC
LIMIT 5;
-- Sports by far has generated the most revenue at $5314.21. 
-- The next four being Sci-Fi, Animation, Drama, and Comedy all ranging from $4300-$4800.



-- 5
SELECT a.first_name, a.last_name, COUNT(r.rental_id) AS appearance_count
FROM actor AS a
JOIN film_actor AS fa ON a.actor_id = fa.actor_id
JOIN film AS f ON fa.film_id = f.film_id
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
JOIN customer AS c ON r.customer_id = c.customer_id
JOIN address AS ad ON c.address_id = ad.address_id
JOIN city ON ad.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
WHERE country.country = 'United States'
GROUP BY a.actor_id
ORDER BY appearance_count DESC
LIMIT 5;
-- The actors that have appeared in the most films rented by customers from United States are Jayne Nolte at 51 appearances, Will Wilsono at 47, 
-- Daryl Crawford at 46 appearances, Walter Torn at 46 appearances, and Angela Witherspoon at 45 appearances.

