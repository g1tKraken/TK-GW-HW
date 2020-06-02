
-- Mini HW SQL SUBQUERIES

-- ## Mine the Subqueries

-- In this activity, you will continue to practice subqueries.
-- Work individually or in pairs.
-- You can use the [ERD](http://www.postgresqltutorial.com/postgresql-sample-database/)
-- for help with the queries.

-- ### Instructions

-- * Using subqueries, identify all actors who appear in the film ALTER VICTORY
-- in the `pagila` database.


SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
    SELECT actor_id
    FROM film_actor
    WHERE film_id IN (
        SELECT film_id
        FROM film
        WHERE title = 'ALTER VICTORY'
    )
)

-- * Using subqueries, 
-- display the titles of films that the employee Jon Stephens rented to customers.


SELECT DISTINCT title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM inventory
    WHERE inventory_id IN (
        SELECT inventory_id
        FROM rental
        WHERE staff_id IN (
            SELECT staff_id
            FROM staff
            WHERE first_name = 'Jon' AND last_name = 'Stephens'
            )
        )
    )
ORDER BY title

--- How much profit did Jon earn the store and on what films?
-- first as a VIEW
-- DROP VIEW js_rentals

CREATE VIEW js_rentals AS
SELECT film_id, inventory_id
    FROM inventory
    WHERE inventory_id IN (
        SELECT inventory_id
        FROM rental
        WHERE staff_id IN (
            SELECT staff_id
            FROM staff
            WHERE first_name = 'Jon' AND last_name = 'Stephens'
            )
        )

-- SELECT * FROM js_rentals

SELECT DISTINCT f.title, f.rental_rate, (count(j.inventory_id) * f.rental_rate) AS sales_total, count(j.inventory_id) AS times_rented
FROM film f, js_rentals j, rental r
WHERE f.film_id = j.film_id AND j.inventory_id = r.inventory_id
GROUP BY f.title, f.rental_rate
ORDER BY sales_total, f.title

-- now for some off the books SQL fun....

-- now with sub-FROM... I like it!
CREATE VIEW js_rentals AS
SELECT DISTINCT f.title AS Title_rented,
                f.rating,
                CAST(f.rental_rate AS money) AS rental_cost,
                CAST((count(j.inventory_id) * f.rental_rate) AS money) AS sales_total,
                count(j.inventory_id) AS times_rented
FROM film f, ( SELECT film_id, inventory_id
    FROM inventory
    WHERE inventory_id IN (
        SELECT inventory_id
        FROM rental
        WHERE staff_id IN (
            SELECT staff_id
            FROM staff
            WHERE first_name = 'Jon' AND last_name = 'Stephens'
            )
        ) ) j, rental r
WHERE f.film_id = j.film_id AND j.inventory_id = r.inventory_id
GROUP BY f.rating, f.title, f.rental_rate 
ORDER BY f.rating DESC, sales_total DESC, times_rented, f.title

SELECT * FROM js_rentals

SELECT rating, count(rating) AS times_rented , sum(sales_total)
FROM js_rentals
GROUP BY rating
ORDER BY times_rented DESC