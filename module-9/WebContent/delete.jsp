<%@ page import="com.csd430.bean.MovieBean" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CSD430 - Delete Movie</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        body {
            background: linear-gradient(135deg, #ff9a9e 0%, #fad0c4 100%);
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
        .message {
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 5px;
            text-align: center;
        }
        .success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .delete-form {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            display: flex;
            flex-wrap: wrap;
            align-items: flex-end;
            gap: 15px;
        }
        .form-group {
            flex: 1 1 300px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: 600;
            color: #555;
        }
        select {
            width: 100%;
            padding: 10px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 16px;
        }
        .btn {
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5253 100%);
            color: white;
            border: none;
            padding: 10px 25px;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            height: 42px;
        }
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(255, 107, 107, 0.3);
        }
        .movie-table {
            width: 100%;
            border-collapse: collapse;
            margin: 25px 0;
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
        .stats {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            text-align: center;
            color: #333;
        }
        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🗑️ Delete a Movie</h1>
        <p class="subtitle">Select a movie to permanently remove from the database</p>

        <%
            // Handle POST request: delete the selected movie
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String movieIdParam = request.getParameter("movieId");
                if (movieIdParam != null && !movieIdParam.trim().isEmpty()) {
                    try {
                        int movieId = Integer.parseInt(movieIdParam);
                        MovieBean bean = new MovieBean();
                        boolean deleted = bean.deleteMovie(movieId);
                        if (deleted) {
                            // Redirect to GET to show updated list and avoid resubmission
                            response.sendRedirect("delete.jsp?deleted=true");
                            return;
                        }
                    } catch (NumberFormatException e) {
                        // ignore, redirect without success message
                        response.sendRedirect("delete.jsp");
                        return;
                    }
                }
                // If invalid, just redirect back
                response.sendRedirect("delete.jsp");
                return;
            }

            // GET request: display data
            String deletedParam = request.getParameter("deleted");
            if (deletedParam != null && deletedParam.equals("true")) {
        %>
                <div class="message success">Movie successfully deleted!</div>
        <%
            }

            MovieBean bean = new MovieBean();
            List<MovieBean> movies = bean.getAllMovies();
            List<Integer> movieIds = bean.getAllMovieIds();
            NumberFormat currencyFormat = NumberFormat.getCurrencyInstance();
            currencyFormat.setMaximumFractionDigits(2);
        %>

        <div class="stats">
            Total movies in database: <strong><%= movies.size() %></strong>
        </div>

        <!-- Delete form -->
        <form method="post" action="delete.jsp" class="delete-form">
            <div class="form-group">
                <label for="movieId">Select movie to delete:</label>
                <select id="movieId" name="movieId" required <%= movies.isEmpty() ? "disabled" : "" %>>
                    <option value="">-- Choose a Movie --</option>
                    <%
                        for (Integer id : movieIds) {
                            out.println("<option value='" + id + "'>Movie ID: " + id + "</option>");
                        }
                    %>
                </select>
            </div>
            <button type="submit" class="btn" <%= movies.isEmpty() ? "disabled" : "" %>>Delete Selected Movie</button>
        </form>

        <!-- Movies table -->
        <h2>Current Movies</h2>
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
                    if (movies.isEmpty()) {
                %>
                    <tr>
                        <td colspan="8" style="text-align: center; padding: 20px;">No movies in database.</td>
                    </tr>
                <%
                    } else {
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
                    }
                %>
            </tbody>
        </table>

        <div style="text-align: center; margin-top: 20px;">
            <a href="index.jsp" class="back-link">🏠 Back to Main Menu</a>
        </div>

        <div style="margin-top: 30px; padding: 20px; background: #f5f5f5; border-radius: 10px;">
            <h3 style="color: #333;">📋 About This Page</h3>
            <p>This page displays all movies from the <strong>sylvester_movies_data</strong> table. Use the dropdown to select a movie ID and click the delete button to permanently remove that record. After deletion, the page updates to show the remaining movies. The table header remains even when no movies are present.</p>
        </div>
    </div>
</body>
</html>