<%@page import="beans.CartItem"%>
<%@page import="java.util.Hashtable"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="dataManager" scope="application" class="model.DataManager"/>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Order</title>
	<link rel="stylesheet" href="/ebookshop/css/eshop.css" type="text/css" />
</head>
<body>
	<jsp:include page="TopMenu.jsp" flush="true"/>
	<jsp:include page="LeftMenu.jsp" flush="true"/>
	<div class="content">
		<h2>Order</h2>
		<jsp:useBean id="customer" class="beans.Customer"/>
		<jsp:setProperty property="*" name="customer"/>
		<%
			Hashtable<String, CartItem> cart = (Hashtable<String, CartItem>) session.getAttribute("shoppingCart");
			long orderID = dataManager.insertOrder(customer, cart);
			if(orderID > 0L){
				session.invalidate();
		%>
		<p class="info">
			Thank you for your purchase.<br/>
			Your Order Number is: <%=orderID%>
		</p>
		<%
			}else{
		%>
		<p class="error">Unexpected error processing the order!</p>
		<%
			}
		%>
	</div>
</body>
</html>