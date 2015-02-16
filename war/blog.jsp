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
   <link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
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
<p>Hello, ${fn:escapeXml(user.nickname)}! (You can
<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>.)</p>
<%
    } else {
%>
<p>Hello!
<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>
to include your name with posts you post.</p>
<%
    }
%>
 
<%
   ObjectifyService.register(Post.class);
	List<Post> posts = ObjectifyService.ofy().load().type(Post.class).list();   
	Collections.sort(posts); 
	
    if (posts.isEmpty()) {
        %>
        <p>No posts</p>
        <%
    } else {
        %>
        <p>Posts:</p>
        <%
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
            <h4>by ${fn:escapeXml(post_user.nickname)} on ${fn:escapeXml(date)}<h4>
            <%
            	String[] text = post.getContent().split("\n");
            	for(int a = 0; a<text.length; a++){
            		 pageContext.setAttribute("text",text[a]);
            		%>
            			<p>${fn:escapeXml(text)}</p>
            		<%
            	}
        }
    }
%>
	<a href="post.jsp" %>Post</a>
	 <br>
 	<a href="posts.jsp" %>Older Posts</a>
 
  </body>
</html>