<%@ page import="com.csd430.bean.MovieBean" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CSD430 Movie Database - Movie Selection</title>
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
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        
        .container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 500px;
            padding: 40px;
            text-align: center;
        }
        
        h1 {
            color: #333;
            margin-bottom: 10px;
            font-size: 28px;
        }
        
        .subtitle {
            color: #666;
            margin-bottom: 30px;
            font-size: 16px;
        }
        
        .form-group {
            margin-bottom: 25px;
            text-align: left;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 600;
        }
        
        select {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 16px;
            background: white;
            cursor: pointer;
            transition: border-color 0.3s;
        }
        
        select:hover, select:focus {
            border-color: #667eea;
            outline: none;
        }
        
        .submit-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 15px 30px;
            font-size: 16px;
            font-weight: 600;
            border-radius: 10px;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
            width: 100%;
        }
        
        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }
        
        .info-box {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            margin-top: 30px;
            text-align: left;
        }
        
        .info-box h3 {
            color: #333;
            margin-bottom: 10px;
            font-size: 18px;
        }
        
        .info-box p {
            color: #666;
            font-size: 14px;
            line-height: 1.6;
        }
        
        .movie-count {
            background: #e3f2fd;
            color: #1976d2;
            padding: 5px 10px;
            border-radius: 5px;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🎬 Movie Database Portal</h1>
        <p class="subtitle">CSD430 Project - Select a movie to view details</p>
        
        <!-- Form for movie selection -->
        <form action="display.jsp" method="GET">
            <div class="form-group">
                <label for="movieId">Select Movie ID:</label>
                <select id="movieId" name="movieId" required>
                    <option value="">-- Choose a Movie --</option>
                    <%
                        // Scriptlet to populate dropdown with movie IDs
                        MovieBean movieBean = new MovieBean();
                        List<Integer> movieIds = movieBean.getAllMovieIds();
                        
                        // Display movie count
                        int totalMovies = movieIds.size();
                        
                        for (Integer id : movieIds) {
                            out.println("<option value='" + id + "'>Movie ID: " + id + "</option>");
                        }
                    %>
                </select>
            </div>
            
            <button type="submit" class="submit-btn">View Movie Details</button>
        </form>
        
        <!-- Information section -->
        <div class="info-box">
            <h3>📊 Database Information</h3>
            <p>This application connects to the CSD430 database and retrieves movie information from the 
               <strong>larry_movies_data</strong> table.</p>
            <p>Total movies in database: <span class="movie-count"><%= totalMovies %> records</span></p>
            <p style="margin-top: 10px; font-size: 12px; color: #888;">
                Each movie record contains 8 fields: ID, Title, Director, Year, Genre, Rating, Duration, and Box Office.
            </p>
        </div>
        
        <!-- Module navigation -->
        <div style="margin-top: 25px; padding-top: 20px; border-top: 1px solid #eee;">
            <p style="color: #888; font-size: 14px;">
                CSD430 Project Module | 
                <a href="display.jsp?movieId=1" style="color: #667eea; text-decoration: none;">View Sample (ID: 1)</a>
            </p>
        </div>
    </div>
</body>
</html>