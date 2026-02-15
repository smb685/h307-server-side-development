-- CSD430 Project - Complete Database Setup
-- Author: Sylvester
-- Date: 02/08/2026

-- Create and use database
CREATE DATABASE IF NOT EXISTS CSD430;
USE CSD430;

-- Drop table if exists (for clean start)
DROP TABLE IF EXISTS sylvester_movies_data;

-- Create movies table with primary key
CREATE TABLE sylvester_movies_data (
    movie_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    director VARCHAR(50),
    release_year INT,
    genre VARCHAR(30),
    rating DECIMAL(3,1),
    duration_minutes INT,
    box_office DECIMAL(10,2)
);

-- Insert sample movie data (10 records)
INSERT INTO sylvester_movies_data (title, director, release_year, genre, rating, duration_minutes, box_office) VALUES
('The Shawshank Redemption', 'Frank Darabont', 1994, 'Drama', 9.3, 142, 58.5),
('The Godfather', 'Francis Ford Coppola', 1972, 'Crime', 9.2, 175, 250.0),
('The Dark Knight', 'Christopher Nolan', 2008, 'Action', 9.0, 152, 1004.6),
('Pulp Fiction', 'Quentin Tarantino', 1994, 'Crime', 8.9, 154, 213.9),
('Inception', 'Christopher Nolan', 2010, 'Sci-Fi', 8.8, 148, 836.8),
('Fight Club', 'David Fincher', 1999, 'Drama', 8.8, 139, 101.2),
('Forrest Gump', 'Robert Zemeckis', 1994, 'Drama', 8.8, 142, 678.2),
('The Matrix', 'Lana & Lilly Wachowski', 1999, 'Sci-Fi', 8.7, 136, 465.3),
('Goodfellas', 'Martin Scorsese', 1990, 'Biography', 8.7, 146, 47.1),
('Parasite', 'Bong Joon Ho', 2019, 'Thriller', 8.6, 132, 258.8);

-- Verify data insertion
SELECT 'Database Setup Complete' as Status;
SELECT COUNT(*) as 'Total Movies' FROM sylvester_movies_data;
SELECT * FROM sylvester_movies_data ORDER BY movie_id;

-- Grant permissions for Java access
CREATE USER IF NOT EXISTS 'student1'@'localhost' IDENTIFIED BY 'pass';
GRANT ALL PRIVILEGES ON CSD430.* TO 'student1'@'localhost';
FLUSH PRIVILEGES;

-- Show table structure
DESCRIBE sylvester_movies_data;