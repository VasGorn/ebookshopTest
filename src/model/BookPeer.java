package model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import beans.Book;

public class BookPeer {
	public static ArrayList<Book> searchBooks(DataManager dataManager, String keyword) {
		ArrayList<Book> books = new ArrayList<Book>();
		Connection connection = dataManager.getConnection();
		if (connection != null) {
			try {
				Statement s = connection.createStatement();
				String sql = "SELECT book_id, title, author, price FROM books" + " WHERE title LIKE '%" + keyword.trim()
						+ "%'" + " OR author LIKE '%" + keyword.trim() + "%'";
				try {
					ResultSet rs = s.executeQuery(sql);
					try {
						while (rs.next()) {
							Book book = new Book();
							book.setId(rs.getString(1));
							book.setTitle(rs.getString(2));
							book.setAuthor(rs.getString(3));
							book.setPrice(rs.getDouble(4));
							books.add(book);
						}
					} finally {
						rs.close();
					}
				} finally {
					s.close();
				}

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				// e.printStackTrace();
				System.out.println("Could not search for books:" + e.getMessage());
			} finally {
				dataManager.putConnection(connection);
			}
		}
		return books;
	}

	public static ArrayList<Book> getBooksByCategory(DataManager dataManager, String categoryId) {
		ArrayList<Book> books = new ArrayList<Book>();
		Connection connection = dataManager.getConnection();
		if (connection != null) {
			try {
				Statement s = connection.createStatement();
				String sql = "SELECT book_id, title, author, price FROM books" + " WHERE category_id=" + categoryId;
				try {
					ResultSet rs = s.executeQuery(sql);
					try {
						while (rs.next()) {
							Book book = new Book();
							book.setId(rs.getString(1));
							book.setTitle(rs.getString(2));
							book.setAuthor(rs.getString(3));
							book.setPrice(rs.getDouble(4));
							books.add(book);
						}
					} finally {
						rs.close();
					}
				} finally {
					s.close();
				}

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				// e.printStackTrace();
				System.out.println("Could not get books:" + e.getMessage());
			} finally {
				dataManager.putConnection(connection);
			}
		}
		return books;
	}

	public static Book getBookById(DataManager dataManager, String bookId) {
		Book book = null;
		Connection connection = dataManager.getConnection();
		if (connection != null) {
			try {
				Statement s = connection.createStatement();
				String sql = "SELECT book_id, title, author, price FROM books" + " WHERE book_id=" + bookId;
				try {
					ResultSet rs = s.executeQuery(sql);
					try {
						while (rs.next()) {
							book = new Book();
							book.setId(rs.getString(1));
							book.setTitle(rs.getString(2));
							book.setAuthor(rs.getString(3));
							book.setPrice(rs.getDouble(4));
						}
					} finally {
						rs.close();
					}
				} finally {
					s.close();
				}

			} catch (SQLException e) {
				// TODO Auto-generated catch block
				// e.printStackTrace();
				System.out.println("Could not get book:" + e.getMessage());
			} finally {
				dataManager.putConnection(connection);
			}
		}
		return book;
	}

}
