--1.Total revenue by branch

SELECT "Branch", ROUND(SUM("Sales")::numeric, 2) AS total_revenue
FROM supermarket_sales
GROUP BY "Branch"
ORDER BY total_revenue DESC;

--2.Top product line by total sales

SELECT "Product line", ROUND(SUM("Sales")::numeric, 2) AS revenue
FROM supermarket_sales
GROUP BY "Product line"
ORDER BY revenue DESC;

--3.Member vs. Normal customer average spend

SELECT "Customer type", ROUND(AVG("Sales")::numeric, 2) AS avg_spend
FROM supermarket_sales
GROUP BY "Customer type";

--4.Gender-based spending & preference

SELECT "Gender", ROUND(AVG("Sales")::numeric, 2) AS avg_spend
FROM supermarket_sales
GROUP BY "Gender";

--5.Payment method popularity

SELECT "Payment", COUNT(*) AS transactions
FROM supermarket_sales
GROUP BY "Payment"
ORDER BY transactions DESC;

--6.Sales by day of week / month

SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'supermarket_sales';

ALTER TABLE supermarket_sales
ADD COLUMN sale_date DATE;

UPDATE supermarket_sales
SET sale_date = TO_DATE("Date", 'MM/DD/YYYY');



SELECT TO_CHAR("sale_date", 'Day') AS day_of_week, ROUND(SUM("Sales")::numeric, 2) AS total_sales
FROM supermarket_sales
GROUP BY day_of_week
ORDER BY total_sales DESC;

--7.Rating vs. Sales correlation

SELECT "Rating",
       ROUND(SUM("Sales")::numeric, 2) AS total_sales
FROM supermarket_sales
GROUP BY "Rating"
ORDER BY "Rating" DESC;



SELECT CORR("Rating", "Sales") FROM supermarket_sales;

--8.Top product line per branch (DENSE_RANK)

SELECT branch, product_line, revenue FROM (
    SELECT "Branch" AS branch, "Product line" AS product_line,
           SUM("Sales") AS revenue,
           DENSE_RANK() OVER (PARTITION BY "Branch" ORDER BY SUM("Sales") DESC) AS rnk
    FROM supermarket_sales
    GROUP BY "Branch", "Product line"
) t WHERE rnk = 1;

--9.Gross income contribution by product line

SELECT "Product line", ROUND(SUM("gross income")::numeric, 2) AS gross_income
FROM supermarket_sales
GROUP BY "Product line"
ORDER BY gross_income DESC;



--10. Peak sales hour

SELECT EXTRACT(HOUR FROM sale_time) AS hour,
       ROUND(SUM("Sales")::numeric, 2) AS total_sales
FROM supermarket_sales
GROUP BY hour
ORDER BY total_sales DESC;








