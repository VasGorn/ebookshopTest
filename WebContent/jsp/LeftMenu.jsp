<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Hashtable"%>
<%
String base = (String) application.getAttribute("base");
%>
<jsp:useBean id="dataManager" scope="application"
	class="model.DataManager" />
<div class="menu">
	<div class="box">
		<div class="title">Quick Search</div>
		<p>Book Title/Author:</p>
		<form style="border: 0px solid; padding: 0; margin: 0;">
			<input type="hidden" name="action" value="search" /> 
			<input id="text" type="text" name="keyword" size="15" /> 
			<input id="submit" type="submit" value="Search" />
		</form>
	</div>
	<div class="box">
		<div class="title">Categories</div>
		<%
			Hashtable<String, String> categories = dataManager.getCategories();
			Enumeration<String> categoryIDs = categories.keys();
			while(categoryIDs.hasMoreElements()){
				Object categoryID = categoryIDs.nextElement();
				out.println("<p><a href=" + base + "?action=selectCatalog&id="
						+ categoryID.toString() + ">" + categories.get(categoryID)
						+ "</a></p>");
			}
		%>
	</div>
</div>