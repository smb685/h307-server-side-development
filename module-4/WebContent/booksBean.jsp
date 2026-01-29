<%@ page import="model.BookData" %>
<%@ page import="model.Book" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html> <html> <head> <title>Favorite Books Data</title> <link rel="stylesheet" type="text/css" href="styles.css"> </head> <body> <h1>Favorite Books Data</h1> <p> This page displays book data stored in JavaBeans. The information is grouped by genre and shown in table format. </p> <h2>Field Descriptions</h2> <ul> <li>Title. Name of the book</li> <li>Author. Writer of the book</li> <li>Year. Publication year</li> </ul>

<%
BookData bookData = new BookData();
Map<String, List<Book>> groupedBooks = bookData.getGroupedBooks();

for (String genre : groupedBooks.keySet()) {


%>

<h2>Genre: <%= genre %></h2> <table> <tr> <th>Title</th> <th>Author</th> <th>Year</th> </tr>

<%
for (Book book : groupedBooks.get(genre)) {
%>
<tr>
<td><%= book.getTitle() %></td>
<td><%= book.getAuthor() %></td>
<td><%= book.getYear() %></td>
</tr>
<%
}
%>

</table>

<%
}
%>

</body> </html>