SELECT 
    m.movie_id AS id,
    m.title,
    m.release_date,
    m.duration,
    m.description,
    JSON_BUILD_OBJECT(
        'file_id', f.file_id,
        'file_name', f.file_name,
        'mime_type', f.mime_type,
        'file_key', f.file_key,
        'url', f.url,
        'is_public', f.is_public
    ) AS poster,
    JSON_BUILD_OBJECT(
        'id', p.person_id,
        'first_name', p.first_name,
        'last_name', p.last_name,
        'photo', (
            SELECT JSON_BUILD_OBJECT(
                'file_id', pf.file_id,
                'file_name', pf.file_name,
                'mime_type', pf.mime_type,
                'file_key', pf.file_key,
                'url', pf.url,
                'is_public', pf.is_public
            )
            FROM files pf
            WHERE pf.file_id = p.profile_picture_id
        )
    ) AS director,
    ARRAY_AGG(
        JSON_BUILD_OBJECT(
            'id', c.person_id,
            'first_name', cp.first_name,
            'last_name', cp.last_name,
            'photo', (
                SELECT JSON_BUILD_OBJECT(
                    'file_id', cf.file_id,
                    'file_name', cf.file_name,
                    'mime_type', cf.mime_type,
                    'file_key', cf.file_key,
                    'url', cf.url,
                    'is_public', cf.is_public
                )
                FROM files cf
                WHERE cf.file_id = cp.profile_picture_id
            )
        )
    ) AS actors,
    ARRAY_AGG(
        JSON_BUILD_OBJECT(
            'id', g.genre_id,
            'name', g.name
        )
    ) AS genres
FROM 
    movies m
JOIN 
    files f ON m.poster_id = f.file_id
JOIN 
    people p ON m.director_id = p.person_id
LEFT JOIN 
    characters c ON m.movie_id = c.movie_id
LEFT JOIN 
    people cp ON c.person_id = cp.person_id
LEFT JOIN 
    movie_genres mg ON m.movie_id = mg.movie_id
LEFT JOIN 
    genres g ON mg.genre_id = g.genre_id
WHERE 
    m.movie_id = 1
GROUP BY 
    m.movie_id, f.file_id, p.person_id;
