# Zad 1
Select first_name, last_name, email, address, phone from staff left join address using(address_id);

# Zad 2 
Select city, country From city left join country using (country_id);

# Zad 3
Select address, city, country from address left join (city left join country using (country_id)) using(city_id);

# Zad 4
Select first_name, last_name, email, address, phone, city, country 
from staff left join (address left join (city left join country using (country_id)) using(city_id)) using(address_id);

# Zad 5
SELECT rental.staff_id, inventory.store_id, COUNT(*)
FROM rental JOIN inventory USING(inventory_id)
GROUP BY staff_id, store_id;

# Zad 6
Select first_name, last_name, GROUP_CONCAT(distinct title ORDER BY title SEPARATOR ", ") from actor left join (film left join film_actor using(film_id)) using(actor_id)
GROUP BY first_name, last_name ;

# Zad 7
Select first_name, last_name,GROUP_CONCAT(distinct title ORDER BY title SEPARATOR ", ") from actor left join (film left join film_actor using(film_id)) using(actor_id)
WHERE title Like "%EGG%"
Group By first_name, last_name;

# Zad 8
Select customer.first_name, customer.last_name, customer.email, address.address, address.phone, city.city, country.country_id, staff.first_name, staff.last_name
FROM (customer 
        left JOIN (address 
            left JOIN (city 
                left JOIN country using(country_id))
            using(city_id))
        using(address_id))
        left JOIN staff using(store_id)
WHERE (customer.first_name, customer.last_name)=("ALAN","KAHN");

# Zad 9
Select customer.first_name, customer.last_name, title, rental_date, return_date, amount, payment_date
from  customer 
        left JOIN (rental 
            left JOIN (inventory
                left JOIN film using(Film_id ))
            using(inventory_id))
        using(customer_id)
        left Join payment using(rental_id)
WHERE (customer.first_name, customer.last_name)=("ALAN","KAHN");


######################################### Bonusy 7.10-7.12;

#Zad 7.10
Select customer.first_name, customer.last_name, actor_id, count(*), actor.first_name, actor.last_name
From customer 
        left join rental Using(customer_id)
        left join inventory using(inventory_id)
        left join film_actor using(film_id)
        left join actor using(actor_id)
Where (customer.first_name, customer.last_name)=(SELECT first_name, last_name 
                                                        From customer left join payment Using(customer_id)
                                                        Group By first_name, last_name
                                                        Order By count(*) desc
                                                        Limit 1)
Group By customer.first_name, customer.last_name, actor_id
Order By count(*) desc
Limit 1;

# Zad 7.11
Select store_id as placowka, city, sum(amount)
From city 
    left join address using(city_id)
    left join customer using(address_id)
    left join payment using(customer_id)
Group By city, store_id
Order By sum(amount) desc
Limit 2 # bo 2 najwi??ksze s?? z r????nych placowek;


# Zad 7.12
Select address_id 
From address 
    left join customer using(address_id)
    left join staff using(address_id)
    left join store using(address_id)
Where customer.first_name is NULL and staff.first_name is NULL and store.store_id is NULL
# nie ma takich


