CREATE TABLE files (
    file_id SERIAL PRIMARY KEY,
    file_name VARCHAR(255) NOT NULL,
    mime_type VARCHAR(255) NOT NULL,
    file_key VARCHAR(255) NOT NULL UNIQUE,
    url VARCHAR(255) NOT NULL,
    is_public BOOLEAN NOT NULL DEFAULT FALSE,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    avatar_id INTEGER,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (avatar_id) REFERENCES files(file_id)
);

CREATE TABLE countries (
    country_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE people (
    person_id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    biography TEXT,
    date_of_birth DATE,
    gender VARCHAR(50),
    country_id INTEGER,
    profile_picture_id INTEGER,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (country_id) REFERENCES countries(country_id),
    FOREIGN KEY (profile_picture_id) REFERENCES files(file_id)
);

CREATE TABLE movies (
    movie_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    budget NUMERIC,
    release_date DATE,
    duration INTERVAL,
    director_id INTEGER,
    country_id INTEGER,
    poster_id INTEGER,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (director_id) REFERENCES people(person_id),
    FOREIGN KEY (country_id) REFERENCES countries(country_id),
    FOREIGN KEY (poster_id) REFERENCES files(file_id)
);

CREATE TABLE genres (
    genre_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE movie_genres (
    movie_id INTEGER,
    genre_id INTEGER,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (movie_id, genre_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);

CREATE TABLE characters (
    character_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    role VARCHAR(50) CHECK (role IN ('leading', 'supporting', 'background')),
    movie_id INTEGER,
    person_id INTEGER,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    FOREIGN KEY (person_id) REFERENCES people(person_id)
);

CREATE TABLE people_photos (
    person_id INTEGER,
    file_id INTEGER,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (person_id, file_id),
    FOREIGN KEY (person_id) REFERENCES people(person_id),
    FOREIGN KEY (file_id) REFERENCES files(file_id)
);

CREATE TABLE favorite_movies (
    user_id INTEGER,
    movie_id INTEGER,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, movie_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id)
);
