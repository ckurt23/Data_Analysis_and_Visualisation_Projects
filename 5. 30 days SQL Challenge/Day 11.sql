/*
# SQL Case Study: Top 3 Customers by Total Spend

## Scenario
You are working as a data analyst for an e-commerce platform. The company wants to identify the top 3 customers based on the total amount they have spent on orders.

## Data Structure
The following tables are available:

- **Customers**: Contains customer information (e.g., `customer_id`, `name`, `email`, etc.).
- **Orders**: Contains order details (e.g., `order_id`, `customer_id`, `order_date`, etc.).
- **Products**: Contains product information (e.g., `product_id`, `product_name`, `category`, etc.).
- **Order_Details**: Links orders to products and includes the quantity and price per unit.

## Task
Find the **top 3 customers** by the **total amount spent** across all their orders.

## Approach
1. **Calculate Total Spend Per Order Line**: Join the `Order_Details` table with the `Orders` table to retrieve `customer_id` and calculate the total price for each order line (i.e., `quantity × price per unit`).
2. **Sum Total Spend Per Customer**: Group the data by `customer_id` and calculate the total amount spent by each customer.
3. **Join with Customers Table**: Join the result with the `Customers` table to retrieve customer names.
4. **Order and Limit**: Order the result by total amount spent in descending order and limit the results to the top 3 customers.

## SQL Query */

WITH OrderTotals AS (
    SELECT
        O.customer_id,
        OD.quantity * OD.price_per_unit AS order_total
    FROM
        Order_Details AS OD
    INNER JOIN
        Orders AS O ON OD.order_id = O.order_id
)
SELECT
    C.name AS customer_name,
    SUM(OT.order_total) AS all_amount_of_orders
FROM
    OrderTotals AS OT
INNER JOIN
    Customers AS C ON C.customer_id = OT.customer_id
GROUP BY
    C.customer_id, C.name
ORDER BY
    all_amount_of_orders DESC
LIMIT 3;

/*
    Explanation
Step 1: The WITH clause defines a Common Table Expression (CTE) to calculate the total order amount for each line item by multiplying quantity by price_per_unit.
Step 2: In the main query, we join the result from the CTE with the Customers table using customer_id to retrieve customer names.
Step 3: We group the results by customer_id and customer_name and calculate the total amount spent per customer using SUM().
Step 4: Finally, we order the results in descending order by total spend and limit the output to the top 3 customers.

*/
