
--1. 	Display snum,sname,city and comm of all salespeople.
	Select snum, sname, city, comm
	from salespeople;
--2. 	Display all snum without duplicates from all orders.
	Select distinct snum 
	from orders;
--3. 	Display names and commissions of all salespeople in london.
	Select sname,comm
	from salespeople
	where city = ‘London’;
---4. 	All customers with rating of 100.
	Select cname 
	from cust
	where rating = 100;
---5. 	Produce orderno, amount and date form all rows in the order table.
	Select ordno, amt, odate
	from orders;
---6. 	All customers in San Jose, who have rating more than 200.
	Select cname
	from cust
	where rating > 200;
---7. 	All customers who were either located in San Jose or had a rating above 200.
	Select cname
	from cust
	where city = ‘San Jose’ or
	           rating > 200;
---8. 	All orders for more than $1000.
	Select * 
	from orders
	where amt > 1000;
---9. 	Names and citires of all salespeople in london with commission above 0.10.
	Select sname, city
	from salepeople
	where comm > 0.10 and
	           city = ‘London’;
---10. 	All customers excluding those with rating <= 100 unless they are located in Rome.
	Select cname
	from cust
	where rating <= 100 or
	           city = ‘Rome’;
	
---11. 	All salespeople either in Barcelona or in london.
	Select sname, city
	from salespeople
	where city in (‘Barcelona’,’London’);
--12. 	All salespeople with commission between 0.10 and 0.12. (Boundary values should be excluded)
	Select sname, comm
	from salespeople
	where comm > 0.10 and comm < 0.12;
---13. 	All customers with NULL values in city column.
	Select cname
	from cust
	where city is null;
--14. 	All orders taken on Oct 3Rd   and Oct 4th  1994.
	Select *
	from orders 
	where odate in (‘03-OCT-94’,’04-OCT-94’);
--15. 	All customers serviced by peel or Motika.
	Select cname
	from cust, orders
	where orders.cnum = cust.cnum and 
	            orders.snum in ( select snum 
	     from salespeople
	             		          where sname in 'Peel','Motika'));
--16. 	All customers whose names begin with a letter from A to B.
	Select cname
	from cust
	where cname like ‘A%’ or
	            cname like ‘B%’;
---17. 	All orders except those with 0 or NULL value in amt field.
	Select onum
	from orders
	where amt != 0 or
	amt is not null;
---18. 	Count the number of salespeople currently listing orders in the order table.
	Select count(distinct snum)
	from orders;
---19. 	Largest order taken by each salesperson, datewise.
	Select odate, snum, max(amt)
	from orders
	group by odate, snum
	order by odate,snum;
	
	
	
---20. 	Largest order taken by each salesperson with order value more than $3000.
	Select odate, snum, max(amt)
	from orders
	where amt > 3000
	group by odate, snum
	order by odate,snum;
---21. 	Which day had the hightest total amount ordered.
	Select odate, amt, snum, cnum
	from orders
	where amt = (select max(amt) 
	from orders)
--22. 	Count all orders for Oct 3rd.
	Select count(*)
	from orders
	where odate = ‘03-OCT-94’;
---23. 	Count the number of different non NULL city values in customers table.
	Select count(distinct city)
	from cust;
---24. 	Select each customer’s smallest order.
	Select cnum, min(amt)
	from orders
	group by cnum;
--25. 	First customer in alphabetical order whose name begins with G.
	Select min(cname)
	from cust
	where cname like ‘G%’;
---26. 	Get the output like “ For dd/mm/yy there are ___ orders.
	Select 'For ' || to_char(odate,'dd/mm/yy') || ' there are '|| 
	count(*) || ' Orders'
	from orders
	group by odate;
---27. 	Assume that each salesperson has a 12% commission. Produce order no., salesperson no., and amount of salesperson’s commission for that order.
	Select onum, snum, amt, amt * 0.12
	from orders
	order by snum;
---28. 	Find highest rating in each city. Put the output in this form. For the city (city), the highest rating is : (rating).
	Select 'For the city (' || city || '), the highest rating is : (' || 
	max(rating) || ')'
	from cust
	group by city;
	
	
