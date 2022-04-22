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
Limit 2 # bo 2 największe są z różnych placowek;


# Zad 7.12
Select address_id 
From address 
    left join customer using(address_id)
    left join staff using(address_id)
    left join store using(address_id)
Where customer.first_name is NULL and staff.first_name is NULL and store.store_id is NULL
# nie ma takich
