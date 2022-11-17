--Self Join
SELECT
    e.firstname || ' ' || e.lastname AS employee,
    m.firstname || ' ' || m.lastname AS manager
FROM
    employee e
INNER JOIN employee m ON m.employee_id = e.manager_id
ORDER BY employee;



--Partition, Dense_Rank
SELECT 
	id,
	salary,
	department
FROM (SELECT
	  id,
	  salary,
	  department,
	  DENSE_RANK() OVER( PARTITION BY department ORDER BY salary DESC) AS dr
	  FROM compensation) AS tmp
WHERE dr = 1;



--Table transformation
--Transform from item_sold_a into item_sold_b
SELECT date_sk, 
	'a' as item, 
	item_a as qty 
FROM items_sold_a
UNION ALL
SELECT date_sk, 
	'b' as item, 
	item_b as qty 
FROM items_sold_a
UNION ALL
SELECT date_sk, 
	'c' as item, 
	item_c as qty 
FROM items_sold_a
ORDER BY date_sk, item;

--Transform from item_sold_b into item_sold_a
SELECT date_sk, 
	SUM(CASE WHEN item = 'a' THEN qty ELSE 0 END) AS item_a,
	SUM(CASE WHEN item = 'b' THEN qty ELSE 0 END) AS item_b, 
	SUM(CASE WHEN item = 'c' THEN qty ELSE 0 END) AS item_c
FROM items_sold_b
GROUP BY date_sk;
