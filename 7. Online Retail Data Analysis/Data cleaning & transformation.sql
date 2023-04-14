-- converted source data file to csv first.

                                      -- created table first in pgAdmin4, PostgreSQL.
CREATE TABLE public."retail_sales" (
	invoice varchar(10),
	stock_code varchar(25),
	description varchar(100),
	quantity int,
	invoice_date timestamp,
	price NUMERIC(10,2),
	customer_id int,
	country varchar(50)
);

                                      -- imported csv file from desktop
COPY public.retail_sales
FROM 'C:\Users\90537\Desktop\online_retail_IIv2.csv' DELIMITER ';' CSV HEADER;

					-- back up original data
CREATE TABLE v2retail_sales AS
SELECT *
FROM retail_sales;

					-- checked if there are duplicate rows
					-- delete rows with empty cells, updated rows 800k, descreased from 1m total.
DELETE FROM v2retail_sales
WHERE
	invoice is NULL OR
	stock_code is NULL OR
	description is NULL OR
	quantity is NULL OR
	invoice_date is NULL OR
	price is NULL OR
	customer_id is NULL OR
	country is NULL;
	
					-- adjust date & time
ALTER TABLE v2retail_sales
ADD COLUMN
new_invoice_date DATE

ALTER TABLE v2retail_sales
ADD COLUMN
new_invoice_time TIME

UPDATE v2retail_sales
SET new_invoice_date = invoice_date::date

UPDATE v2retail_sales
SET new_invoice_time = invoice_date::time

					-- Adding column for cancelled invoices
ALTER TABLE v2retail_sales
ADD COLUMN cancelled_invoice VARCHAR(1);

UPDATE v2retail_sales
SET cancelled_invoice =
	CASE
	WHEN invoice ILIKE 'c%' THEN 'X'
	ELSE 'O'
	END

-- to be continued.
