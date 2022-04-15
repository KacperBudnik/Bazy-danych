# Zad 1 grupa 4
SELECT rating, count(rating) FROM film
WHERE special_features like "%Deleted Scenes%"
group by rating
Order by count(rating) DESC
Limit 1;

SELECT  Count(*) FROM customer
WHERE CONCAT(first_name, '.', last_name,'@sakilacustomer.org') = email;

#Zad 2v1 grupa 4
SELECT  Count(*) FROM customer
WHERE CONCAT(first_name, '.', last_name,'@sakilacustomer.org') <> email;

#Zad 2v2 grupa 4 
SELECT  Count(*) FROM customer
WHERE email <> "IMIE.NAZWISKO@sakilacustomer.org";

################################################################;
#Dodatkowe
# Zad 1 czyjeś
SELECT title, length, special_features, description FROM film
WHERE length BETWEEN 60 AND 90 AND Description LIKE "%drama%" AND special_features like "%trailer%";

# Zad 2 czyjeś zagnieżdżone
SELECT Count(*) From (Select actor_id From film_actor
            GROUP BY actor_id Having count(actor_id)>10) AS xyz;

# Zad 2 czyjeś (brak osób)
Select actor_id From film_actor
 GROUP BY actor_id Having count(actor_id)<=10 #brak




