package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Hashtable;

import beans.Book;
import beans.CartItem;
import beans.Category;
import beans.Customer;

public class DataManager {
	private String dbURL = "";
	private String dbUserName = "";
	private String dbPassword = "";

	public String getDbURL() {
		return dbURL;
	}

	public void setDbURL(String dbURL) {
		this.dbURL = dbURL;
	}

	public String getDbUserName() {
		return dbUserName;
	}

	public void setDbUserName(String dbUserName) {
		this.dbUserName = dbUserName;
	}

	public String getDbPassword() {
		return dbPassword;
	}

	public void setDbPassword(String dbPassword) {
		this.dbPassword = dbPassword;
	}

	public Connection getConnection() {
		Connection conn = null;

		try {
			conn = DriverManager.getConnection(getDbURL(), getDbUserName(), getDbPassword());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			// e.printStackTrace();
			System.out.println("Could not connect to DB: " + e.getMessage());
		}
		return conn;
	}

	public void putConnection(Connection conn) {
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				// e.printStackTrace();
			}
		}
	}

	// -------------- Category operation --------------
	public String getCategoryName(String categoryId) {
		Category category = CategoryPeer.getCategoryById(this, categoryId);
		return (category == null) ? null : category.getName();
	}

	public Hashtable<String, String> getCategories() {
		return CategoryPeer.getAllCategories(this);
	}

	public Enumeration<String> getCategoriesIDs() {
		return CategoryPeer.getAllCategories(this).keys();
	}

	// -------------- Book operation --------------
	public ArrayList<Book> getSearchBookResults(String keyword) {
		return BookPeer.searchBooks(this, keyword);
	}

	public ArrayList<Book> getBooksInCategory(String categoryID) {
		return BookPeer.getBooksByCategory(this, categoryID);
	}

	public Book getBookDetails(String bookID) {
		return BookPeer.getBookById(this, bookID);
	}

	// -------------- Order operation --------------
	public long insertOrder(Customer customer, Hashtable<String, CartItem> shoppingCart) {
		long returnValue = 0L;
		long orderId = -1; 
		Connection connection = getConnection();
		if (connection != null) {
			Statement stmt = null;
			try {
				connection.setAutoCommit(false);
				stmt = connection.createStatement();
				try {
					orderId = OrderPeer.insertOrder(stmt, customer);
				
					OrderDetailsPeer.insertOrderDetails(stmt, orderId, shoppingCart);
					try {
						stmt.close();
					} finally {
						stmt = null;
					}
					connection.commit();
					returnValue = orderId;
				} catch (SQLException e) {
					System.out.println("Could not insert order: " + e.getMessage());
					try {
						connection.rollback();
					} catch (SQLException ee) {

					}
				}
			} catch (SQLException e) {
				System.out.println("Could not insert order: " + e.getMessage());
			} finally {
				if (stmt != null) {
					try {
						stmt.close();
					} catch (SQLException e) {
					}
				}
				putConnection(connection);
			}
		}
		return returnValue;
	}
	
	public String getDBVersion() {
		String version = "";
		Connection conn = getConnection();
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT VERSION()");
			
			if(rs.next()) {
				version = rs.getString(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return version;
	}
}
