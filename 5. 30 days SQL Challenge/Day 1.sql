-- Amazon interview question

-- Monthly Percentage Difference

/*
Given a table of purchases by date, calculate the month-over-month percentage change in revenue. The output should include the year-month date (YYYY-MM) and percentage change, rounded to the 2nd decimal point, and sorted from the beginning of the year to the end of the year.
The percentage change column will be populated from the 2nd month forward and can be calculated as ((this month's revenue - last month's revenue) / last month's revenue)*100.
*/

-- Table name: sf_transactions

/*
id: int
created_at: datetime
value: int
purchase_id: int
*/

SELECT  year_month,
        ROUND(((monthly_total - LAG(monthly_total,1) OVER (ORDER BY year_month)) / LAG(monthly_total,1) OVER (ORDER BY year_month)) * 100
        ,2)
FROM (
    SELECT to_char(created_at, 'YYYY-MM') AS year_month, SUM(value) AS monthly_total
    FROM sf_transactions
    GROUP BY year_month
    ORDER BY year_month
) AS tempo_table
ORDER BY year_month;
