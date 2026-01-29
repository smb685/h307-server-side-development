<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<%
    // Retrieve form data using request object
    String customerName = request.getParameter("customerName");
    String email = request.getParameter("email");
    String visitDate = request.getParameter("visitDate");
    String serviceRating = request.getParameter("serviceRating");
    String comments = request.getParameter("comments");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Feedback Submission Results</title>
</head>
<body>

<h1>Feedback Summary</h1>

<p>
The table below displays the information you submitted.
Each field reflects your dining experience.
</p>

<table border="1" cellpadding="8">
    <tr>
        <th>Field</th>
        <th>Value</th>
    </tr>
    <tr>
        <td>Customer Name</td>
        <td><%= customerName %></td>
    </tr>
    <tr>
        <td>Email Address</td>
        <td><%= email %></td>
    </tr>
    <tr>
        <td>Date of Visit</td>
        <td><%= visitDate %></td>
    </tr>
    <tr>
        <td>Service Rating</td>
        <td><%= serviceRating %></td>
    </tr>
    <tr>
        <td>Comments</td>
        <td><%= comments %></td>
    </tr>
</table>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<%
    // Retrieve form data using request object
    String customerName = request.getParameter("customerName");
    String email = request.getParameter("email");
    String visitDate = request.getParameter("visitDate");
    String serviceRating = request.getParameter("serviceRating");
    String comments = request.getParameter("comments");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Feedback Submission Results</title>
</head>
<body>

<h1>Feedback Summary</h1>

<p>
The table below displays the information you submitted.
Each field reflects your dining experience.
</p>

<table border="1" cellpadding="8">
    <tr>
        <th>Field</th>
        <th>Value</th>
    </tr>
    <tr>
        <td>Customer Name</td>
        <td><%= customerName %></td>
    </tr>
    <tr>
        <td>Email Address</td>
        <td><%= email %></td>
    </tr>
    <tr>
        <td>Date of Visit</td>
        <td><%= visitDate %></td>
    </tr>
    <tr>
        <td>Service Rating</td>
        <td><%= serviceRating %></td>
    </tr>
    <tr>
        <td>Comments</td>
        <td><%= comments %></td>
    </tr>
</table>

</body>
</html>
