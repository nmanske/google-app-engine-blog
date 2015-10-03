<%@page import="blog.SubscribeEntry"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.googlecode.objectify.*" %>
<%@ page import="java.util.Collections" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<% final int max_entries = 3; %>

<html>

<head>
	<title>Nathan and Arvind's Blog!</title>
	<link rel="stylesheet" href="/stylesheets/bootstrap.css"/>
	<style>
		body { background: powderblue !important; }
		h3 {font-family: "Comic Sans MS" !important; }
	</style>
</head>

<body>
  
  <center><h1>Welcome to Nathan and Arvind's Blog</h1></center>
  <center><a href="/index.html"><img src="old_tree.jpg" alt="Old Tree" height="141" width="188"></a></center>	
  <p>We created this blog for our first homework assignment
  for EE 461L at the University of Texas. We are both students in the ECE department. We hope
  that you enjoy the blog as much as we enjoyed making it!</p>
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

<form action="/subscribe.jsp" method="post">
	<input type="submit" name="subscribeButton" value="Subscribe" />
</form>

<form action="/unsubscribe.jsp" method="post">
	<input type="submit" name="unsubscribeButton" value="Unsubscribe" />
</form>

<form action="/new_entry.html">
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
	int count = 0;
	for (blog.BlogEntry entry : entries) {
		
		if (count == max_entries || count == entries.size()) 
			break;
		
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
		count++;
	}
	if (entries.size() > 3) { %>
		<form action="/all_entries.jsp">
    		<input type="submit" value="View All Entries">
		</form>
<%	}
}%>

</body>
</html>