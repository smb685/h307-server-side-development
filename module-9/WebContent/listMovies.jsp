<%@ page import="com.csd430.bean.MovieBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CSD430 - All Movies</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        body {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            min-height: 100vh;
            padding: 40px 20px;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            padding: 30px;
        }
        h1 {
            color: #333;
            margin-bottom: 10px;
            text-align: center;
        }
        .subtitle {
            text-align: center;
            color: #666;
            margin-bottom: 30px;
        }
        .movie-table {
            width: 100%;
            border-collapse: collapse;
            margin: 25px 0;
            font-size: 0.9em;
            box-shadow: 0 0 20px rgba(0,0,0,0.05);
        }
        .movie-table thead tr {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-align: left;
        }
        .movie-table th,
        .movie-table td {
            padding: 12px 15px;
            border-bottom: 1px solid #f0f0f0;
        }
        .movie-table tbody tr {
            border-bottom: 1px solid #f0f0f0;
        }
        .movie-table tbody tr:nth-of-type(even) {
            background-color: #f9f9f9;
        }
        .movie-table tbody tr:last-of-type {
            border-bottom: 2px solid #667eea;
        }
        .movie-table tbody tr:hover {
            background-color: #f1f1f1;
        }
        .rating-badge {
            background: #4CAF50;
            color: white;
            padding: 3px 8px;
            border-radius: 12px;
            font-weight: 600;
            display: inline-block;
        }
        .box-office {
            font-weight: 600;
            color: #2E7D32;
        }
        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
        }
        .stats {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            text-align: center;
            color: #333;
        }
        .no-data {
            text-align: center;
            padding: 40px;
            color: #666;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🎬 All Movies in Database</h1>
        <p class="subtitle">Complete list of records from the <strong>sylvester_movies_data</strong> table</p>

        <%
            MovieBean bean = new MovieBean();
            List<MovieBean> movies = bean.getAllMovies();
            NumberFormat currencyFormat = NumberFormat.getCurrencyInstance();
            currencyFormat.setMaximumFractionDigits(2);
        %>

        <div class="stats">
            Total records: <strong><%= movies.size() %></strong>
        </div>

        <% if (movies.isEmpty()) { %>
            <div class="no-data">
                <h2>No movies found in database.</h2>
                <p>Please add some movies using the "Add New Movie" form.</p>
                <a href="addMovie.jsp" class="back-link">Add New Movie</a>
            </div>
        <% } else { %>
            <table class="movie-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Director</th>
                        <th>Year</th>
                        <th>Genre</th>
                        <th>Rating</th>
                        <th>Duration (min)</th>
                        <th>Box Office (millions)</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (MovieBean movie : movies) {
                    %>
                    <tr>
                        <td><%= movie.getMovieId() %></td>
                        <td><strong><%= movie.getTitle() %></strong></td>
                        <td><%= movie.getDirector() %></td>
                        <td><%= movie.getReleaseYear() %></td>
                        <td><%= movie.getGenre() %></td>
                        <td><span class="rating-badge">⭐ <%= movie.getRating() %></span></td>
                        <td><%= movie.getDuration() %></td>
                        <td class="box-office"><%= currencyFormat.format(movie.getBoxOffice()) %></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        <% } %>

        <div style="text-align: center; margin-top: 20px;">
            <a href="addMovie.jsp" class="back-link">➕ Add New Movie</a> |
            <a href="index.jsp" class="back-link">🏠 Back to Main Menu</a>
        </div>

        <div style="margin-top: 30px; padding: 20px; background: #f5f5f5; border-radius: 10px;">
            <h3 style="color: #333;">📋 Database Information</h3>
            <p>This page displays all records from the <strong>sylvester_movies_data</strong> table. Each movie has <%= movies.size() > 0 ? movies.get(0).getClass().getDeclaredFields().length - 4 : 8 %> fields (excluding the primary key). Data is retrieved using the <code>MovieBean.getAllMovies()</code> method and rendered in an HTML table.</p>
        </div>
    </div>
</body>
</html>