<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.googlecode.objectify.*" %>
<%@ page import="java.util.Collections" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>

<head>
	<title>Arvind & Nathan's Blog!</title>
	<link rel="stylesheet" href="/stylesheets/bootstrap.css"/>
	<style>
		body { background: powderblue !important; }
		h3 {font-family: "Comic Sans MS" !important; }
	</style>
</head>

<body>
  
  <!--  <img src="old_tree.jpg" alt="Old Tree" height="282" width="375"> -->
  	<form action="http://nmanske-asundaram-blog.appspot.com/">
    	<input type="submit" value="Return to Home">
	</form>
<%
	String blogName = request.getParameter("blogName");

	if (blogName == null) {
		blogName = "Arvind & Nathan's Blog";
	}

	pageContext.setAttribute("blogName", blogName);
	UserService userService = UserServiceFactory.getUserService();
	User user = userService.getCurrentUser();
%>

<%
	ObjectifyService.register(blog.BlogEntry.class);
	List<blog.BlogEntry> entries = ObjectifyService.ofy().load().type(blog.BlogEntry.class).list();
	Collections.sort(entries);
	
	for (blog.BlogEntry entry : entries) {
		
		pageContext.setAttribute("entry_title", entry.getTitle());
		pageContext.setAttribute("entry_content", entry.getContent());
		pageContext.setAttribute("entry_user", entry.getUser());
		pageContext.setAttribute("entry_date", entry.getDate());
%>

	<div class="container">
	<div class="row-fluid">
	<div class="span8">
		<p><h3>${fn:escapeXml(entry_title)}</h3>
		<b>Author:</b> ${fn:escapeXml(entry_user.nickname)} <br>
		<b>Date:</b> ${fn:escapeXml(entry_date)}</p>
		<blockquote>${fn:escapeXml(entry_content)}</blockquote>
		<br>
	</div>
	</div>
	</div>

<%
	}
%>

<form action="http://nmanske-asundaram-blog.appspot.com/">
    <input type="submit" value="Return to Home">
</form>

</body>
</html>