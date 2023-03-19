-- We want to reward our users who have been around the longest.  
--Challenge 1: Find the 5 oldest users
SELECT id, username, NOW()-created_at AS oldest_user_list
FROM users
ORDER BY oldest_user_list DESC
LIMIT 5;

/*What day of the week do most users register on?
We need to figure out when to schedule an ad campgain*/

SELECT to_char(created_at, 'Day') AS day_of_week, COUNT(*) AS total_count
FROM users
GROUP BY day_of_week
ORDER BY total_count DESC;

/*We want to target our inactive users with an email campaign.
Find the users who have never posted a photo*/

