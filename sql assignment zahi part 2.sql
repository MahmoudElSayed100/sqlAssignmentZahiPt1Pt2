--1 cte for films and their rental count
-- WITH rentalCountPerFilim_CTE as(
-- 	SELECT
-- 		seF.title,
-- 		seF.film_id,
-- 		COALESCE(COUNT(seR.rental_id),0) as totalRentals
-- 	FROM public.film as seF
-- 	LEFT JOIN public.inventory as seInv
-- 	ON seF.film_id = seInv.film_id
-- 	LEFT JOIN public.rental as seR
-- 	ON seInv.inventory_id = seR.inventory_id
-- 	GROUP BY 
-- 		seF.title,
-- 		seF.film_id
-- )
-- SELECT 
-- 	seRF.title,
-- 	seRF.film_id
-- FROM rentalCountPerFilim_CTE as seRF
-- WHERE
-- 	totalRentals = 0


--2. names of customers who rented films with a replacement cost greater than 
--20 and cat action or comedy
-- customer -> rental ->inventory->film->filmcat->cat

-- SELECT
-- 	DISTINCT CONCAT(seC.first_name,' ',seC.last_name) AS FullName
-- FROM public.customer as seC
-- INNER JOIN public.rental as seR
-- ON seC.customer_id = seR.customer_id
-- INNER JOIN public.inventory as seI
-- ON seR.inventory_id = seI.inventory_id
-- INNER JOIN public.film as seF
-- ON seI.film_id = seF.film_id
-- INNER JOIN public.film_category as seFC
-- ON seF.film_id = seFC.film_id
-- INNER JOIN public.category as seCat
-- ON seFC.category_id = seCat.category_id
-- WHERE
-- 	seF.replacement_cost > 20
-- 	AND
-- 	(
-- 		seCat.name = 'Action'
-- 		OR 
-- 		seCat.name = 'Comedy'
-- 	)


--3. ACTORS  who didn't appear in a film with rating 'R'
-- actor->film actor->film
-- SELECT
-- 	DISTINCT seA.actor_id
-- FROM public.actor as seA
-- LEFT OUTER JOIN public.film_actor as seFA
-- ON seA.actor_id = seFA.actor_id
-- LEFT OUTER JOIN public.film as seF
-- ON seFA.film_id = seF.film_id
-- WHERE
-- 	seF.rating != 'R'

--4. CUSTOMERS who never rented a film from the horror cat
-- where can i use inner join :)
--customer -> rental->inv->film->filmcat->cat
-- SELECT
-- 	CONCAT(seC.first_name,' ',seC.last_name) as FullName
-- FROM
-- public.customer as seC
-- LEFT OUTER JOIN public.rental as seR
-- ON seC.customer_id = seR.customer_id
-- LEFT OUTER JOIN public.inventory as seIn
-- ON seR.inventory_id = seIn.inventory_id
-- LEFT OUTER JOIN public.film as seF
-- ON seIn.film_id = seF.film_id
-- LEFT OUTER JOIN public.film_category as seFCat
-- ON seF.film_id = seFCat.film_id
-- LEFT OUTER JOIN public.category as seCat
-- ON seFCat.category_id = seCat.category_id
-- WHERE 
-- 	seCat.name = 'Horror'
-- 	AND seR.rental_id IS NULL

--5.names and emails of customers who rented films by a specific actor

SELECT
	DISTINCT
	CONCAT( seC.first_name,' ',seC.last_name) as FullName,
	seC.email
FROM public.customer as seC
INNER JOIN public.rental as seR
ON seC.customer_id = seR.customer_id
INNER JOIN public.inventory as seI
ON seR.inventory_id = seI.inventory_id
INNER JOIN public.film as seF
ON seI.film_id = seF.film_id
INNER JOIN public.film_actor as seFA
ON seF.film_id = seFA.film_id
INNER JOIN public.actor as seA
ON seFA.actor_id = seA.actor_id
WHERE
	seA.first_name = 'Nick' 
	AND
	seA.last_name = 'Wahlberg'










