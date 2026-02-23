<%@ page import="com.csd430.bean.MovieBean" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CSD430 - Add New Movie</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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
        .success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
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
        <h1>🎬 Add a New Movie</h1>

        <%
            // Handle form submission
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                // Retrieve form parameters
                String title = request.getParameter("title");
                String director = request.getParameter("director");
                String releaseYearStr = request.getParameter("releaseYear");
                String genre = request.getParameter("genre");
                String ratingStr = request.getParameter("rating");
                String durationStr = request.getParameter("duration");
                String boxOfficeStr = request.getParameter("boxOffice");

                // Validate inputs (simple check)
                if (title == null || title.trim().isEmpty() ||
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
                        // Create a MovieBean object and set values
                        MovieBean newMovie = new MovieBean();
                        newMovie.setTitle(title);
                        newMovie.setDirector(director);
                        newMovie.setReleaseYear(Integer.parseInt(releaseYearStr));
                        newMovie.setGenre(genre);
                        newMovie.setRating(Double.parseDouble(ratingStr));
                        newMovie.setDuration(Integer.parseInt(durationStr));
                        newMovie.setBoxOffice(Double.parseDouble(boxOfficeStr));

                        // Call addMovie method
                        boolean added = newMovie.addMovie(newMovie);

                        if (added) {
                            // Redirect to list page to see all movies
                            response.sendRedirect("listMovies.jsp");
                            return;
                        } else {
        %>
                            <div class="message error">Failed to add movie. Please try again.</div>
        <%
                        }
                    } catch (NumberFormatException e) {
        %>
                        <div class="message error">Invalid number format. Please check year, rating, duration, and box office.</div>
        <%
                    }
                }
            }
        %>

        <!-- Input form -->
        <form method="post" action="addMovie.jsp">
            <div class="form-group">
                <label for="title">Movie Title:</label>
                <input type="text" id="title" name="title" required>
            </div>

            <div class="form-group">
                <label for="director">Director:</label>
                <input type="text" id="director" name="director" required>
            </div>

            <div class="form-group">
                <label for="releaseYear">Release Year (e.g., 2023):</label>
                <input type="number" id="releaseYear" name="releaseYear" min="1900" max="2100" required>
            </div>

            <div class="form-group">
                <label for="genre">Genre:</label>
                <input type="text" id="genre" name="genre" required>
            </div>

            <div class="form-group">
                <label for="rating">Rating (0.0 - 10.0):</label>
                <input type="number" id="rating" name="rating" step="0.1" min="0" max="10" required>
            </div>

            <div class="form-group">
                <label for="duration">Duration (minutes):</label>
                <input type="number" id="duration" name="duration" min="1" required>
            </div>

            <div class="form-group">
                <label for="boxOffice">Box Office (millions, e.g., 250.5):</label>
                <input type="number" id="boxOffice" name="boxOffice" step="0.01" min="0" required>
            </div>

            <button type="submit" class="btn">Add Movie</button>
        </form>

        <a href="index.jsp" class="back-link">← Back to Main Menu</a>
    </div>
</body>
</html>