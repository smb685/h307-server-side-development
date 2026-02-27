package com.csd430.bean;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * MovieBean - JavaBean for movie database operations.
 * Provides full CRUD functionality: Create, Read, Update, Delete.
 * 
 * @author [Sylvester Brandon]
 * @version 4.0 (Project Part 4)
 */
public class MovieBean {
    // Fields matching database columns
    private int movieId;
    private String title;
    private String director;
    private int releaseYear;
    private String genre;
    private double rating;
    private int duration;
    private double boxOffice;

    // Database connection details
    private static final String URL = "jdbc:mysql://localhost:3306/CSD430";
    private static final String USER = "student1";
    private static final String PASSWORD = "pass";

    // Table name – IMPORTANT: Replace with your actual first name!
    private static final String TABLE_NAME = "sylvester_movies_data";

    /**
     * Constructor: loads the MySQL JDBC driver.
     */
    public MovieBean() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    // ==================== Getters and Setters ====================
    public int getMovieId() { return movieId; }
    public void setMovieId(int movieId) { this.movieId = movieId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDirector() { return director; }
    public void setDirector(String director) { this.director = director; }

    public int getReleaseYear() { return releaseYear; }
    public void setReleaseYear(int releaseYear) { this.releaseYear = releaseYear; }

    public String getGenre() { return genre; }
    public void setGenre(String genre) { this.genre = genre; }

    public double getRating() { return rating; }
    public void setRating(double rating) { this.rating = rating; }

    public int getDuration() { return duration; }
    public void setDuration(int duration) { this.duration = duration; }

    public double getBoxOffice() { return boxOffice; }
    public void setBoxOffice(double boxOffice) { this.boxOffice = boxOffice; }

    // ==================== Database Methods ====================

    /**
     * Retrieves all movie IDs (key values) from the database.
     * @return List of movie IDs
     */
    public List<Integer> getAllMovieIds() {
        List<Integer> movieIds = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            stmt = conn.createStatement();
            String sql = "SELECT movie_id FROM " + TABLE_NAME + " ORDER BY movie_id";
            rs = stmt.executeQuery(sql);

            while (rs.next()) {
                movieIds.add(rs.getInt("movie_id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        return movieIds;
    }

    /**
     * Retrieves a single movie by its ID.
     * @param id The movie ID to search for
     * @return MovieBean object with the movie's data, or null if not found
     */
    public MovieBean getMovieById(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        MovieBean movie = null;

        try {
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            String sql = "SELECT * FROM " + TABLE_NAME + " WHERE movie_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                movie = new MovieBean();
                movie.setMovieId(rs.getInt("movie_id"));
                movie.setTitle(rs.getString("title"));
                movie.setDirector(rs.getString("director"));
                movie.setReleaseYear(rs.getInt("release_year"));
                movie.setGenre(rs.getString("genre"));
                movie.setRating(rs.getDouble("rating"));
                movie.setDuration(rs.getInt("duration_minutes"));
                movie.setBoxOffice(rs.getDouble("box_office"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, pstmt, rs);
        }
        return movie;
    }

    /**
     * Adds a new movie record to the database.
     * @param movie The MovieBean object containing the new movie's data (ID is auto-generated)
     * @return true if insertion succeeded, false otherwise
     */
    public boolean addMovie(MovieBean movie) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;

        try {
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            String sql = "INSERT INTO " + TABLE_NAME + " (title, director, release_year, genre, rating, duration_minutes, box_office) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, movie.getTitle());
            pstmt.setString(2, movie.getDirector());
            pstmt.setInt(3, movie.getReleaseYear());
            pstmt.setString(4, movie.getGenre());
            pstmt.setDouble(5, movie.getRating());
            pstmt.setInt(6, movie.getDuration());
            pstmt.setDouble(7, movie.getBoxOffice());

            int rows = pstmt.executeUpdate();
            if (rows > 0) success = true;

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, pstmt, null);
        }
        return success;
    }

    /**
     * Retrieves all movies from the database.
     * @return List of MovieBean objects
     */
    public List<MovieBean> getAllMovies() {
        List<MovieBean> movies = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            stmt = conn.createStatement();
            String sql = "SELECT * FROM " + TABLE_NAME + " ORDER BY movie_id";
            rs = stmt.executeQuery(sql);

            while (rs.next()) {
                MovieBean movie = new MovieBean();
                movie.setMovieId(rs.getInt("movie_id"));
                movie.setTitle(rs.getString("title"));
                movie.setDirector(rs.getString("director"));
                movie.setReleaseYear(rs.getInt("release_year"));
                movie.setGenre(rs.getString("genre"));
                movie.setRating(rs.getDouble("rating"));
                movie.setDuration(rs.getInt("duration_minutes"));
                movie.setBoxOffice(rs.getDouble("box_office"));
                movies.add(movie);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }
        return movies;
    }

    /**
     * Updates an existing movie record.
     * @param movie The MovieBean object with updated values (must have a valid movieId)
     * @return true if update succeeded, false otherwise
     */
    public boolean updateMovie(MovieBean movie) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;

        try {
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            String sql = "UPDATE " + TABLE_NAME + " SET title=?, director=?, release_year=?, genre=?, rating=?, duration_minutes=?, box_office=? WHERE movie_id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, movie.getTitle());
            pstmt.setString(2, movie.getDirector());
            pstmt.setInt(3, movie.getReleaseYear());
            pstmt.setString(4, movie.getGenre());
            pstmt.setDouble(5, movie.getRating());
            pstmt.setInt(6, movie.getDuration());
            pstmt.setDouble(7, movie.getBoxOffice());
            pstmt.setInt(8, movie.getMovieId());

            int rows = pstmt.executeUpdate();
            if (rows > 0) success = true;

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, pstmt, null);
        }
        return success;
    }

    /**
     * Deletes a movie record by its ID.
     * @param movieId The ID of the movie to delete
     * @return true if deletion succeeded, false otherwise
     */
    public boolean deleteMovie(int movieId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;

        try {
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            String sql = "DELETE FROM " + TABLE_NAME + " WHERE movie_id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, movieId);
            int rows = pstmt.executeUpdate();
            if (rows > 0) success = true;

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, pstmt, null);
        }
        return success;
    }

    /**
     * Helper method to close database resources.
     */
    private void closeResources(Connection conn, Statement stmt, ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}