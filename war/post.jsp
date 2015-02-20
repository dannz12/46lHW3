<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>

<head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  <link type="text/css" rel="stylesheet" href="stylesheets/main.css" />
  <title>All posts</title>
</head>
 
<body>
<%
    String guestbookName = request.getParameter("guestbookName");
    if (guestbookName == null) {
        guestbookName = "default";
    }
    pageContext.setAttribute("guestbookName", guestbookName);
    UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
    if (user != null) {
      pageContext.setAttribute("user", user);
%>
  
  <nav>
    <a href="blog.jsp">Home</a>
    <a href="posts.jsp">All Posts</a>
    <a href="about.html">About</a>
    <a href="#">Subscribe</a>
    <a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">Sign out</a>
  </nav>
  <h1>Welcome to our blog! Post something</h1>
  
  <form action="/sign" method="post">
    Title: <input type="text" name="title" /><br />
    Content: 
    <textarea name="content" rows="3" cols="60" ></textarea><br />
    <input type="submit" value="Post Message" />
  </form>
<%
    } else {
%>
  <nav>
    <a href="blog.jsp">Home</a>
    <a href="posts.jsp">All Posts</a>
    <a href="about.html">About</a>
    <a href="subscribe.jsp">Subscribe</a>
    <a href="<%= userService.createLoginURL(request.getRequestURI()) %>">sign in</a>
  </nav>
  <p>You can not post unless you are signed in. Please
  <a href="<%= userService.createLoginURL(request.getRequestURI()) %>">sign in</a>
  or return to the home page.
<%
    }
%>
</body>
</html>