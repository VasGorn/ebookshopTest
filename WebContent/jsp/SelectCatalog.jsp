<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="beans.Book"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<jsp:useBean id="dataManager" scope="application" class="model.DataManager" />
<% String base = (String) application.getAttribute("base"); %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Browse Catalog</title>
	<link rel="stylesheet" href="/ebookshop/css/eshop.css" type="text/css" />
</head>
<body>
	<jsp:include page="TopMenu.jsp" flush="true"/>
	<jsp:include page="LeftMenu.jsp" flush="true"/>
	<%
		String categoryID = request.getParameter("id");
		String categoryName = null;
		if(categoryID != null && !categoryID.trim().equals("")){
			try{
				categoryName = dataManager.getCategoryName(categoryID);
			} catch(NumberFormatException e){}
		}
		if(categoryName != null){
	%>
		<div class="content">
			<h2>Select Catalog</h2>
			<p>Category: <strong><%=categoryName%></strong></p>
			<table>
				<tr>
					<th>Title</th>
					<th>Author</th>
					<th>Price</th>
					<th>Details</th>
				</tr>	
				<%
					ArrayList<Book> books = dataManager.getBooksInCategory(categoryID);
					Iterator<Book> iterator = books.iterator();
					while(iterator.hasNext()){
						Book book = (Book) iterator.next();
						String pID = book.getId();
				%>
				<tr>
					<td><%=book.getTitle()%></td>
					<td><%=book.getAuthor()%></td>
					<td><%=book.getPrice()%></td>
					<td><a class="link1"
						href="<%=base%>?action=bookDetails&bookId=<%=pID%>">
						Details</a></td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
		<%
		}else{%>
		<p class="error">Invalid category!</p><%
		}
		%>
</body>
</html>