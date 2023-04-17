-- Which customers have the highest total purchase value and how does their purchase behavior change over time?
-- Can you identify any trends or patterns in their purchasing habits?
SELECT
	date_trunc('quarter', new_invoice_date) AS quarter_period,
	SUM(price) AS total_purchase
FROM
	v2retail_sales
WHERE customer_id IN (
	SELECT customer_id
	FROM v2retail_sales
	GROUP BY customer_id
	ORDER BY SUM(price) DESC
	LIMIT 5)
GROUP BY
	quarter_period
ORDER BY
	quarter_period;

--