---29. 	Display the totals of orders for each day and place the results in descending order.
	Select odate, count(onum)
	from orders
	group by odate
	order by count(onum);
---30. 	All combinations of salespeople and customers who shared a city. (ie same city).
	Select sname, cname
	from salespeople, cust
	where salespeople.city = cust.city;
--31. 	Name of all customers matched with the salespeople serving them.
	Select cname, sname
	from cust, salespeople
	where cust.snum = salespeople.snum;
--32. 	List each order number followed by the name of the customer who made the order.
	Select onum, cname
	from orders, cust
	where orders.cnum = cust.cnum;
--33. 	Names of salesperson and customer for each order after the order number.
	Select onum, sname, cname
	from orders, cust, salespeople
	where orders.cnum = cust.cnum and
	           orders.snum = salespeople.snum;
--34. 	Produce all customer serviced by salespeople with a commission above 12%.
	Select cname, sname, comm
	from cust, salespeople
	where comm > 0.12 and
	           cust.snum = salespeople.snum;
---35. 	Calculate the amount of the salesperson’s commission on each order with a rating above 100.
	Select sname, amt * comm
	from orders, cust, salespeople
	where rating > 100 and
	          salespeople.snum = cust.snum and
	          salespeople.snum = orders.snum and
	          cust.cnum = orders.cnum
--36. 	Find all pairs of customers having the same rating.
	Select a.cname, b.cname,a.rating
	from cust a, cust b
	where a.rating = b.rating and
	          a.cnum != b.cnum
--37. 	Find all pairs of customers having the same rating, each pair coming once only.
	Select a.cname, b.cname,a.rating
	from cust a, cust b
	where a.rating = b.rating and
	          a.cnum != b.cnum and
	  	                a.cnum < b.cnum;
--38. 	Policy is to assign three salesperson to each customers. Display all such combinations.
	Select cname, sname
	from salespeople, cust
	where sname in  ( select sname 
	     from salespeople
	                                         where rownum <= 3)
	order by cname;
--39. 	Display all customers located in cities where salesman serres has customer.
	Select cname
	from cust
	where city = ( select city 
		      		     from cust, salespeople
	           where cust.snum = salespeople.snum and                  sname = 'Serres');
	
	Select cname 
	from cust
	where city in ( select city
	            		      from cust, orders
	                                    where cust.cnum = orders.cnum and
	                                    orders.snum in ( select snum 
	   from salespeople
	                                                              where sname = 'Serres'));
---40. 	Find all pairs of customers served by single salesperson.
	Select cname from cust
	 where snum in (select snum from cust
	                group by snum
	                having count(snum) > 1);
	
	Select distinct a.cname
	from cust a ,cust b
	where a.snum = b.snum and a.rowid != b.rowid;
	
	
	
	
	
	
---41. 	Produce all pairs of salespeople which are living in the same city. Exclude combinations of salespeople with themselves as well as duplicates with the order reversed.
	Select a.sname, b.sname
	from salespeople a, salespeople b
	where a.snum > b.snum and
	      a.city = b.city;
---42. 	Produce all pairs of orders by given customer, names that customers and eliminates duplicates.
	Select c.cname, a.onum, b.onum
	from orders a, orders b, cust c
	where a.cnum = b.cnum and 
	          a.onum > b.onum and
	                      c.cnum = a.cnum;
---43. 	Produce names and cities of all customers with the same rating as Hoffman.
	Select cname, city
	from cust
	where rating = (select rating
	            		        from cust
	              where cname = 'Hoffman')
	and cname != 'Hoffman';
---44. 	Extract all the orders of Motika.
	Select Onum
	from orders
	where snum = ( select snum
	   from salespeople
	   where sname = ‘Motika’);
---45. 	All orders credited to the same salesperson who services Hoffman.
	Select onum, sname, cname, amt
	from orders a, salespeople b, cust c
	where a.snum = b.snum and
	          a.cnum = c.cnum and
	          a.snum = ( select snum
	                            from orders
	                                        where cnum = ( select cnum
	                                                                  from cust
	                                                                  where cname = 'Hoffman'));
