-- We want to reward our users who have been around the longest.  
--Challenge 1: Find the 5 oldest users
SELECT id, username, NOW()-created_at AS oldest_user_list
FROM users
ORDER BY oldest_user_list DESC
LIMIT 5;

