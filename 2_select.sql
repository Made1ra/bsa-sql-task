SELECT 
    m.movie_id AS id,
    m.title,
    COUNT(c.person_id) AS actors_count
FROM 
    movies m
JOIN 
    characters c ON m.movie_id = c.movie_id
WHERE 
    m.release_date >= (CURRENT_DATE - INTERVAL '5 years')
GROUP BY 
    m.movie_id, m.title;
