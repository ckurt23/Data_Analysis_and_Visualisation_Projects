-- Ollivander's Inventory // From hackerrank.com
/*
Harry Potter and his friends are at Ollivander's with Ron, finally replacing Charlie's old broken wand.
Hermione decides the best way to choose is by determining the minimum number of gold galleons needed to buy each non-evil wand of high power and age. 
Write a query to print the id, age, coins_needed, and power of the wands that Ron's interested in, sorted in order of descending power. 
If more than one wand has same power, sort the result in order of descending age.

Wands
id:           integer
code:         integer
coins_needed: integer
power:        integer

Wands_Property
code:      integer
age:       integer
is evil:   integer
*/

SELECT
    w.id,
    wp.age,
    w.coins_needed,
    w.power
FROM 
    Wands AS w
LEFT JOIN Wands_Property AS wp ON w.code = wp.code
WHERE 
    is_evil = 0
    AND w.coins_needed = (SELECT MIN(wa.coins_needed)
                         FROM Wands AS wa
                         LEFT JOIN Wands_Property AS wap ON wa.code = wap.code
                         WHERE w.power = wa.power AND wp.age = wap.age)
ORDER BY
    w.power DESC, wp.age DESC;