---46. 	All orders that are greater than the average for Oct 4.
	Select * 
	from orders
	where amt > ( select avg(amt) 
	                        from orders
	                                    where odate = '03-OCT-94');
	
---47. 	Find average commission of salespeople in london.
	Select avg(comm)
	from salespeople
	where city = ‘London’;
---48. 	Find all orders attributed to salespeople servicing customers in london.
	Select snum, cnum 
	from orders
	where cnum in (select cnum 
	  from cust
	                          where city = 'London');
---49. 	Extract commissions of all salespeople servicing customers in London.
	Select comm 
	from salespeople
	where snum in (select snum
	                          from cust
	                          where city = ‘London’);
--50. 	Find all customers whose cnum is 1000 above the snum of serres.
	Select cnum, cname from cust
	where cnum > ( select snum+1000 
	                          from salespeople
	                          where sname = 'Serres');
-- 51. Count the customers with rating above San Jose’s average.
SELECT COUNT(*)
FROM customers
WHERE rating > (SELECT AVG(rating) FROM customers WHERE city = 'San Jose');

-- 52. Obtain all orders for the customer named Cisnerous. (Assume you don’t know his customer no. (cnum)).
SELECT * 
FROM orders
WHERE cnum = (SELECT cnum FROM customers WHERE cname = 'Cisnerous');

-- 53. Produce the names and rating of all customers who have above average orders.
SELECT cname, rating
FROM customers
WHERE cnum IN (
  SELECT cnum
  FROM orders
  GROUP BY cnum
  HAVING AVG(amount) > (SELECT AVG(amount) FROM orders)
);

-- 54. Find total amount in orders for each salesperson for whom this total is greater than the amount of the largest order in the table.
SELECT snum, SUM(amount) AS total_amount
FROM orders
GROUP BY snum
HAVING SUM(amount) > (SELECT MAX(amount) FROM orders);

-- 55. Find all customers with order on 3rd Oct.
SELECT DISTINCT cnum
FROM orders
WHERE order_date = '2025-10-03';

-- 56. Find names and numbers of all salesperson who have more than one customer.
SELECT snum, COUNT(DISTINCT cnum)
FROM customers
GROUP BY snum
HAVING COUNT(DISTINCT cnum) > 1;

-- 57. Check if the correct salesperson was credited with each sale.
SELECT order_id, snum
FROM orders
WHERE snum NOT IN (SELECT snum FROM customers WHERE cnum = orders.cnum);

-- 58. Find all orders with above average amounts for their customers.
SELECT * 
FROM orders
WHERE amount > (SELECT AVG(amount) FROM orders WHERE cnum = orders.cnum);

-- 59. Find the sums of the amounts from order table grouped by date, eliminating all those dates where the sum was not at least 2000 above the maximum amount.
SELECT order_date, SUM(amount) AS total_amount
FROM orders
GROUP BY order_date
HAVING SUM(amount) >= (SELECT MAX(amount) FROM orders) + 2000;

-- 60. Find names and numbers of all customers with ratings equal to the maximum for their city.
SELECT cname, cnum
FROM customers
WHERE rating = (SELECT MAX(rating) FROM customers WHERE city = customers.city);

-- 61. Find all salespeople who have customers in their cities who they don’t service.
-- Using Join
SELECT DISTINCT s.snum
FROM salespeople s
JOIN customers c ON s.city = c.city
LEFT JOIN orders o ON o.snum = s.snum AND o.cnum = c.cnum
WHERE o.snum IS NULL;

-- Using Correlated Subquery
SELECT DISTINCT s.snum
FROM salespeople s
WHERE EXISTS (
  SELECT 1
  FROM customers c
  WHERE c.city = s.city
  AND c.cnum NOT IN (SELECT cnum FROM orders WHERE snum = s.snum)
);

