use sakila;

select first_name, last_name
from actor;

alter table actor 
	add ACTOR_NAME varchar(50) not null;
    
update actor
set actor_name =
	UPPER(concat(actor.first_name," ", actor.last_name));
    
select actor_name
from actor;

select first_name, last_name, actor_id
from actor 
where first_name = 'Joe';

select first_name, last_name
from actor 
where last_name LIKE '%GEN%';

select first_name, last_name
from actor
where last_name LIKE '%LI%'
ORDER BY last_name, first_name;

select country_id, country
from country
where country in ('Afghanistan', 'Bangladesh', 'China');

alter table actor 
	add middle_name varchar(50) not null AFTER first_name;
    
alter table actor 
	modify column middle_name blob;

alter table actor
	drop middle_name;
    
select last_name, count(last_name)
from actor
group by last_name;

select last_name, count(last_name)
from actor
group by last_name
having count(last_name) > 1;

update actor
set first_name = 'HARPO'
where first_name = 'GROUCHO' and last_name = 'WILLIAMS';

select first_name, last_name 
from actor
where last_name = 'Williams';
--
-- alter table actor
	-- add id integer(11) not null auto_increment
    -- primary key (id);
--
select * from actor where last_name = 'williams';

update actor
set first_name = CASE 
	when first_name = 'HARPO' AND last_name = 'Williams' then 'GROUCHO'
    when actor_id = 172 then 'MUCHO GROUCHO'
    else first_name
    end;
    
 use sakila;
 
SHOW CREATE TABLE address;

select s.first_name, s.last_name, a.address
from staff s
join address a
on (s.address_id = a.address_id);

select sum(p.amount), s.first_name, s.last_name
from payment p 
join staff s
on (p.staff_id = s.staff_id)
where payment_date between '2005-08-01 00:00:00' and '2005-09-01 00:00:00'
group by s.first_name;

select f.title, count(a.actor_id)
from film f
inner join film_actor a
on (f.film_id = a.film_id)
group by f.title; 

select count(i.film_id)
from inventory i
join film f
on (f.film_id = i.film_id)
where f.title = 'Hunchback Impossible';

select sum(p.amount), c.first_name, c.last_name
from payment p
join customer c
on (c.customer_id = p.customer_id)
group by c.last_name;

select f.title
from film f
join language l
on (l.language_id = f.language_id)
where f.title LIKE 'K%' OR f.title like'Q%'
and l.name = 'English';


select title
from film
where language_id in(
	select language_id
	from language
	where name = 'English')
    AND title LIKE 'K%' OR title LIKE 'Q%';



select first_name, last_name
from actor
where actor_id in(
	select actor_id
	from film_actor
	where film_id in(
		select film_id
		from film
		where title = 'Alone Trip'));



select title from film where title like 'Q%';
select count(actor_id)
from film
where title = 'Alone Trip';

select cus.first_name, cus.last_name, cus.email
from customer cus
	join address a 
		on (cus.address_id = a.address_id)
	join city c
		on (a.city_id = c.city_id)
	join country
		on (c.country_id = country.country_id)
	where country.country = 'Canada';


select title
from film
where film_id in(
	select film_id
	from film_category
	where category_id in(    
		select category_id 
		from category
		where name = 'Family'));

 select f.title, count(r.inventory_id)
 from film f
	join inventory i
		on (f.film_id = i.film_id)
	join rental r
		on (i.inventory_id = r.inventory_id)
group by f.title
ORDER BY count(r.inventory_id) DESC;

select str.store_id, sum(p.amount)
from payment p
	join staff s
		on (p.staff_id = s.staff_id)
	join store str
		on (str.store_id = s.store_id)
	group by str.store_id;
        
select str.store_id, city.city, country.country
from store str
	join address ad
		on (str.address_id = ad.address_id)
	join city 
		on (city.city_id = ad.city_id)
	join country
		on (city.country_id = country.country_id)
group by str.store_id

select c.name, sum(p.amount)
from payment p
	join rental r
		on (p.rental_id = r.rental_id)
	join inventory i
		on (i.inventory_id = r.inventory_id)
	join film f
		on (f.film_id = i.film_id)
	join film_category fc
		on (fc.film_id = f.film_id)
	join category c
		on (c.category_id = fc.category_id)
	group by c.name
	ORDER BY sum(p.amount) DESC
    LIMIT 5;
 
CREATE VIEW top5_genre as
select c.name, sum(p.amount)
from payment p
	join rental r
		on (p.rental_id = r.rental_id)
	join inventory i
		on (i.inventory_id = r.inventory_id)
	join film f
		on (f.film_id = i.film_id)
	join film_category fc
		on (fc.film_id = f.film_id)
	join category c
		on (c.category_id = fc.category_id)
	group by c.name
	ORDER BY sum(p.amount) DESC
    LIMIT 5;
 
select * from top5_genre;

drop view if exists top5_genre;