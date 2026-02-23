<%@ page import="com.csd430.bean.MovieBean" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CSD430 Movie Database - Main Menu</title>
    <style>
        /* ... (keep existing styles) ... */
    </style>
</head>
<body>
    <div class="container">
        <h1>🎬 Movie Database Portal</h1>
        <p class="subtitle">CSD430 Project - Part 2</p>

        <div class="info-box">
            <h3>📊 Database Information</h3>
            <p>This application connects to the CSD430 database and uses the <strong>sylvester_movies_data</strong> table.</p>
            <%
                MovieBean bean = new MovieBean();
                List<Integer> ids = bean.getAllMovieIds();
                int totalMovies = ids.size();
            %>
            <p>Total movies in database: <span class="movie-count"><%= totalMovies %> records</span></p>
            <p style="margin-top: 10px;">Each movie record contains 8 fields: ID, Title, Director, Year, Genre, Rating, Duration, Box Office.</p>
        </div>

        <div style="margin: 30px 0;">
            <h2>Select an operation:</h2>
            <ul style="list-style: none; padding: 0;">
                <li style="margin: 15px 0;">
                    <a href="addMovie.jsp" style="display: inline-block; padding: 12px 24px; background: #4CAF50; color: white; text-decoration: none; border-radius: 5px; width: 200px; text-align: center;">➕ Add New Movie</a>
                </li>
                <li style="margin: 15px 0;">
                    <a href="listMovies.jsp" style="display: inline-block; padding: 12px 24px; background: #2196F3; color: white; text-decoration: none; border-radius: 5px; width: 200px; text-align: center;">📋 View All Movies</a>
                </li>
                <li style="margin: 15px 0;">
                    <a href="index.jsp" style="display: inline-block; padding: 12px 24px; background: #9C27B0; color: white; text-decoration: none; border-radius: 5px; width: 200px; text-align: center;">🔍 View Single Movie (Part 1)</a>
                </li>
            </ul>
        </div>

        <!-- Keep the dropdown form from Part 1 if desired, or remove it -->
        <div style="margin-top: 40px; border-top: 1px solid #eee; padding-top: 20px;">
            <h3>Quick Search (Part 1 functionality)</h3>
            <form action="display.jsp" method="GET">
                <label for="movieId">Select Movie ID:</label>
                <select id="movieId" name="movieId" required>
                    <option value="">-- Choose a Movie --</option>
                    <%
                        for (Integer id : ids) {
                            out.println("<option value='" + id + "'>Movie ID: " + id + "</option>");
                        }
                    %>
                </select>
                <button type="submit" style="margin-top: 10px; padding: 10px 20px; background: #667eea; color: white; border: none; border-radius: 5px;">View Details</button>
            </form>
        </div>
    </div>
</body>
</html>