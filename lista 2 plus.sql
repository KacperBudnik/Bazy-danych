-- ZAD 11
SELECT inventory_id from inventory
WHERE film_id = 369;
-- Zatem inventory_id \in  1690:1697

SELECT DISTINCT customer_id FROM rental
WHERE inventory_id<=1697 AND inventory_id>=1690;



SELECT first_name, last_name FROM customer
WHERE Customer_id = 285 OR
Customer_id = 172 OR
Customer_id = 341 OR
Customer_id = 145 OR
Customer_id = 74 OR
Customer_id = 287 OR
Customer_id = 54 OR
Customer_id = 264 OR
Customer_id = 397 OR
Customer_id = 57 OR
Customer_id = 248 OR
Customer_id = 279 OR
Customer_id = 505 OR
Customer_id = 481 OR
Customer_id = 276 OR
Customer_id = 221 OR
Customer_id = 134 OR
Customer_id = 194 OR
Customer_id = 267 OR
Customer_id = 530 OR
Customer_id = 41 OR
Customer_id = 303 OR
Customer_id = 290 OR
Customer_id = 235 OR
Customer_id = 446 OR
Customer_id = 197 OR
Customer_id = 597 OR
Customer_id = 298 OR
Customer_id = 21 OR
Customer_id = 403 OR
Customer_id = 81;

-- Zad 12
SELECT first_name, last_name, active FROM customer
WHERE Customer_id = 285 OR
Customer_id = 172 OR
Customer_id = 341 OR
Customer_id = 145 OR
Customer_id = 74 OR
Customer_id = 287 OR
Customer_id = 54 OR
Customer_id = 264 OR
Customer_id = 397 OR
Customer_id = 57 OR
Customer_id = 248 OR
Customer_id = 279 OR
Customer_id = 505 OR
Customer_id = 481 OR
Customer_id = 276 OR
Customer_id = 221 OR
Customer_id = 134 OR
Customer_id = 194 OR
Customer_id = 267 OR
Customer_id = 530 OR
Customer_id = 41 OR
Customer_id = 303 OR
Customer_id = 290 OR
Customer_id = 235 OR
Customer_id = 446 OR
Customer_id = 197 OR
Customer_id = 597 OR
Customer_id = 298 OR
Customer_id = 21 OR
Customer_id = 403 OR
Customer_id = 81;

SELECT 31-SUM(active) as "Nieaktywni" FROM customer
WHERE Customer_id = 285 OR
Customer_id = 172 OR
Customer_id = 341 OR
Customer_id = 145 OR
Customer_id = 74 OR
Customer_id = 287 OR
Customer_id = 54 OR
Customer_id = 264 OR
Customer_id = 397 OR
Customer_id = 57 OR
Customer_id = 248 OR
Customer_id = 279 OR
Customer_id = 505 OR
Customer_id = 481 OR
Customer_id = 276 OR
Customer_id = 221 OR
Customer_id = 134 OR
Customer_id = 194 OR
Customer_id = 267 OR
Customer_id = 530 OR
Customer_id = 41 OR
Customer_id = 303 OR
Customer_id = 290 OR
Customer_id = 235 OR
Customer_id = 446 OR
Customer_id = 197 OR
Customer_id = 597 OR
Customer_id = 298 OR
Customer_id = 21 OR
Customer_id = 403 OR
Customer_id = 81;

-- Zad 13
SELECT Customer_id FROM customer
WHERE Customer_id IN (285,172,341,145,74,287,54,264,397,57,248,279,505,481,276,221,134,194,267,530,41,303,290,235,446,197,597,298,21,403,81)  AND active=0;

-- niewaktywny z numerem 446, więc
-- (285,172,341,145,74,287,54,264,397,57,248,279,505,481,276,221,134,194,267,530,41,303,290,235,197,597,298,21,403,81) | <- bez 446
-- są aktywni

SELECT address_id FROM customer -- Zmienną "phone" znalazłem jedynie w tabeli address, która może być połączona z osobą, jedynie przez address_id
WHERE Customer_id IN (285,172,341,145,74,287,54,264,397,57,248,279,505,481,276,221,134,194,267,530,41,303,290,235,446,197,597,298,21,403,81)  AND active=1;
--(25,45,58,61,78,85,138,149,176,198,201,225,239,252,269,272,281,284,290,292,295,303,308,346,402,408,486,510,536,603)

SELECT phone FROM address
WHERE address_id IN (25,45,58,61,78,85,138,149,176,198,201,225,239,252,269,272,281,284,290,292,295,303,308,346,402,408,486,510,536,603);



-- Zad 14
SELECT actor_id, first_name, last_name FROM actor
WHERE first_name = "ED";
-- jest ich 3 o numerach (3,136,179)
SELECT COUNT(film_id) as f_n, actor_id FROM film_actor
WHERE actor_id IN (3, 136, 179)
GROUP BY actor_id
ORDER BY f_n DESC
LIMIT 1;
-- actor o numerze 136 (ED MANSFIELD) zagrał w 32 filmach


-- ZAD 15
SELECT SUM(amount) as zarobil, staff_id FROM payment
GROUP BY staff_id
ORDER BY zarobil DESC;
-- Więcej zarobił dla firmy drugi pracownik - Jon Stephens

-- Zad 16
SELECT SUM(amount) as zarobil, staff_id FROM payment
WHERE payment_date BETWEEN "2005-07-01" AND "2005-08-31"
GROUP BY staff_id
ORDER BY zarobil DESC;
-- Tak wynik jest podobny, jeśli uznamy, że zarobek liczy się jedynie kiedy wpłynie gotówka (jeśli zostało wypożyczone, a jeszcze nie zapłacone, to nie uwzględniamy tego)


-- Zad 17
SELECT Count(email) from customer
WHERE email LIKE "%@sakilacustomer.org";
-- Jest łacznie 599 danych w tabeli customer i każdy email jest z sakili
SELECT Count(email) as "poza domena" from customer
WHERE email NOT LIKE "%@sakilacustomer.org";


-- ZAD 18
SELECT store_id, COUNT(store_id) FROM customer
WHERE active=1
GROUP BY store_id;

-- ZAD 19
SELECT staff_id as Placowka, COUNT(staff_id) FROM rental -- Bo osoba o nr 1 pracuje tylko w placowce 1 i analogicznie dla 2 
WHERE return_date IS NULL -- Brak danych jest zapisywany jako NULL (brak spacji, pustych miejsc)
GROUP BY staff_id;

-- Zad 20
SELECT customer_id, rental_date FROM rental
WHERE return_date IS NULL -- Brak danych jest zapisywany jako NULL (brak spacji, pustych miejsc)
ORDER BY rental_date -- najwcześniej wypożyczony
LIMIT 1;
-- Jest to 554, zatem
Select email, customer_id, address_id from customer
WHERE customer_id=554;
-- address to 560
SELECT phone FROM address
WHERE address_id =560;

