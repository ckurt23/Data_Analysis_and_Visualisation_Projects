/*
Microsoft interview question    Difficulty: HARD
Title: Premium vs Freemium
-----
Find the total number of downloads for paying and non-paying users by date. Include only records where non-paying customers have more downloads than paying customers. The output should be sorted by earliest date first and contain 3 columns date, non-paying downloads, paying downloads.

Table 1: ms_user_dimension
user_id: int
acc_id: int

Table 2: ms_acc_dimension
acc_id: int
paying_customer: varchar

Table 3: ms_download_facts
date: datetime
user_id: int
downloads: int
*/

SELECT 
    date_trunc('day', df.date) AS date,
    SUM(CASE WHEN ad.paying_customer = 'no' THEN df.downloads ELSE 0 END) AS non_paying_downloads,
    SUM(CASE WHEN ad.paying_customer = 'yes' THEN df.downloads ELSE 0 END) AS paying_downloads
FROM 
    ms_download_facts AS df
    LEFT JOIN ms_user_dimension AS ud ON df.user_id = ud.user_id
    LEFT JOIN ms_acc_dimension AS ad ON ud.acc_id = ad.acc_id
GROUP BY
    date_trunc('day', df.date)
HAVING
    SUM(CASE WHEN ad.paying_customer = 'no' THEN df.downloads ELSE 0 END) >
    SUM(CASE WHEN ad.paying_customer = 'yes' THEN df.downloads ELSE 0 END)
ORDER BY
    date ASC;
