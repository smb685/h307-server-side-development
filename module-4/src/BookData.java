package model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BookData implements Serializable {

private Map<String, List<Book>> groupedBooks;

public BookData() {

    groupedBooks = new HashMap<String, List<Book>>();

    addBook(new Book("The Hobbit", "J.R.R. Tolkien", 1937, "Fantasy"));
    addBook(new Book("Dune", "Frank Herbert", 1965, "Science Fiction"));
    addBook(new Book("1984", "George Orwell", 1949, "Science Fiction"));
    addBook(new Book("Pride and Prejudice", "Jane Austen", 1813, "Classic"));
    addBook(new Book("To Kill a Mockingbird", "Harper Lee", 1960, "Classic"));
}

private void addBook(Book book) {

    if (!groupedBooks.containsKey(book.getGenre())) {
        groupedBooks.put(book.getGenre(), new ArrayList<Book>());
    }

    groupedBooks.get(book.getGenre()).add(book);
}

public Map<String, List<Book>> getGroupedBooks() {
    return groupedBooks;
}


}

