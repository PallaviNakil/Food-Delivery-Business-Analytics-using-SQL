-- =========================================================
-- Project Title: Food Delivery Analytics using SQL
-- =========================================================
--
-- Description:
-- This SQL project analyzes food delivery operations
-- using customer, delivery, and revenue data to
-- generate business insights and operational analysis.
--
-- The dataset contains information related to:
-- • Customer demographics and loyalty
-- • Order timings and delivery distances
-- • Traffic and weather impact on deliveries
-- • Restaurant and delivery partner ratings
-- • Revenue, discounts, tips, and final payments
-- • Order cancellations, delays, and refunds
-- • Premium customers and promo code usage
-- • Delivery partner experience and efficiency
--
-- Objectives:
-- • Analyze customer ordering behavior
-- • Identify peak ordering hours
-- • Measure delivery performance and efficiency
-- • Track revenue and profitability
-- • Detect cancellation and delay patterns
--
-- Tools Used:
-- • SQL Server Management Studio (SSMS)
-- • SQL Queries for Data Analysis
--
-- Database Table:
-- dbo.Orders
--
-- =========================================================

USE FoodDeliveryDB

--1. How many total orders were placed?
SELECT COUNT(*) AS total_orders
FROM Orders;

--2. What is the total revenue generated?
SELECT FORMAT(SUM(final_amount_paid), 'N2') AS total_revenue
FROM Orders;

--3. What is the average delivery time?
SELECT ROUND(AVG(delivery_time_minutes), 2) AS avg_delivery_minutes
FROM Orders

--4. What is the average customer rating?
SELECT ROUND(AVG(customer_rating),2) AS avg_rating
FROM Orders;

--5. What is the average order value?
SELECT ROUND(AVG(order_value),2) AS avg_order_value
FROM Orders

--6. What is the average customer age?
SELECT ROUND(AVG(customer_age),2) AS avg_customer_age
FROM Orders

--7. How many premium and non-premium customers are there?
SELECT premium_customer_flag,
COUNT (*) AS total_customers
FROM Orders
GROUP BY premium_customer_flag;

--8. Do premium customers spend more money?
SELECT premium_customer_flag,
ROUND(AVG(final_amount_paid),2) AS avg_spending
FROM Orders
GROUP BY premium_customer_flag;

--9. What is the average customer loyalty score?
SELECT ROUND(AVG(customer_loyalty_score),2) AS avg_loyalty_score
FROM Orders

--10. What is the average delivery distance?
SELECT CONCAT(ROUND(AVG( delivery_distance_km ),2), ' Km') AS avg_distance_km
FROM Orders

--11. What is the average food preparation time?
SELECT CONCAT(ROUND(AVG(preparation_time_minutes),2),' Minutes') AS avg_prep_time
FROM Orders

--12. What is the average discount amount per order?
SELECT ROUND(AVG(discount_amount),2) AS avg_discount
FROM Orders;
--13. What is the average tip amount received?
SELECT ROUND(AVG(tip_amount),2) AS avg_tip
FROM Orders;

--14. How many deliveries were delayed?
SELECT COUNT (*) AS delayed_delivery
FROM Orders
WHERE delayed_delivery_flag = 1;

--15. What percentage of deliveries were delayed?
SELECT ROUND((COUNT(CASE WHEN delayed_delivery_flag = 1 THEN 1 END) * 100.0) / COUNT(*),2) AS delay_percentage
FROM Orders;

--16. Does traffic affect delivery time?
SELECT ROUND(traffic_level_score,0) AS traffic_level,
CONCAT(ROUND(AVG(delivery_time_minutes),2),' Min') AS avg_delivery_time
FROM Orders
GROUP BY ROUND( traffic_level_score,0)
ORDER BY avg_delivery_time ASC

--17. Does weather affect delivery time?
SELECT ROUND(weather_severity_score,0) AS Weather_Score,
CONCAT(ROUND(AVG(delivery_time_minutes),2),' Min') AS avg_delivery_time
FROM Orders
GROUP BY ROUND(Weather_severity_score,0)
ORDER BY avg_delivery_time DESC

--18. Does delivery partner experience improve efficiency?
SELECT ROUND(delivery_partner_experience_years,0) AS partner_experience,
ROUND(AVG( delivery_efficiency_score),0) AS avg_efficiency
FROM Orders
GROUP BY delivery_partner_experience_years
ORDER BY avg_efficiency DESC

--19. Which city tier generates the highest revenue?
SELECT city_tier,
ROUND(SUM(final_amount_paid),2) AS bill_amount
FROM Orders
GROUP BY city_tier
ORDER BY bill_amount DESC

--20. Which month generates the highest revenue?
SELECT order_month,
ROUND(SUM(final_amount_paid),2) AS monthly_revenue
FROM Orders
GROUP BY order_month
ORDER BY monthly_revenue DESC

--21. What is the total tip amount received?
SELECT FORMAT(ROUND(SUM(tip_amount),2),'N2') AS TOTAL_TIP
FROM Orders

--22. Which order hours are the busiest?
SELECT order_hour,
COUNT(*) AS total_orders
FROM Orders
GROUP BY order_hour
ORDER BY total_orders DESC

--23. How many orders were cancelled ?
SELECT COUNT(*) AS cancelled_orders
FROM Orders
WHERE cancellation_flag = 1;

--24. How many orders were refunded?
SELECT COUNT(*) AS refunded_orders
FROM Orders
WHERE refund_flag = 1;

--25. Does promo code usage increase revenue?
SELECT promo_code_used,
FORMAT(ROUND(SUM(final_amount_paid),2),'N2')AS total_revenue
FROM Orders
GROUP BY promo_code_used;

--26. Top 5 Highest Spending Orders
SELECT TOP 5 order_id,
final_amount_paid
FROM Orders
ORDER BY final_amount_paid DESC;


--27. How are orders distributed across different spending categories?
SELECT TOP 20 order_id,
final_amount_paid,
CASE
   WHEN final_amount_paid > 200 THEN 'High Value'
   WHEN final_amount_paid > 100 THEN 'Medium Value'
   ELSE 'Low Value'
END AS order_category
FROM Orders;


