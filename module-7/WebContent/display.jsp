<%@ page import="com.csd430.bean.MovieBean" %>
<%@ page import="java.text.NumberFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CSD430 Movie Database - Movie Details</title>
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
            max-width: 900px;
            margin: 0 auto;
            background: white;
            border-radius: 20px;
            box-shadow: 0 25px 50px rgba(0,0,0,0.15);
            overflow: hidden;
        }
        
        .header {
            background: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }
        
        h1 {
            font-size: 32px;
            margin-bottom: 10px;
        }
        
        .back-btn {
            position: absolute;
            top: 30px;
            left: 30px;
            background: rgba(255,255,255,0.2);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            transition: background 0.3s;
        }
        
        .back-btn:hover {
            background: rgba(255,255,255,0.3);
        }
        
        .movie-card {
            padding: 40px;
        }
        
        .movie-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #f0f0f0;
        }
        
        .movie-title {
            font-size: 28px;
            color: #333;
            font-weight: 700;
        }
        
        .movie-rating {
            background: #4CAF50;
            color: white;
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 18px;
        }
        
        .details-table {
            width: 100%;
            border-collapse: collapse;
            margin: 25px 0;
        }
        
        .details-table th {
            background: #f8f9fa;
            padding: 15px;
            text-align: left;
            font-weight: 600;
            color: #555;
            border-bottom: 2px solid #e0e0e0;
            width: 30%;
        }
        
        .details-table td {
            padding: 15px;
            border-bottom: 1px solid #f0f0f0;
            color: #333;
            font-size: 16px;
        }
        
        .details-table tr:hover {
            background: #f9f9f9;
        }
        
        .highlight {
            background: #e3f2fd !important;
            font-weight: 600;
        }
        
        .box-office {
            color: #2E7D32;
            font-weight: 600;
        }
        
        .genre-tag {
            display: inline-block;
            background: #E8F5E9;
            color: #2E7D32;
            padding: 5px 12px;
            border-radius: 15px;
            font-size: 14px;
            font-weight: 600;
        }
        
        .year-badge {
            background: #FFF3E0;
            color: #EF6C00;
            padding: 5px 10px;
            border-radius: 10px;
            font-weight: 600;
        }
        
        .footer {
            text-align: center;
            padding: 20px;
            background: #f8f9fa;
            color: #666;
            font-size: 14px;
            border-top: 1px solid #e0e0e0;
        }
        
        .no-data {
            text-align: center;
            padding: 60px;
            color: #666;
        }
        
        .no-data h2 {
            margin-bottom: 20px;
            color: #f44336;
        }
        
        .duration-badge {
            background: #E8EAF6;
            color: #3F51B5;
            padding: 5px 10px;
            border-radius: 10px;
            font-weight: 600;
        }
        
        @media (max-width: 768px) {
            .movie-header {
                flex-direction: column;
                text-align: center;
                gap: 15px;
            }
            
            .details-table th, .details-table td {
                display: block;
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <a href="index.jsp" class="back-btn">← Back to Selection</a>
            <h1>Movie Details Database</h1>
            <p>CSD430 Project - Full Movie Information Display</p>
        </div>
        
        <%
            // Scriptlet: Get movie ID from request parameter
            String movieIdParam = request.getParameter("movieId");
            MovieBean movie = null;
            String errorMessage = null;
            
            if (movieIdParam != null && !movieIdParam.trim().isEmpty()) {
                try {
                    int movieId = Integer.parseInt(movieIdParam);
                    MovieBean movieBean = new MovieBean();
                    movie = movieBean.getMovieById(movieId);
                    
                    if (movie == null) {
                        errorMessage = "No movie found with ID: " + movieId;
                    }
                } catch (NumberFormatException e) {
                    errorMessage = "Invalid movie ID format. Please enter a valid number.";
                }
            } else {
                errorMessage = "No movie ID provided. Please select a movie from the main page.";
            }
            
            // Create number formatter for currency
            NumberFormat currencyFormat = NumberFormat.getCurrencyInstance();
            currencyFormat.setMaximumFractionDigits(2);
        %>
        
        <% if (movie != null) { %>
            <!-- Display movie details -->
            <div class="movie-card">
                <div class="movie-header">
                    <div class="movie-title"><%= movie.getTitle() %></div>
                    <div class="movie-rating">⭐ <%= String.format("%.1f", movie.getRating()) %>/10</div>
                </div>
                
                <!-- Movie details table -->
                <table class="details-table">
                    <tr>
                        <th>Movie ID</th>
                        <td class="highlight">#<%= movie.getMovieId() %></td>
                    </tr>
                    <tr>
                        <th>Director</th>
                        <td><%= movie.getDirector() %></td>
                    </tr>
                    <tr>
                        <th>Release Year</th>
                        <td><span class="year-badge"><%= movie.getReleaseYear() %></span></td>
                    </tr>
                    <tr>
                        <th>Genre</th>
                        <td><span class="genre-tag"><%= movie.getGenre() %></span></td>
                    </tr>
                    <tr>
                        <th>Duration</th>
                        <td><span class="duration-badge"><%= movie.getDuration() %> minutes</span></td>
                    </tr>
                    <tr>
                        <th>Box Office Revenue</th>
                        <td class="box-office highlight">
                            <%= currencyFormat.format(movie.getBoxOffice()) %> million
                        </td>
                    </tr>
                    <tr>
                        <th>Database Field Count</th>
                        <td>8 fields displayed</td>
                    </tr>
                </table>
                
                <!-- Additional information -->
                <div style="margin-top: 30px; padding: 20px; background: #F5F5F5; border-radius: 10px;">
                    <h3 style="color: #333; margin-bottom: 10px;">📋 Record Information</h3>
                    <p style="color: #666; line-height: 1.6;">
                        This is a complete database record from the <strong>larry_movies_data</strong> table. 
                        The data is retrieved using a JavaBean that connects to the MySQL database (CSD430) 
                        and executes SQL queries. The JSP page uses scriptlets to process the data and 
                        display it in this formatted table.
                    </p>
                </div>
            </div>
        <% } else { %>
            <!-- Error or no data message -->
            <div class="no-data">
                <h2>⚠️ No Movie Data Available</h2>
                <p><%= errorMessage %></p>
                <a href="index.jsp" style="display: inline-block; margin-top: 20px; padding: 12px 24px; 
                   background: #6a11cb; color: white; text-decoration: none; border-radius: 8px;">
                   Return to Movie Selection
                </a>
            </div>
        <% } %>
        
        <div class="footer">
            <p>CSD430 Database Project | Table: larry_movies_data | Total Fields: 8 | JavaBean Implementation</p>
            <p style="margin-top: 5px; font-size: 12px; color: #888;">
                This application demonstrates database connectivity using Java JSP, MySQL, and JavaBeans
            </p>
        </div>
    </div>
</body>
</html>