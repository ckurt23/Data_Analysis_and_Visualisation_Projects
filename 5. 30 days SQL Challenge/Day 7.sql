-- Google interview question, taken from StrataStrach    Difficulty: HARD
/*
Counting Instances in Text

Find the number of times the words 'bull' and 'bear' occur in the contents.
We're counting the number of times the words occur so words like 'bullish' should not be included in our count.
Output the word 'bull' and 'bear' along with the corresponding number of occurrences.

Table: google_file_store
filename: VARCHAR
contents: VARCHAR
*/

SELECT
    word, nentry
FROM
    ts_stat('SELECT to_tsvector(contents) FROM google_file_store')
WHERE
    word LIKE 'bull' OR word LIKE 'bear';
    
-- OR

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
