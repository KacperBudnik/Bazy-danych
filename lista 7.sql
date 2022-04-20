# Zad 1
Select first_name, last_name, email, address, phone from staff left join address using(address_id);

# Zad 2 
Select city, country From city left join country using (country_id);

# Zad 3
Select address, city, country from address left join (city left join country using (country_id)) using(city_id);

# Zad 4
Select first_name, last_name, email, address, phone, city, country 
from staff left join (address left join (city left join country using (country_id)) using(city_id)) using(address_id);

# Zad 5 TBA
Select Staff_id, store_id, Count(rental_id) 
from staff 
        join (rental join inventory using(inventory_id))
        using(Staff_id, store_id)
Group By Staff_id, store_id;

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



