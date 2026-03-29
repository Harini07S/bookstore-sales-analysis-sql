SELECT 
DATE_FORMAT(order_date, '%Y-%m') AS Month,
COUNT(order_id) AS Total_Orders,
SUM(quantity) AS Books_Sold,
ROUND(SUM(total_amount), 2) AS Monthly_Revenue
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY Month;
