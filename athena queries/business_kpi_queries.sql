-- =====================================================
-- Enterprise Retail Data Lake - Athena KPI Queries
-- =====================================================

-- =====================================================
-- 1. Total Revenue
-- =====================================================

SELECT 
    ROUND(SUM(total_amount),2) AS total_revenue
FROM retail_curated_surya;


-- =====================================================
-- 2. Total Orders
-- =====================================================

SELECT 
    COUNT(order_id) AS total_orders
FROM retail_curated_surya;


-- =====================================================
-- 3. Top 10 Customers by Revenue
-- =====================================================

SELECT 
    customer_id,
    ROUND(SUM(total_amount),2) AS customer_spend
FROM retail_curated_surya
GROUP BY customer_id
ORDER BY customer_spend DESC
LIMIT 10;


-- =====================================================
-- 4. Revenue by City
-- =====================================================

SELECT 
    city,
    ROUND(SUM(total_amount),2) AS revenue
FROM retail_curated_surya
GROUP BY city
ORDER BY revenue DESC;


-- =====================================================
-- 5. Monthly Revenue Trend
-- =====================================================

SELECT 
    year,
    month,
    ROUND(SUM(total_amount),2) AS revenue
FROM retail_curated_surya
GROUP BY year, month
ORDER BY year, month;


-- =====================================================
-- 6. Payment Method Analysis
-- =====================================================

SELECT 
    payment_method,
    COUNT(*) AS total_orders,
    ROUND(SUM(total_amount),2) AS revenue
FROM retail_curated_surya
GROUP BY payment_method
ORDER BY revenue DESC;


-- =====================================================
-- 7. Revenue by Product Category
-- =====================================================

SELECT 
    p.category,
    ROUND(SUM(o.total_amount),2) AS revenue,
    COUNT(o.order_id) AS total_orders
FROM retail_curated_surya o
JOIN products p
    ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC;


-- =====================================================
-- 8. Revenue by Brand
-- =====================================================

SELECT 
    p.brand,
    ROUND(SUM(o.total_amount),2) AS revenue,
    COUNT(o.order_id) AS total_orders
FROM retail_curated_surya o
JOIN products p
    ON o.product_id = p.product_id
GROUP BY p.brand
ORDER BY revenue DESC;


-- =====================================================
-- 9. Customer Demographic Analysis
-- =====================================================

SELECT 
    c.gender,
    COUNT(DISTINCT o.customer_id) AS total_customers,
    ROUND(SUM(o.total_amount),2) AS revenue
FROM retail_curated_surya o
JOIN customers c
    ON o.customer_id = c.customer_id
GROUP BY c.gender
ORDER BY revenue DESC;


-- =====================================================
-- 10. Average Order Value
-- =====================================================

SELECT 
    ROUND(AVG(total_amount),2) AS average_order_value
FROM retail_curated_surya;


-- =====================================================
-- 11. Highest Revenue Month
-- =====================================================

SELECT 
    year,
    month,
    ROUND(SUM(total_amount),2) AS revenue
FROM retail_curated_surya
GROUP BY year, month
ORDER BY revenue DESC
LIMIT 1;


-- =====================================================
-- 12. Orders Count by Year
-- =====================================================

SELECT 
    year,
    COUNT(order_id) AS total_orders
FROM retail_curated_surya
GROUP BY year
ORDER BY year;


-- =====================================================
-- 13. Top Selling Products
-- =====================================================

SELECT 
    p.product_name,
    COUNT(o.order_id) AS total_orders,
    ROUND(SUM(o.total_amount),2) AS revenue
FROM retail_curated_surya o
JOIN products p
    ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC
LIMIT 10;


-- =====================================================
-- 14. State-wise Revenue Analysis
-- =====================================================

SELECT 
    c.state,
    ROUND(SUM(o.total_amount),2) AS revenue
FROM retail_curated_surya o
JOIN customers c
    ON o.customer_id = c.customer_id
GROUP BY c.state
ORDER BY revenue DESC;


-- =====================================================
-- 15. Revenue Contribution Percentage
-- =====================================================

SELECT 
    city,
    ROUND(
        (SUM(total_amount) * 100.0) /
        (SELECT SUM(total_amount)
         FROM retail_curated_surya),
    2) AS revenue_percentage
FROM retail_curated_surya
GROUP BY city
ORDER BY revenue_percentage DESC;