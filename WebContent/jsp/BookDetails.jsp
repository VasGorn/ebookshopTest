<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="beans.Book"%>
<jsp:useBean id="dataManager" scope="application" class="model.DataManager"/>
<%
	String base = (String) application.getAttribute("base");
	String imageURL = (String) application.getAttribute("imageURL");
%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Book details</title>
	<link rel="stylesheet" href="/ebookshop/css/eshop.css" type="text/css" />
</head>
	<jsp:include page="TopMenu.jsp" flush="true"/>
	<jsp:include page="LeftMenu.jsp" flush="true"/>
	<div class="content">
		<h2>Book details</h2>
		<%
			try{
				String bookID = request.getParameter("bookId");
				Book book = dataManager.getBookDetails(bookID);
				if (book != null){
		%>
		<table>
			<tr>
				<td>
					<img src="<%=(imageURL + book.getId())%>.gif"/>
				</td>
				<td>
					<b><%=book.getTitle()%></b>	<br>
					<%=book.getAuthor()%> <br>
					Price: $<%=book.getPrice()%>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<a class="link1"
					href = "<%=base%>?action=addItem&bookId=<%=book.getId()%>">
					Add To Card</a>
				</td>
			</tr>
		</table>
		<%
				}else{
					%><p class="error">Book empty!</p><%
				}
			} catch (Exception e){
		%><p class="error">Invalid book identifier!</p><%
			}
		%>
	</div>
</body>
</html>