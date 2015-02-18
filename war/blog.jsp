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
<%@ page import="com.googlecode.objectify.ObjectifyService" %>
<%@ page import="blog.Post" %>
<%@ page import="java.util.Collections" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 

<html>

<head>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  <link type="text/css" rel="stylesheet" href="stylesheets/main.css" />
  <title>Blog</title>
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
%>  

  <nav>
    <a href="blog.jsp">Home</a>
    <a href="posts.jsp">All Posts</a>
    <a href="about.html">About</a>
    <a href="#">Subscribe</a>
    <%
    if (user != null) {
      pageContext.setAttribute("user", user);
    %>
    <a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">Sign out</a>
    <%} else {%>
    <a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a><%}%>
  </nav>
  <h1>Welcome to Mockup!</h1>
 
<%
  ObjectifyService.register(Post.class);
	List<Post> posts = ObjectifyService.ofy().load().type(Post.class).list();   
	Collections.sort(posts); 
	
  if (posts.isEmpty()) {
    %><p>No posts. :( </p><%
  } else {
    int i = 0;
    for (Post post : posts) {
      if(i >4){
        break;
      }
      i++;
      pageContext.setAttribute("post_content",post.getContent());
      pageContext.setAttribute("post_user", post.getUser());
      pageContext.setAttribute("title",post.getTitle());
      pageContext.setAttribute("date",post.getDate());
%>
  <h3>${fn:escapeXml(title)}:</h3>
  <span class="author-date">by ${fn:escapeXml(post_user.nickname)} on ${fn:escapeXml(date)}</span>
<%
      String[] text = post.getContent().split("\n");
      for(int a = 0; a<text.length; a++){
        pageContext.setAttribute("text",text[a]);
%>
    <p>${fn:escapeXml(text)}</p><%
      }
    }
  }
%>

	Logged in? <a href="post.jsp" %>Post</a> something! 
  </body>
</html>
