-- ZAD 1
SELECT GROUP_CONCAT(last_name ORDER BY last_name SEPARATOR ', ') as `Aktorzy o dwuliterowych imionach` FROM actor
WHERE first_name LIKE "__";

-- ZAD 2
SELECT title, SUBSTRING(description,3) from film -- Po A jest zawsze spacja
WHERE description NOT LIKE 'BORING'
ORDER BY description; -- To samo jeśli sortujemy po SUBSTRING(description,2)

SELECT title, TRIM(LEADING "A " FROM description) from film
WHERE description NOT LIKE 'BORING'
ORDER BY description;

-- ZAD 3
/*SELECT customer_id, SUM(IF(return_date>"2005-08-31 23:59:59",0.5,0)) AS `Dopłata` FROM rental 
WHERE rental_date BETWEEN "2005-07-01 00:00:00" AND "2005-08-31 23:59:59"
GROUP BY customer_id;*/

SELECT customer_id, CONCAT(SUM(0.5),"$") AS `Dopłata` FROM rental 
WHERE (rental_date BETWEEN "2005-07-01 00:00:00" AND "2005-08-31 23:59:59") AND return_date > "2005-08-31 23:59:59"
GROUP BY customer_id;


/*SELECT customer_id, SUM(0.5) AS `Dopłata` FROM rental 
WHERE rental_date BETWEEN "2005-07-01 00:00:00" AND "2005-08-31 23:59:59"
GROUP BY customer_id;

SELECT customer_id, rental_date,return_date AS `Dopłata` FROM rental 
WHERE (rental_date BETWEEN "2005-07-01 00:00:00" AND "2005-08-31 23:59:59") AND return_date > "2005-08-31 23:59:59"
#GROUP BY customer_id;*/

-- Zad 4
SELECT city_id, GROUP_CONCAT(distinct district ORDER BY district SEPARATOR " oraz ") as `Dystrykt` FROM address
WHERE district <> ""
GROUP BY city_id HAVING count(distinct district)>1
ORDER BY city_id;

-- ZAD 5
SELECT amount AS `kwota`, staff_id AS `pracownik`, SUM(amount) AS `Laczny zarobek` From payment
WHERE amount>0
GROUP BY amount, staff_id
ORDER BY SUM(amount) DESC;


-- ZAD 6
SELECT rental_id, 
    CONCAT(
        FLOOR((return_date-rental_date)/60/60/24), " dni oraz ", 
        FLOOR((return_date-rental_date)/60/60)%24, "h ", 
        FLOOR((return_date-rental_date)/60)%24%60, "m ", 
        FLOOR((return_date-rental_date))%24%60%60, "s ")
        AS `Czas wypożycznia`
FROM rental
WHERE return_date IS NOT NULL
ORDER BY return_date-rental_date
LIMIT 1;

SELECT rental_id, 
    CONCAT(
        FLOOR((return_date-rental_date)/60/60/24), " dni oraz ", 
        FLOOR((return_date-rental_date)/60/60)%24, "h ", 
        FLOOR((return_date-rental_date)/60)%24%60, "m ", 
        FLOOR((return_date-rental_date))%24%60%60, "s ") 
        AS `Czas wypożycznia`
FROM rental
WHERE return_date IS NOT NULL
ORDER BY return_date-rental_date DESC
LIMIT 1;

-- Zad 7
Select customer_id AS `Najdłużej przetrzymywane (średnio)` FROM rental
GROUP BY customer_id
ORDER BY AVG(return_date-rental_date) DESC
LIMIT 1;

Select customer_id AS `Najdłużej wypożyczone` FROM rental
GROUP BY customer_id
ORDER BY SUM(return_date-rental_date) DESC
LIMIT 1;

