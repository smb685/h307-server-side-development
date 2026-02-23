package src;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * MovieBean - JavaBean for movie database operations
 * Updated for Project Part 2 with insert and list all methods.
 */
public class MovieBean {
    // ... (existing fields and connection details)
    private int movieId;
    private String title;
    private String director;
    private int releaseYear;
    private String genre;
    private double rating;
    private int duration;
    private double boxOffice;

    private static final String URL = "jdbc:mysql://localhost:3306/CSD430";
    private static final String USER = "student1";
    private static final String PASSWORD = "pass";

    public MovieBean() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    // Getters and Setters (same as before)
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

    // --- NEW METHOD: Add a movie to the database ---
    public boolean addMovie(MovieBean movie) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;

        try {
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            String sql = "INSERT INTO sylvester_movies_data (title, director, release_year, genre, rating, duration_minutes, box_office) " +
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

    // --- NEW METHOD: Retrieve all movies ---
    public List<MovieBean> getAllMovies() {
        List<MovieBean> movies = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            stmt = conn.createStatement();
            String sql = "SELECT * FROM sylvester_movies_data ORDER BY movie_id";
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

    // ... (existing methods: getAllMovieIds, getMovieById, closeResources)
    public List<Integer> getAllMovieIds() { /* same as before */ }
    public MovieBean getMovieById(int id) { /* same as before */ }
    private void closeResources(Connection conn, Statement stmt, ResultSet rs) { /* same as before */ }
}