WITH CTE1 AS(
	SELECT OrderNo, OrderDate, Shipdate, DATEPART(week, OrderDate) AS OrderWeek, DATEPART(week, ShipDate) AS ShipWeek
	FROM Orders
	),
CTE2 AS(
	SELECT OrderWeek AS TheWeek, COUNT(OrderWeek) AS NumOrders, 0 AS NumShips
	FROM CTE1
	GROUP BY OrderWeek
	UNION ALL 
	SELECT ShipWeek AS TheWeek, 0 AS NumOrders, COUNT(ShipWeek) AS NumShips
	FROM CTE1
	WHERE ShipWeek IS NOT NULL
	GROUP BY ShipWeek
	)
SELECT TheWeek, SUM(NumOrders) AS NumOrders, SUM(NumShips) AS NumShips
FROM CTE2
GROUP BY TheWeek
