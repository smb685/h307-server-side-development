package com.csd430.bean;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * MovieBean - JavaBean for movie database operations
 * This class handles database connection and CRUD operations
 * Author: Sylvester
 * Date: 02/08/2026
 */
public class MovieBean {
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
    
    /**
     * Default constructor
     */
    public MovieBean() {
        // Load MySQL JDBC driver
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    
    // Getters and Setters for all properties
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
    
    /**
     * Get all movie IDs for dropdown menu
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
            String sql = "SELECT movie_id FROM larry_movies_data ORDER BY movie_id";
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
     * Get movie details by ID
     * @param id Movie ID to search for
     * @return MovieBean with movie details
     */
    public MovieBean getMovieById(int id) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        MovieBean movie = null;
        
        try {
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            String sql = "SELECT * FROM larry_movies_data WHERE movie_id = ?";
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
     * Close database resources
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