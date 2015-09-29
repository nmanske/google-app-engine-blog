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
	String guestbookName = request.getParameter("guestbookName");

	if (guestbookName == null) {
		guestbookName = "Arvind & Nathan's Blog";
	}

	pageContext.setAttribute("guestbookName", guestbookName);
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
<p>Hello!
<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>
to post a new entry in the blog.</p>
<%
    }
%>

<%
	ObjectifyService.register(blog.Greeting.class);
	List<blog.Greeting> greetings = ObjectifyService.ofy().load().type(blog.Greeting.class).list();
	Collections.sort(greetings);
	
	if (greetings.isEmpty()) {
%>

<p>Guestbook  '${fn:escapeXml(guestbookName)}' has no messages.</p>

<% } else { %>

<p>Messages in Guestbook '${fn:escapeXml(guestbookName)}'.</p>

<%
	for (blog.Greeting greeting : greetings) {
		pageContext.setAttribute("greeting_content", greeting.getContent());
		if (greeting.getUser() == null) {
%>

<p>An anonymous person wrote:</p>

<% } else { 
pageContext.setAttribute("greeting_user", greeting.getUser());
%>

<p><b>${fn:escapeXml(greeting_user.nickname)}</b> wrote:</p>

<% } %>

<blackquote>${fn:escapeXml(greeting_content)}</blockquote>

<%
}
}%>



<form action="/ofysign" method="post">
<div><textarea name="content" rows="3" cols="60"></textarea></div>
<div><input type="submit" value="Post Greeting" /></div>
<input type="hidden" name="guestbookName" value="${fn:escapeXml(guestbookName)}"/>
</form>

  </body>
</html>