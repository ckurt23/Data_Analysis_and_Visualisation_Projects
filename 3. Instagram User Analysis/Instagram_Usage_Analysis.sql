-- We want to reward our users who have been around the longest.  
--Challenge 1: Find the 5 oldest users
SELECT id, username, NOW()-created_at AS oldest_user_list
FROM users
ORDER BY oldest_user_list DESC
LIMIT 5;

--What day of the week do most users register on?
--We need to figure out when to schedule an ad campgain

SELECT to_char(created_at, 'Day') AS day_of_week, COUNT(*) AS total_count
FROM users
GROUP BY day_of_week
ORDER BY total_count DESC;

/*We want to target our inactive users with an email campaign.
Find the users who have never posted a photo*/

SELECT u.id,
       u.username,
       COUNT(p.user_id) AS ttl_photo
FROM users AS u
LEFT JOIN photos AS p
ON u.id = p.user_id
GROUP BY u.id
HAVING COUNT(p.user_id) = 0
ORDER BY u.id;

/*We're running a new contest to see who can get the most likes on a single photo.
WHO WON??!!*/

SELECT username, photo_id, total_like
FROM (
       SELECT photo_id, COUNT(*) AS total_like
       FROM likes AS l
       LEFT JOIN photos AS p ON p.id = l.photo_id
       GROUP BY photo_id
       ORDER BY total_like DESC
       LIMIT 1) AS subtable
LEFT JOIN photos AS p ON p.id = subtable.photo_id
LEFT JOIN users AS u ON p.user_id = u.id;

/*Our Investors want to know...
How many times does the average user post?*/
/*total number of photos/total number of users*/

SELECT ROUND(COUNT(DISTINCT p.id)::decimal/COUNT(DISTINCT u.id)::decimal, 2) AS post_per_person
FROM users AS u
LEFT JOIN photos AS p ON p.user_id = u.id;

/*user ranking by postings higher to lower*/
