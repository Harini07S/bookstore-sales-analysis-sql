-- Business Question:
-- What are the key product and sales insights?

-- 1. Total books sold per genre
SELECT 
    b.genre,
    SUM(o.quantity) AS Total_Books_Sold
FROM orders o
JOIN books b ON o.book_id = b.book_id
GROUP BY b.genre;


-- 2. Most frequently ordered book
SELECT 
    o.book_id,
    b.title,
    COUNT(o.order_id) AS order_count
FROM orders o
JOIN books b ON o.book_id = b.book_id
GROUP BY o.book_id, b.title
ORDER BY order_count DESC
LIMIT 1;


-- 3. Total books sold by each author
SELECT 
    b.author,
    SUM(o.quantity) AS Total_Books_Sold
FROM orders o
JOIN books b ON o.book_id = b.book_id
GROUP BY b.author;


-- 4. Customer who spent the most
SELECT 
    c.customer_id,
    c.name,
    SUM(o.total_amount) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC
LIMIT 1;
