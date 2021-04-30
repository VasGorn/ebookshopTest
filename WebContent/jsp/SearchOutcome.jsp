<%@page import="java.util.Iterator"%>
<%@page import="beans.Book"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="dataManager" scope="application" class="model.DataManager"/>
<%
	String base = (String) application.getAttribute("base");
%>
<!DOCTYPE html>
<html>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Search Outcome</title>
	<link rel="stylesheet" href="/ebookshop/css/eshop.css" type="text/css" />
</head>
<body>
	<jsp:include page="TopMenu.jsp" flush="true"/>
	<jsp:include page="LeftMenu.jsp" flush="true"/>
	<%
		String keyword = request.getParameter("keyword");
		if(keyword != null && !keyword.trim().equals("")){
	%>
	<div class="content">
		<h2>Search results</h2>
		<table>
			<tr>
				<th>Title</th>
				<th>Author</th>
				<th>Price</th>
				<th>Details</th>
			</tr>
			<%
				ArrayList<Book> books = dataManager.getSearchBookResults(keyword);
				Iterator<Book> iterator = books.iterator();
				while(iterator.hasNext()){
					Book book = (Book) iterator.next();
					String pID = book.getId();
			%>
			<tr>
				<td><%=book.getTitle() %></td>
				<td><%=book.getAuthor() %></td>
				<td><%=book.getPrice() %></td>
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
		}else{
	%>
	<p class="error">Invalid search keyword!</p>
	<%
		}
	%>
</body>
</html>