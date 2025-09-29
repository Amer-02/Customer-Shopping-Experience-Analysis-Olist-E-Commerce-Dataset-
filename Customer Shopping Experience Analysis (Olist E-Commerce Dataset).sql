-- Customers Table
CREATE TABLE customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix INT,
    customer_city VARCHAR(100),
    customer_state VARCHAR(10)
);

-- Orders Table
CREATE TABLE orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50),
    order_status VARCHAR(50),
    order_purchase_timestamp DATETIME,
    order_approved_at DATETIME,
    order_delivered_carrier_date DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Order Items Table
CREATE TABLE order_items (
    order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date DATETIME,
    price DECIMAL(10,2),
    freight_value DECIMAL(10,2),
    PRIMARY KEY(order_id, order_item_id) -- Since an order can have multiple products
);

-- Products  Table
CREATE TABLE products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(100),
    product_name_length INT,
    product_description_length INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);


-- 1. Total Revenue Over Time (Monthly Sales Trend)
SELECT
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS month,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY DATE_FORMAT(order_purchase_timestamp, '%Y-%m')
ORDER BY month; -- To show growth trend in sales.

-- GMV (product sales only)
SELECT ROUND(SUM(oi.price), 2) AS GMV
FROM order_items oi;

-- Total Customer Spend (product + freight)
SELECT ROUND(SUM(oi.price + oi.freight_value), 2) AS total_spend
FROM order_items oi;

-- 2. Top 10 Product Categories by Revenue
SELECT 
    p.product_category_name,
    ROUND(SUM(oi.price), 2) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY revenue DESC
LIMIT 10; -- To identify categories that are driving revenue.

-- 3. Average Order Value (AOV)
SELECT 
    ROUND(SUM(oi.price + oi.freight_value) / COUNT(DISTINCT o.order_id), 2) AS avg_order_value
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id;

-- 4. Repeat Purchase Rate
WITH customer_orders AS (
    SELECT c.customer_unique_id, COUNT(o.order_id) AS order_count
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
)
SELECT
    COUNT(DISTINCT customer_unique_id) AS total_customers,
    COUNT(DISTINCT CASE WHEN order_count > 1 THEN customer_unique_id END) AS repeat_customers,
    ROUND(
        COUNT(DISTINCT CASE WHEN order_count > 1 THEN customer_unique_id END) * 100.0
        / COUNT(DISTINCT customer_unique_id), 2
    ) AS repeat_rate_pct
FROM customer_orders;
 -- Measures customer loyalty. 

-- 5. Top 10 Customers by Spending
SELECT 
    o.customer_id,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS total_spent,
    COUNT(DISTINCT o.order_id) AS order_count
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.customer_id
ORDER BY total_spent DESC
LIMIT 10; -- To identify high-value customers. 


-- SQL Workflow for AOV (Average Order Value) Analysis

-- 1. Monthly AOV Trend
SELECT 
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS month,
    ROUND(SUM(oi.price) / COUNT(DISTINCT o.order_id), 2) AS avg_order_value_gmv,
    ROUND(SUM(oi.price + oi.freight_value) / COUNT(DISTINCT o.order_id), 2) AS avg_order_value_total
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY month
ORDER BY month; -- This shows how AOV evolves month by month (GMV vs Customer Spend). 

-- 2. AOV by Category
SELECT 
    p.product_category_name AS category,
    ROUND(SUM(oi.price) / COUNT(DISTINCT o.order_id), 2) AS avg_order_value_gmv,
    ROUND(SUM(oi.price + oi.freight_value) / COUNT(DISTINCT o.order_id), 2) AS avg_order_value_total
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE o.order_status = 'delivered'
GROUP BY category
ORDER BY avg_order_value_gmv DESC
LIMIT 10; -- This shows which product categories drive higher-value baskets. 

-- 3. AOV by Customer Segment (Repeat vs New)
WITH customer_orders AS (
    SELECT c.customer_unique_id, COUNT(o.order_id) AS total_orders
    FROM orders o
    JOIN customers c ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
)
SELECT 
    CASE 
        WHEN total_orders = 1 THEN 'New Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,
    ROUND(SUM(oi.price) / COUNT(DISTINCT o.order_id), 2) AS avg_order_value_gmv,
    ROUND(SUM(oi.price + oi.freight_value) / COUNT(DISTINCT o.order_id), 2) AS avg_order_value_total
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN customers c ON o.customer_id = c.customer_id
JOIN customer_orders co ON c.customer_unique_id = co.customer_unique_id
WHERE o.order_status = 'delivered'
GROUP BY customer_type; -- This shows how repeat customers tend to spend more. 


-- Category Contribution to Revenue

-- 1. Total Revenue by Category
SELECT 
    p.product_category_name AS category,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY category
ORDER BY revenue DESC;

-- 2. Category Contribution Percentage
WITH category_revenue AS (
    SELECT 
        p.product_category_name AS category,
        SUM(oi.price + oi.freight_value) AS revenue
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    JOIN orders o ON oi.order_id = o.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY category
),
total_revenue AS (
    SELECT SUM(revenue) AS total_rev FROM category_revenue
)
SELECT 
    cr.category,
    ROUND(cr.revenue, 2) AS revenue,
    ROUND((cr.revenue / tr.total_rev) * 100, 2) AS contribution_pct
FROM category_revenue cr
CROSS JOIN total_revenue tr
ORDER BY contribution_pct DESC;

















