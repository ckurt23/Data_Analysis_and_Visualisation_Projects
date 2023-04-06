SELECT
    new_column,
    COUNT(*) total
FROM(
    SELECT
        filename,
        CASE
            WHEN contents LIKE '% bear %' THEN 'bear'
            ELSE '0'
        END AS new_column
    FROM
        google_file_store
    UNION ALL
    SELECT
        filename,
        CASE
            WHEN contents LIKE '% bull %' THEN 'bull'
            ELSE '0'
        END AS new_column
    FROM
        google_file_store) AS t1
GROUP BY
    new_column
HAVING
    new_column IN ('bear', 'bull');
