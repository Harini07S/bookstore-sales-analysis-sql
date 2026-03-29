SELECT 
MonthlyData.Month,
MonthlyData.Genre,
MonthlyData.Total_Quantity
FROM (
SELECT 
DATE_FORMAT(o.order_date, '%Y-%m') AS Month,
b.genre AS Genre,
SUM(o.quantity) AS Total_Quantity,
RANK() OVER (PARTITION BY DATE_FORMAT(o.order_date, '%Y
%m') ORDER BY SUM(o.quantity) DESC) AS Genre_Rank
FROM orders o
JOIN books b ON o.book_id = b.book_id
GROUP BY Month, Genre
) AS MonthlyData
WHERE MonthlyData.Genre_Rank = 1;
