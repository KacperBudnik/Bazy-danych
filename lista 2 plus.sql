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

-- Zad 3
SELECT Customer_id FROM customer
WHERE (Customer_id = 285 OR
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
Customer_id = 81) AND active=0;

-- niewaktywny z numerem 446, więc
(285,172,341,145,74,287,54,264,397,57,248,279,505,481,276,221,134,194,267,530,41,303,290,235,446,197,597,298,21,403,81)