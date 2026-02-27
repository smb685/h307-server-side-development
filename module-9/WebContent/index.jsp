<%@ page import="com.csd430.bean.MovieBean" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CSD430 Movie Database - Main Menu</title>
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
            max-width: 800px;
            padding: 40px;
        }
        h1 {
            color: #333;
            margin-bottom: 10px;
            font-size: 32px;
            text-align: center;
        }
        .subtitle {
            color: #666;
            margin-bottom: 30px;
            font-size: 16px;
            text-align: center;
        }
        .info-box {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 30px;
        }
        .info-box h3 {
            color: #333;
            margin-bottom: 10px;
        }
        .info-box p {
            color: #666;
            line-height: 1.6;
        }
        .movie-count {
            background: #e3f2fd;
            color: #1976d2;
            padding: 5px 10px;
            border-radius: 5px;
            font-weight: 600;
        }
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin: 30px 0;
        }
        .menu-item {
            display: block;
            padding: 20px;
            text-align: center;
            color: white;
            text-decoration: none;
            border-radius: 10px;
            font-weight: 600;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .menu-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
        }
        .add { background: linear-gradient(135deg, #4CAF50, #45a049); }
        .view-all { background: linear-gradient(135deg, #2196F3, #1976D2); }
        .update { background: linear-gradient(135deg, #FF9800, #F57C00); }
        .delete { background: linear-gradient(135deg, #f44336, #d32f2f); }
        .view-one { background: linear-gradient(135deg, #9C27B0, #7B1FA2); }
        
        .dropdown-section {
            margin-top: 40px;
            padding-top: 20px;
            border-top: 2px solid #f0f0f0;
        }
        .dropdown-section h3 {
            color: #333;
            margin-bottom: 15px;
        }
        .form-group {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }
        select {
            flex: 1;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 16px;
            min-width: 250px;
        }
        .btn {
            background: #667eea;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 10px;
            cursor: pointer;
            font-weight: 600;
            transition: background 0.3s;
        }
        .btn:hover {
            background: #5a67d8;
        }
        .footer {
            margin-top: 30px;
            text-align: center;
            color: #888;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🎬 CSD430 Movie Database</h1>
        <p class="subtitle">Complete CRUD Application – Project Part 4</p>

        <div class="info-box">
            <h3>📊 Database Information</h3>
            <p>
                This application connects to the <strong>CSD430</strong> database and uses the 
                <strong>yourname_movies_data</strong> table (replace "yourname" with your actual first name). 
                Each movie record contains 8 fields: ID, Title, Director, Year, Genre, Rating, Duration, and Box Office.
            </p>
            <%
                MovieBean bean = new MovieBean();
                List<Integer> ids = bean.getAllMovieIds();
                int totalMovies = ids.size();
            %>
            <p>Total movies in database: <span class="movie-count"><%= totalMovies %> records</span></p>
        </div>

        <div class="menu-grid">
            <a href="addMovie.jsp" class="menu-item add">➕ Add New Movie</a>
            <a href="listMovies.jsp" class="menu-item view-all">📋 View All Movies</a>
            <a href="updateSelect.jsp" class="menu-item update">✏️ Update a Movie</a>
            <a href="delete.jsp" class="menu-item delete">🗑️ Delete a Movie</a>
            <a href="display.jsp?movieId=1" class="menu-item view-one">🔍 View Single Movie (Sample ID 1)</a>
        </div>

        <div class="dropdown-section">
            <h3>🔍 Or select a specific movie ID to view details:</h3>
            <form action="display.jsp" method="GET" class="form-group">
                <select name="movieId" required>
                    <option value="">-- Choose a Movie ID --</option>
                    <%
                        for (Integer id : ids) {
                            out.println("<option value='" + id + "'>Movie ID: " + id + "</option>");
                        }
                    %>
                </select>
                <button type="submit" class="btn">View Details</button>
            </form>
        </div>

        <div class="footer">
            <p>CSD430 Project | Modules 1–4 Complete | JavaBean + JSP + MySQL</p>
        </div>
    </div>
</body>
</html>