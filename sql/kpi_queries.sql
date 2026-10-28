-- name: monthly_revenue
SELECT substr(order_date,1,7) AS month, ROUND(SUM(revenue),2) AS revenue, COUNT(*) AS orders
FROM fact_sales GROUP BY month ORDER BY month;

-- name: revenue_by_region
SELECT region, ROUND(SUM(revenue),2) AS revenue, COUNT(*) AS orders,
       ROUND(SUM(revenue)/COUNT(*),2) AS avg_order_value
FROM fact_sales GROUP BY region ORDER BY revenue DESC;

-- name: revenue_by_category
SELECT p.category, ROUND(SUM(f.revenue),2) AS revenue, SUM(f.quantity) AS units
FROM fact_sales f JOIN dim_product p USING(sku) GROUP BY p.category ORDER BY revenue DESC;

-- name: revenue_by_segment_country
SELECT c.country, c.segment, ROUND(SUM(f.revenue),2) AS revenue, COUNT(DISTINCT f.customer_id) AS customers
FROM fact_sales f JOIN dim_customer c USING(customer_id) GROUP BY c.country, c.segment ORDER BY revenue DESC;

-- name: top_customers
SELECT c.customer_id, c.full_name, c.country, c.segment, ROUND(SUM(f.revenue),2) AS revenue, COUNT(*) AS orders
FROM fact_sales f JOIN dim_customer c USING(customer_id)
GROUP BY c.customer_id ORDER BY revenue DESC LIMIT 10;

-- name: headline
SELECT ROUND(SUM(revenue),2) AS total_revenue, COUNT(*) AS total_orders,
       COUNT(DISTINCT customer_id) AS active_customers,
       ROUND(SUM(revenue)/COUNT(*),2) AS avg_order_value,
       ROUND(AVG(discount_pct),2) AS avg_discount_pct
FROM fact_sales;
