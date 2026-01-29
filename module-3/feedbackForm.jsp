<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Restaurant Experience Feedback Form</title>
</head>
<body>

<h1>Restaurant Experience Feedback</h1>

<p>
Please complete this form to share your recent dining experience.
All fields help us improve service and food quality.
</p>

<form action="feedbackResult.jsp" method="post">

    <label for="customerName">Customer Name</label><br>
    <input type="text" id="customerName" name="customerName" required><br><br>

    <label for="email">Email Address</label><br>
    <input type="email" id="email" name="email" required><br><br>

    <label for="visitDate">Date of Visit</label><br>
    <input type="date" id="visitDate" name="visitDate" required><br><br>

    <label>Service Rating</label><br>
    <input type="radio" name="serviceRating" value="Excellent" required> Excellent<br>
    <input type="radio" name="serviceRating" value="Good"> Good<br>
    <input type="radio" name="serviceRating" value="Fair"> Fair<br>
    <input type="radio" name="serviceRating" value="Poor"> Poor<br><br>

    <label for="comments">Additional Comments</label><br>
    <textarea id="comments" name="comments" rows="4" cols="40"></textarea><br><br>

    <input type="submit" value="Submit Feedback">

</form>

</body>
</html>
