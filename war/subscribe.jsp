<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="blog.BlogEntry"%>
<%@ page import="blog.SubscribeEntry"%>
<%@ page import="blog.SendMail"%>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.googlecode.objectify.*" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
	<header>    
		<link type="text/css" rel="stylesheet" href="/stylesheets/bootstrap.css" />
		<center><h1>Subscription Page</h1></center>	
	</header>
	
	<style>
		body { background: powderblue !important; }
	</style>

	<body>
		<h4>Please enter the following information to subscribe to our blog!</h4> 	
		<form>
			First Name:
			<br>
			<input type="text" name="firstname">
			<br>
			Last Name:
			<br>
			<input type="text" name="lastname">
			<br>
			Email Address:
			<br>
			<input type="text" name="email">
			<br><br>
			<input type="submit" onclick="confirm('Subscribe confirmed!');" value="Subscribe">
<%
	String firstName = request.getParameter("firstname");
	String lastName = request.getParameter("lastname");
	String emailAddress = request.getParameter("email");
	
	if(firstName == null || lastName == null || emailAddress == null){
		
	}
	else {
		SubscribeEntry subscriber = new SubscribeEntry(firstName, lastName, emailAddress);
		SendMail.listOfSubscribers.add(subscriber);
	}
%>
	</body>
	
  	<br><br>
  	<a href="http://nmanske-asundaram-blog.appspot.com/">
		<input type="button" value="Return to Home" />
	</a>
  	
</html>