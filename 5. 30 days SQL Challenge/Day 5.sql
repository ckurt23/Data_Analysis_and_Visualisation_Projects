-- Popularity Percentage
-- From StrataStratch    Meta/Facebook Question     Difficulty: HARD

/*
Find the popularity percentage for each user on Meta/Facebook. 
The popularity percentage is defined as the total number of friends the user has divided by the total number of users on the platform, then converted into a percentage by multiplying by 100.
Output each user along with their popularity percentage. Order records in ascending order by user id.
The 'user1' and 'user2' column are pairs of friends.

facebook_friends
user1: int
user2: int
*/

SELECT
    user_id,
    COUNT(DISTINCT friend_id) * 100.0 / (SELECT COUNT(DISTINCT userr) FROM (
    SELECT user1 AS userr FROM facebook_friends 
    UNION 
    SELECT user2 AS userr FROM facebook_friends) AS all_users) AS popularity_percentage
FROM (
SELECT
    user1 AS user_id,
    user2 AS friend_id
FROM
    facebook_friends
UNION
SELECT
    user2 AS user_id,
    user1 AS friend_id
FROM
    facebook_friends) AS all_friends
GROUP BY
    user_id
ORDER BY
    user_id;
