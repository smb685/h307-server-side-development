<%@ page import="com.csd430.bean.MovieBean" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CSD430 - Select Movie to Update</title>
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
        }
        .subtitle {
            color: #666;
            margin-bottom: 30px;
        }
        .form-group {
            margin-bottom: 25px;
            text-align: left;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #555;
        }
        select {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 16px;
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
        }
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }
        .back-link {
            display: block;
            margin-top: 20px;
            color: #667eea;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>✏️ Update a Movie</h1>
        <p class="subtitle">Select the movie you want to edit</p>

        <%
            MovieBean bean = new MovieBean();
            List<Integer> movieIds = bean.getAllMovieIds();
        %>

        <form action="updateForm.jsp" method="GET">
            <div class="form-group">
                <label for="movieId">Movie ID:</label>
                <select id="movieId" name="movieId" required>
                    <option value="">-- Choose a Movie --</option>
                    <%
                        for (Integer id : movieIds) {
                            out.println("<option value='" + id + "'>Movie ID: " + id + "</option>");
                        }
                    %>
                </select>
            </div>
            <button type="submit" class="btn">Edit Movie</button>
        </form>

        <a href="index.jsp" class="back-link">← Back to Main Menu</a>
    </div>
</body>
</html>