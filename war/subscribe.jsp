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
  <h1>Welcome to our blog! Subscribe</h1>
  
<%
      List<Email> emails = ObjectifyService.ofy().load().type(Email.class).list();  
      boolean inList=false;
      
      for (Email e : emails) {
        if e = user.getNickname(){inList=true;}
      }  
      if(!inList){ 
%>
    <h3>Subscribe</h3>
    <form action="/email" method="sub">
      Email: <input type="email" name="email" /><br />
      <input type="submit" value="Subscribe" />
    </form>
  <%} else {%>
    <h3>Unsubscribe</h3>
    <form action="/email" method="unsub">
      Email: <input type="email" name="email" /><br />
      <input type="submit" value="Unsubscribe" />
    </form>
  <%}%> 
<%
    } else {
%>
  <nav>
    <a href="blog.jsp">Home</a>
    <a href="posts.jsp">All Posts</a>
    <a href="about.html">About</a>
    <a href="#">Subscribe</a>
    <a href="<%= userService.createLoginURL(request.getRequestURI()) %>">sign in</a>
  </nav>
  <p>You can not subscribe unless you are signed in. Please
  <a href="<%= userService.createLoginURL(request.getRequestURI()) %>">sign in</a>
  or return to the home page.
<%
    }
%> 
  
</body>
</html>