SELECT 
    c.customer_id,
    c.name AS customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(o.quantity) AS total_books_purchased,
    ROUND(AVG(o.total_amount), 2) AS avg_spend_per_order,
    
    -- Most purchased book title
    (
        SELECT b1.title
        FROM orders o1
        JOIN books b1 ON o1.book_id = b1.book_id
        WHERE o1.customer_id = c.customer_id
        GROUP BY b1.title
        ORDER BY COUNT(*) DESC
        LIMIT 1
    ) AS favorite_book,
    
    -- Most frequently purchased author
    (
        SELECT b2.author
        FROM orders o2
        JOIN books b2 ON o2.book_id = b2.book_id
        WHERE o2.customer_id = c.customer_id
        GROUP BY b2.author
        ORDER BY COUNT(*) DESC
        LIMIT 1
    ) AS favorite_author,

    MAX(o.order_date) AS last_order_date

FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN books b ON o.book_id = b.book_id

GROUP BY c.customer_id, c.name
ORDER BY total_orders DESC;
