-- -- using cte, find total number of films rented for each rating in the year 2005
-- -- then list ratings that had more than 50 rentals

-- WITH total_films_by_rating_year2005_CTE as(
-- 	SELECT 
-- 		rating,
-- 		COUNT(film_id) as film_count
-- 	FROM film
-- 	WHERE release_year = 2005
-- 	GROUP BY 
-- 		rating,
-- 		release_year
-- )

-- SELECT 
-- 	rating,
-- 	film_count
-- FROM total_films_by_rating_year2005_CTE
-- WHERE film_count > 50

-- 2. find categories of films that have avg rentaul duration > 5,
-- only consider rating pg or g

-- SELECT 
-- 	AVG(sef.rental_duration) as average_rental_duration,
-- 	seCat.name
-- FROM film as seF
-- INNER JOIN film_category as seC
-- ON seF.film_id = seC.film_id
-- INNER JOIN category as seCat
-- ON seC.category_id = seCat.category_id
-- WHERE (seF.rating = 'PG' or seF.rating = 'G') 
-- GROUP BY 
-- 	seCat.name
-- HAVING 
-- 	AVG(sef.rental_duration) > 5

-- 3. total rental amount collected from each customer
-- where amount > 100 in total

-- SELECT
-- 	CONCAT(seCustomer.first_name,' ',seCustomer.last_name) as FullName,
-- 	SUM(sePayment.amount) AS total_rental_amount
-- FROM public.payment as sePayment
-- INNER JOIN public.customer as seCustomer
-- ON sePayment.customer_id = seCustomer.customer_id
-- WHERE rental_id IS NOT NULL
-- GROUP BY 
-- 	FullName
-- HAVING
-- 	SUM(sePayment.amount) > 100

-- 4.temp talbe: names and email addresses of customers who 
--have rented more than 10 films

-- CREATE TEMP TABLE c_rented_more_than_10_films (
--     customer_id INT,
--     first_name VARCHAR(50),
--     last_name VARCHAR(50),
--     email VARCHAR(100)
-- );

-- INSERT INTO c_rented_more_than_10_films (customer_id, first_name, last_name, email)
-- SELECT
--     seC.customer_id,
--     seC.first_name,
--     seC.last_name,
--     seC.email
-- FROM customer as seC
-- INNER JOIN rental as seR
-- ON seC.customer_id = seR.customer_id
-- GROUP BY 
--     seC.customer_id,
--     seC.first_name,
--     seC.last_name,
--     seC.email
-- HAVING 
--     COUNT(seR.rental_id) > 10;

-- --5. customers who have emails ending with @gmail.com
-- SELECT
-- 	CONCAT(first_name,' ',last_name) as FullName,
-- 	email
-- FROM c_rented_more_than_10_films as seCs
-- WHERE email ILIKE ('%@gmail.com')

CREATE TEMPORARY TABLE t1 AS
WITH RENTALS_PER_CATEGORY_CTE AS (
    SELECT 
        seCat.name AS categoryName,
        COALESCE(COUNT(seR.rental_id), 0) AS totalRentals 
    FROM public.category as seCat
    LEFT OUTER JOIN public.film_category as seFCat
    ON seCat.category_id = seFCat.category_id
    LEFT OUTER JOIN public.inventory as seInv
    ON seFCat.film_id = seInv.film_id
    LEFT OUTER JOIN public.rental as seR
    ON seInv.inventory_id = seR.inventory_id
    GROUP BY seCat.name
)


--6. cte for total number of films rented for each cat
-- WITH RENTALS_PER_CATEGORY_CTE AS (
--     SELECT 
--         seCat.name AS categoryName,
--         COALESCE(COUNT(seR.rental_id), 0) AS totalRentals 
--     FROM public.category as seCat
--     LEFT OUTER JOIN public.film_category as seFCat
--     ON seCat.category_id = seFCat.category_id
--     LEFT OUTER JOIN public.inventory as seInv
--     ON seFCat.film_id = seInv.film_id
--     LEFT OUTER JOIN public.rental as seR
--     ON seInv.inventory_id = seR.inventory_id
--     GROUP BY seCat.name
-- )

--temp table for this cte
-- CREATE TEMPORARY TABLE t1 AS
-- WITH RENTALS_PER_CATEGORY_CTE AS (
--     SELECT 
--         seCat.name AS categoryName,
--         COALESCE(COUNT(seR.rental_id), 0) AS totalRentals 
--     FROM public.category as seCat
--     LEFT OUTER JOIN public.film_category as seFCat
--     ON seCat.category_id = seFCat.category_id
--     LEFT OUTER JOIN public.inventory as seInv
--     ON seFCat.film_id = seInv.film_id
--     LEFT OUTER JOIN public.rental as seR
--     ON seInv.inventory_id = seR.inventory_id
--     GROUP BY seCat.name
-- )

-- --5 top categories with highest number of rentals, desc

-- SELECT 
-- 	categoryName,
-- 	totalRentals
-- FROM t1
-- ORDER BY totalRentals DESC
-- LIMIT 5;








