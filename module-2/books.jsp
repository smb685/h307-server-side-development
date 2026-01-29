<%@ page import="java.util.*" %>
<%
    // Java data section
    class Book {
        String title;
        String author;
        int year;
        String genre;

        Book(String title, String author, int year, String genre) {
            this.title = title;
            this.author = author;
            this.year = year;
            this.genre = genre;
        }
    }

    List<Book> books = new ArrayList<Book>();

    books.add(new Book("The Hobbit", "J.R.R. Tolkien", 1937, "Fantasy"));
    books.add(new Book("Dune", "Frank Herbert", 1965, "Science Fiction"));
    books.add(new Book("1984", "George Orwell", 1949, "Science Fiction"));
    books.add(new Book("Pride and Prejudice", "Jane Austen", 1813, "Classic"));
    books.add(new Book("To Kill a Mockingbird", "Harper Lee", 1960, "Classic"));

    Map<String, List<Book>> groupedBooks = new HashMap<String, List<Book>>();

    for (Book book : books) {
        if (!groupedBooks.containsKey(book.genre)) {
            groupedBooks.put(book.genre, new ArrayList<Book>());
        }
        groupedBooks.get(book.genre).add(book);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Favorite Books Data Page</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>

<h1>Favorite Books Data</h1>

<p>
This page shows a small data set based on books enjoyed during personal reading time.
The data groups books by genre and lists key details for each book.
</p>

<h2>Field Descriptions</h2>
<ul>
    <li>Title: Name of the book</li>
    <li>Author: Writer of the book</li>
    <li>Year: Original publication year</li>
</ul>

<%
    for (String genre : groupedBooks.keySet()) {
%>

<h2>Genre: <%= genre %></h2>

<table>
    <tr>
        <th>Title</th>
        <th>Author</th>
        <th>Year</th>
    </tr>

    <%
        for (Book book : groupedBooks.get(genre)) {
    %>
    <tr>
        <td><%= book.title %></td>
        <td><%= book.author %></td>
        <td><%= book.year %></td>
    </tr>
    <%
        }
    %>
</table>

<%
    }
%>

</body>
</html>