-- 62. Extract cnum, cname and city from customer table if and only if one or more of the customers in the table are located in San Jose.
SELECT cnum, cname, city
FROM customers
WHERE city = 'San Jose';

-- 63. Find salespeople no. who have multiple customers.
SELECT snum
FROM customers
GROUP BY snum
HAVING COUNT(DISTINCT cnum) > 1;

-- 64. Find salespeople number, name and city who have multiple customers.
SELECT snum, sname, city
FROM salespeople
WHERE snum IN (
  SELECT snum
  FROM customers
  GROUP BY snum
  HAVING COUNT(DISTINCT cnum) > 1
);

-- 65. Find salespeople who serve only one customer.
SELECT snum
FROM customers
GROUP BY snum
HAVING COUNT(DISTINCT cnum) = 1;

-- 66. Extract rows of all salespeople with more than one current order.
SELECT snum
FROM orders
GROUP BY snum
HAVING COUNT(order_id) > 1;

-- 67. Find all salespeople who have customers with a rating of 300. (use EXISTS)
SELECT DISTINCT snum
FROM salespeople s
WHERE EXISTS (
  SELECT 1
  FROM customers c
  WHERE c.rating = 300 AND c.snum = s.snum
);

-- 68. Find all salespeople who have customers with a rating of 300. (use Join)
SELECT DISTINCT s.snum
FROM salespeople s
JOIN customers c ON s.snum = c.snum
WHERE c.rating = 300;

-- 69. Select all salespeople with customers located in their cities who are not assigned to them. (use EXISTS)
SELECT DISTINCT snum
FROM salespeople s
WHERE EXISTS (
  SELECT 1
  FROM customers c
  WHERE c.city = s.city
  AND c.snum <> s.snum
);

-- 70. Extract from customers table every customer assigned a salesperson who currently has at least one other customer (besides the customer being selected) with orders in the order table.
SELECT cnum, cname, city
FROM customers
WHERE snum IN (
  SELECT snum
  FROM customers c1
  WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.snum = c1.snum
    AND o.cnum <> c1.cnum
  )
);

-- 71. Find salespeople with customers located in their cities (using both ANY and IN).
SELECT snum
FROM salespeople s
WHERE s.city = ANY (SELECT city FROM customers WHERE snum = s.snum);

SELECT snum
FROM salespeople
WHERE city IN (SELECT city FROM customers WHERE snum = salespeople.snum);

-- 72. Find all salespeople for whom there are customers that follow them in alphabetical order. (Using ANY and EXISTS)
SELECT DISTINCT s.snum
FROM salespeople s
WHERE EXISTS (
  SELECT 1
  FROM customers c1, customers c2
  WHERE c1.snum = s.snum
  AND c1.cname < c2.cname
);

-- 73. Select customers who have a greater rating than any customer in Rome.
SELECT cname
FROM customers
WHERE rating > ALL (SELECT rating FROM customers WHERE city = 'Rome');

-- 74. Select all orders that had amounts that were greater than at least one of the orders from Oct 6th.
SELECT *
FROM orders
WHERE amount > ANY (SELECT amount FROM orders WHERE order_date = '2025-10-06');

-- 75. Find all orders with amounts smaller than any amount for a customer in San Jose. (Both using ANY and without ANY)
SELECT *
FROM orders
WHERE amount < ALL (SELECT amount FROM orders WHERE cnum IN (SELECT cnum FROM customers WHERE city = 'San Jose'));

SELECT *
FROM orders
WHERE amount < ANY (SELECT amount FROM orders WHERE cnum IN (SELECT cnum FROM customers WHERE city = 'San Jose'));

-- 76. Select those customers whose ratings are higher than every customer in Paris. (Using both ALL and NOT EXISTS).
SELECT cname
FROM customers
WHERE rating > ALL (SELECT rating FROM customers WHERE city = 'Paris');

SELECT cname
FROM customers
WHERE NOT EXISTS (
  SELECT 1
  FROM customers c2
  WHERE c2.city = 'Paris'
  AND customers.rating <= c2.rating
);

