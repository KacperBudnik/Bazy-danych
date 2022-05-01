# Zad 1
CREATE OR REPLACE TEMPORARY TABLE zad1_1 AS
    (SELECT COUNT(city_id) AS suma,city_id
    FROM `sakila`.`rental` JOIN `sakila`.`customer` USING (customer_id)
    JOIN  `sakila`.`address` USING (address_id) JOIN  `sakila`.`city` USING (city_id)
    GROUP BY city_id
    ORDER BY suma DESC
    Limit 5);

CREATE OR REPLACE TEMPORARY TABLE zad1_2 AS
    (SELECT first_name,last_name,city_id
    FROM `sakila`.`address` JOIN `sakila`.`customer` USING (address_id)
    WHERE  LENGTH(last_name)>5);

Select * From zad1_1 natural join zad1_2;

# Zad 2
CREATE OR REPLACE TEMPORARY TABLE zad2_film_length AS
    (SELECT length from film
    Group By length
    Order By length Desc
    Limit 1,4);

CREATE OR REPLACE TEMPORARY TABLE zad2_film_chosen_one AS
    (SELECT max(length) as length from zad2_film_length
    Union All
    SELECT min(length) as length from zad2_film_length);

CREATE OR REPLACE TEMPORARY TABLE zad2_film AS
    (SELECT film_id, title, length
    from film natural join zad2_film_chosen_one);

Select first_name, last_name
from customer join 
   (rental natural join zad2_film)
   using(customer_id) ;

Select first_name, last_name
from  zad2_film 
    left join inventory using(film_id)
    left join rental using (inventory_id)
    left join customer using(customer_id)
Group by first_name, last_name;

# Zad 3 - nope
Select film_id, store_id, count(*) from inventory left join film using(film_id)
Group by film_id, store_id
Order by Count(*) Desc;

Select film_id, store_id from inventory
WHere film_id=702;
