package model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import beans.Customer;

public class OrderPeer {
	
	public static long insertOrder(Statement stmt, 
			Customer customer) throws SQLException {
		long orderID = -1L;
		String sql = "INSERT INTO orders(delivery_name,"
				+ " delivery_address, cc_name, cc_number, cc_expiry) values ('"
				+ customer.getContactName() + "', '" 
				+ customer.getDeliveryAddress() + "', '"
				+ customer.getCcName() + "', '" + customer.getCcNumber()
				+ "', '" + customer.getCcExpiryDate() + "') RETURNING order_id";
		System.out.println(sql);
		ResultSet rs = stmt.executeQuery(sql);
		if(rs.next()) {
			orderID = rs.getInt(1);
		}
		return orderID;
	}

}
