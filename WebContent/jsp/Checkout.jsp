<%@page import="beans.CartItem"%>
<%@page import="java.util.Hashtable"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Check Out</title>
	<link rel="stylesheet" href="/ebookshop/css/eshop.css" type="text/css" />
</head>
<body>
	<jsp:include page="TopMenu.jsp" flush="true"/>
	<jsp:include page="LeftMenu.jsp" flush="true"/>
	<div class="content">
		<h2>CheckOut</h2>
		<%
			Hashtable<String, CartItem> shoppingCart = (Hashtable<String, CartItem>)session.getAttribute("shoppingCart");
			if(shoppingCart != null && !shoppingCart.isEmpty()){
		%>
		<form action="">
			<input type="hidden" name="action" value="orderConfirmation"/>
			<table class="checkout">
				<tr>
					<th colspan="2">Delivery Details</th>
				</tr>
				<tr>
					<td>Contact Name:</td>
					<td><input type="text" name="contactName"/></td>
				</tr>
				<tr>
					<td>Delivery Address:</td>
					<td><input type="text" name="deliveryAddress"/></td>
				</tr>
				<tr>
					<th colspan="2">Credit Card Details</th>
				</tr>
				<tr>
					<td>Name on Credit Cart:</td>
					<td><input type="text" name="ccNumber"/>
				</tr>
				<tr>
					<td>Credit Card Expiry Date:</td>
					<td><input type="text" name="ccExpiryDate"/></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><input type="submit" value="Confirm Order"/></td>
				</tr>
			</table>
		</form>
		<%
			} else {
		%>
		<p class="error">ERROR: You can't check out an empty shopping cart!</p>
		<%
			}
		%>
	</div>
</body>
</html>