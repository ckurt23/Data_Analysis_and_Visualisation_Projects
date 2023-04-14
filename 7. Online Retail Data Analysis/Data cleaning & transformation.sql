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

-- to be continued.
