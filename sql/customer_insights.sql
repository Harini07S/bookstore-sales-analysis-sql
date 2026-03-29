SELECT 
    c.customer_id,
    c.name AS customer_name,
    COUNT(o.order_id) AS total_books_purchased,
    ROUND(SUM(o.total_amount), 2) AS total_revenue,
    
    -- Subquery to get the most purchased genre for each customer
    (
        SELECT b1.genre
        FROM orders o1
        JOIN books b1 ON o1.book_id = b1.book_id
        WHERE o1.customer_id = c.customer_id
        GROUP BY b1.genre
        ORDER BY COUNT(*) DESC
        LIMIT 1
    ) AS favorite_genre,
    
    MIN(o.order_date) AS first_purchase_date

FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN books b ON o.book_id = b.book_id

GROUP BY c.customer_id, c.name
ORDER BY total_revenue DESC;
