-- Zad 4
SELECT title FROM film ORDER BY title desc LIMIT 3,1;

-- Zad 5v1
SELECT COUNT(DISTINCT Title) AS "Ze słowem 'SUMO'" FROM film
WHERE
description Like "% SUMO %" OR
description Like "SUMO %" OR
description Like "% SUMO";

SELECT COUNT(DISTINCT Title) FROM film
WHERE
(description Like "% SUMO %" OR
description Like "SUMO %" OR
description Like "% SUMO")
AND
(description NOT Like "%SUMO WRESTLER%");
SELECT COUNT(DISTINCT Title) AS "Ze słowem 'SUMO'" FROM film
WHERE description Like "%SUMO WRESTLER%";

-- Zad 6

SELECT COUNT(DISTINCT Title) AS "SHARK_OR_SUMO" FROM film
WHERE 
description Like "%SUMO%" OR
description Like "%SHARK%";

-- Zad 7
SELECT COUNT(DISTINCT Title) AS pies FROM film
WHERE
description Like "%DOG%";

SELECT  COUNT(DISTINCT Title) AS  Kot FROM film
WHERE
description Like "%CAT%";

SELECT  COUNT(DISTINCT Title) AS  KOT_i_PIES FROM film
WHERE
description Like "%CAT%" AND
description Like "%DOG%";

-- ZAD 8
SELECT  DISTINCT Title, rating FROM film
WHERE
(description Like "%CAT%" OR
description Like "%DOG%")
AND
(rating="G" OR rating="PG")
ORDER BY rating, Title;

-- ZAD 9
SELECT  film_id, Title, rating, length, special_features FROM film
WHERE
(description Like "%CAT%" OR
description Like "%DOG%")
AND
(rating="G" OR rating="PG")
AND
(special_features NOT LIKE "%Trailers%")
ORDER BY length LIMIT 1;

-- ZAD 10

-- wiemy, że to GOODFELLAS SALUTE o id 369
SELECT store_id, COUNT(store_id) from inventory
WHERE film_id = 369
GROUP BY store_id;

