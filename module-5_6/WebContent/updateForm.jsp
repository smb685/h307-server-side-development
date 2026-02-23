<%@ page import="com.csd430.bean.MovieBean" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CSD430 - Edit Movie</title>
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
            max-width: 600px;
            margin: 0 auto;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            padding: 30px;
        }
        h1 {
            color: #333;
            margin-bottom: 20px;
            text-align: center;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: 600;
            color: #555;
        }
        input, select {
            width: 100%;
            padding: 10px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 16px;
        }
        input:focus {
            border-color: #667eea;
            outline: none;
        }
        input[readonly] {
            background: #f5f5f5;
            color: #666;
            cursor: not-allowed;
        }
        .btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 12px 20px;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
            width: 100%;
            font-weight: 600;
            margin-top: 10px;
        }
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }
        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #667eea;
            text-decoration: none;
        }
        .message {
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 5px;
            text-align: center;
        }
        .error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>✏️ Edit Movie Details</h1>

        <%
            // Handle form submission (POST)
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                // Retrieve form parameters
                String movieIdStr = request.getParameter("movieId");
                String title = request.getParameter("title");
                String director = request.getParameter("director");
                String releaseYearStr = request.getParameter("releaseYear");
                String genre = request.getParameter("genre");
                String ratingStr = request.getParameter("rating");
                String durationStr = request.getParameter("duration");
                String boxOfficeStr = request.getParameter("boxOffice");

                if (movieIdStr == null || movieIdStr.trim().isEmpty() ||
                    title == null || title.trim().isEmpty() ||
                    director == null || director.trim().isEmpty() ||
                    releaseYearStr == null || releaseYearStr.trim().isEmpty() ||
                    genre == null || genre.trim().isEmpty() ||
                    ratingStr == null || ratingStr.trim().isEmpty() ||
                    durationStr == null || durationStr.trim().isEmpty() ||
                    boxOfficeStr == null || boxOfficeStr.trim().isEmpty()) {
        %>
                    <div class="message error">All fields are required. Please fill out the form completely.</div>
        <%
                } else {
                    try {
                        int movieId = Integer.parseInt(movieIdStr);
                        int releaseYear = Integer.parseInt(releaseYearStr);
                        double rating = Double.parseDouble(ratingStr);
                        int duration = Integer.parseInt(durationStr);
                        double boxOffice = Double.parseDouble(boxOfficeStr);

                        MovieBean updatedMovie = new MovieBean();
                        updatedMovie.setMovieId(movieId);
                        updatedMovie.setTitle(title);
                        updatedMovie.setDirector(director);
                        updatedMovie.setReleaseYear(releaseYear);
                        updatedMovie.setGenre(genre);
                        updatedMovie.setRating(rating);
                        updatedMovie.setDuration(duration);
                        updatedMovie.setBoxOffice(boxOffice);

                        boolean updated = updatedMovie.updateMovie(updatedMovie);

                        if (updated) {
                            // Redirect to display page to show updated record
                            response.sendRedirect("display.jsp?movieId=" + movieId);
                            return;
                        } else {
        %>
                            <div class="message error">Update failed. Please try again.</div>
        <%
                        }
                    } catch (NumberFormatException e) {
        %>
                        <div class="message error">Invalid number format. Please check year, rating, duration, and box office.</div>
        <%
                    }
                }
            }

            // For GET request: load the movie to edit
            String movieIdParam = request.getParameter("movieId");
            MovieBean movie = null;
            if (movieIdParam != null && !movieIdParam.trim().isEmpty()) {
                try {
                    int movieId = Integer.parseInt(movieIdParam);
                    MovieBean bean = new MovieBean();
                    movie = bean.getMovieById(movieId);
                } catch (NumberFormatException e) {
                    // handled below
                }
            }

            if (movie == null) {
        %>
                <div class="message error">Invalid or missing movie ID. Please select a valid movie.</div>
                <a href="updateSelect.jsp" class="back-link">← Go back to selection</a>
        <%
            } else {
        %>
                <!-- Editable form, pre-filled with current values -->
                <form method="post" action="updateForm.jsp">
                    <!-- Movie ID (read-only) -->
                    <div class="form-group">
                        <label for="movieId">Movie ID (cannot be changed):</label>
                        <input type="text" id="movieId" name="movieId" value="<%= movie.getMovieId() %>" readonly>
                    </div>

                    <div class="form-group">
                        <label for="title">Title:</label>
                        <input type="text" id="title" name="title" value="<%= movie.getTitle() %>" required>
                    </div>

                    <div class="form-group">
                        <label for="director">Director:</label>
                        <input type="text" id="director" name="director" value="<%= movie.getDirector() %>" required>
                    </div>

                    <div class="form-group">
                        <label for="releaseYear">Release Year:</label>
                        <input type="number" id="releaseYear" name="releaseYear" min="1900" max="2100" value="<%= movie.getReleaseYear() %>" required>
                    </div>

                    <div class="form-group">
                        <label for="genre">Genre:</label>
                        <input type="text" id="genre" name="genre" value="<%= movie.getGenre() %>" required>
                    </div>

                    <div class="form-group">
                        <label for="rating">Rating (0.0 - 10.0):</label>
                        <input type="number" id="rating" name="rating" step="0.1" min="0" max="10" value="<%= movie.getRating() %>" required>
                    </div>

                    <div class="form-group">
                        <label for="duration">Duration (minutes):</label>
                        <input type="number" id="duration" name="duration" min="1" value="<%= movie.getDuration() %>" required>
                    </div>

                    <div class="form-group">
                        <label for="boxOffice">Box Office (millions):</label>
                        <input type="number" id="boxOffice" name="boxOffice" step="0.01" min="0" value="<%= movie.getBoxOffice() %>" required>
                    </div>

                    <button type="submit" class="btn">Update Movie</button>
                </form>
                <a href="updateSelect.jsp" class="back-link">← Choose a different movie</a>
        <%
            }
        %>
    </div>
</body>
</html>