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
<link type="text/css" rel="stylesheet" href="/stylesheets/bootstrap.css" />
</head>

  <body>
  <!--  <img src="old_tree.jpg" alt="Old Tree" height="282" width="375"> -->
<%
	String blogName = request.getParameter("blogName");

	if (blogName == null) {
		blogName = "Arvind & Nathan's Blog";
	}

	pageContext.setAttribute("blogName", blogName);
	UserService userService = UserServiceFactory.getUserService();
	User user = userService.getCurrentUser();
	
	if (user != null) {
		pageContext.setAttribute("user", user);
%>
<p>Hello, ${fn:escapeXml(user.nickname)}! (You can
<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>.)</p>
<form action="localhost:8888/new_entry.html">
    <input type="submit" value="Submit New Entry">
</form>
<%
	} else {
%>
<p>Hello Anonymous! You must 
<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">sign in</a>
to post a new blog entry!</p>
<%
    }
%>

<%
	ObjectifyService.register(blog.BlogEntry.class);
	List<blog.BlogEntry> entries = ObjectifyService.ofy().load().type(blog.BlogEntry.class).list();
	Collections.sort(entries);
	
	if (entries.isEmpty()) {
%>

<p>${fn:escapeXml(blogName)} has no blog entries!</p>

<% } else {

	for (blog.BlogEntry entry : entries) {
		pageContext.setAttribute("entry_title", entry.getTitle());
		pageContext.setAttribute("entry_content", entry.getContent());
		pageContext.setAttribute("entry_user", entry.getUser());
		pageContext.setAttribute("entry_date", entry.getDate());
%>
	<div>
	<p><b>Title:</b> ${fn:escapeXml(entry_title)} <br>
	<b>Author:</b> ${fn:escapeXml(entry_user.nickname)} <br>
	<b>Date:</b> ${fn:escapeXml(entry_date)}</p>
	</div>

	<blockquote>${fn:escapeXml(entry_content)}</blockquote>
	<br>
<%
	}
}%>

  </body>
</html>