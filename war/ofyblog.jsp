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
<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
</head>

  <body>
  <img src="old_tree.jpg" alt="Old Tree">
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
<%
	} else {
%>
<p>Hello anonymous person!
<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>
to post a new entry in the blog.</p>
<%
    }
%>

<%
	ObjectifyService.register(blog.BlogEntry.class);
	List<blog.BlogEntry> entries = ObjectifyService.ofy().load().type(blog.BlogEntry.class).list();
	Collections.sort(entries);
	
	if (entries.isEmpty()) {
%>

<p>${fn:escapeXml(blogName)} has no entries.</p>

<% } else { %>

<p>Messages in ${fn:escapeXml(blogName)}:</p>

<%
	for (blog.BlogEntry entry : entries) {
		pageContext.setAttribute("entry_content", entry.getContent());
		pageContext.setAttribute("entry_user", entry.getUser());
		pageContext.setAttribute("entry_date", entry.getDate());
%>

	<p><b>${fn:escapeXml(entry_user.nickname)}</b> wrote:</p>

	<blackquote>${fn:escapeXml(entry_content)}</blockquote>

<%
	}
}%>



	<form action="/ofysign" method="post">
	<div><textarea name="content" rows="3" cols="60"></textarea></div>
	<div><input type="submit" value="Post Entry" /></div>
	<input type="hidden" name="blogName" value="${fn:escapeXml(blogName)}"/>
	</form>

  </body>
</html>