-- 77. Select all customers whose ratings are equal to or greater than ANY of the Seeres.
SELECT *
FROM customers
WHERE rating >= ANY (SELECT rating FROM customers WHERE city = 'Seeres');

-- 78. Find all salespeople who have no customers located in their city. (Both using ANY and ALL)
SELECT snum
FROM salespeople s
WHERE NOT EXISTS (
  SELECT 1
  FROM customers c
  WHERE c.city = s.city
  AND c.snum = s.snum
);

SELECT snum
FROM salespeople
WHERE snum NOT IN (SELECT snum FROM customers WHERE city = salespeople.city);

-- 79. Find all orders for amounts greater than any for the customers in London.
SELECT *
FROM orders
WHERE amount > ANY (SELECT amount FROM orders WHERE cnum IN (SELECT cnum FROM customers WHERE city = 'London'));

-- 80. Find all salespeople and customers located in London.
SELECT snum, cname
FROM customers
WHERE city = 'London';

-- 81. For every salesperson, dates on which highest and lowest orders were brought.
SELECT snum, MAX(order_date), MIN(order_date)
FROM orders
GROUP BY snum;

-- 82. List all of the salespeople and indicate those who don’t have customers in their cities as well as those who do have.
SELECT snum, sname, CASE WHEN EXISTS (
  SELECT 1
  FROM customers c
  WHERE c.city = salespeople.city
  AND c.snum = salespeople.snum
) THEN 'Has customers in city' ELSE 'Does not have customers in city' END AS status
FROM salespeople;

-- 83. Append strings to the selected fields, indicating whether or not a given salesperson was matched to a customer in his city.
SELECT snum, sname, city,
       CASE WHEN EXISTS (
         SELECT 1
         FROM customers c
         WHERE c.city = salespeople.city
         AND c.snum = salespeople.snum
       ) THEN 'Matched' ELSE 'Not Matched' END AS match_status
FROM salespeople;

-- 84. Create a union of two queries that shows the names, cities, and ratings of all customers. Those with a rating of 200 or greater will also have the words ‘High Rating’, while the others will have the words ‘Low Rating’.
SELECT cname, city, rating, 'High Rating' AS rating_status
FROM customers
WHERE rating >= 200
UNION
SELECT cname, city, rating, 'Low Rating' AS rating_status
FROM customers
WHERE rating < 200;

-- 85. Write command that produces the name and number of each salesperson and each customer with more than one current order. Put the result in alphabetical order.
SELECT s.snum, s.sname, c.cname, c.cnum
FROM salespeople s
JOIN customers c ON s.snum = c.snum
WHERE c.cnum IN (SELECT cnum FROM orders GROUP BY cnum HAVING COUNT(order_id) > 1)
ORDER BY s.sname, c.cname;

-- 86. Form a union of three queries. Have the first select the snums of all salespeople in San Jose, then second the cnums of all customers in San Jose and the third the onums of all orders on Oct. 3. Retain duplicates between the last two queries, but eliminate redundancies between either of them and the first.
SELECT snum FROM salespeople WHERE city = 'San Jose'
UNION
SELECT cnum FROM customers WHERE city = 'San Jose'
UNION ALL
SELECT onum FROM orders WHERE order_date = '2025-10-03';

-- 87. Produce all the salespeople in London who had at least one customer there.
SELECT DISTINCT snum
FROM salespeople
WHERE snum IN (SELECT snum FROM customers WHERE city = 'London');

-- 88. Produce all the salespeople in London who did not have customers there.
SELECT DISTINCT snum
FROM salespeople
WHERE snum NOT IN (SELECT snum FROM customers WHERE city = 'London');

-- 89. We want to see salespeople matched to their customers without excluding those salesperson who were not currently assigned to any customers. (Use OUTER join and UNION)
SELECT s.snum, s.sname, c.cname
FROM salespeople s
LEFT OUTER JOIN customers c ON s.snum = c.snum
UNION
SELECT snum, sname, NULL
FROM salespeople
WHERE snum NOT IN (SELECT snum FROM customers);




