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

					-- delete rows with empty cells
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

-- to be continued.
