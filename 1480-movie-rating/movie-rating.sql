WITH user_ratings AS (
    SELECT 
        u.name,
        COUNT(*) AS cnt
    FROM MovieRating mr
    JOIN Users u ON mr.user_id = u.user_id
    GROUP BY u.name
),
feb_ratings AS (
    SELECT 
        m.title,
        AVG(mr.rating) AS avg_rating
    FROM MovieRating mr
    JOIN Movies m ON mr.movie_id = m.movie_id
    WHERE mr.created_at >= DATE '2020-02-01' AND mr.created_at < DATE '2020-03-01'
    GROUP BY m.title
)
-- get top user
SELECT name AS results
FROM (
    SELECT name
    FROM user_ratings
    WHERE cnt = (SELECT MAX(cnt) FROM user_ratings)
    ORDER BY name
)
WHERE ROWNUM = 1

UNION ALL

-- get top movie in Feb 2020
SELECT title AS results
FROM (
    SELECT title
    FROM feb_ratings
    WHERE avg_rating = (SELECT MAX(avg_rating) FROM feb_ratings)
    ORDER BY title
)
WHERE ROWNUM = 1;


