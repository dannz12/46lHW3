package blog;

import static com.googlecode.objectify.ObjectifyService.ofy;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
 
import com.googlecode.objectify.ObjectifyService;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.Date;
 


import java.util.LinkedList;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.List;
 
public class OfySignBlogServlet extends HttpServlet {
	static {
        ObjectifyService.register(Post.class);
        ObjectifyService.register(Email.class);

    }
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();
        
        String Title = req.getParameter("title");
        String content = req.getParameter("content");
        Date date = new Date();
        
       Post greeting = new Post(user, content, Title);
       List<Email> posts = ObjectifyService.ofy().load().type(Email.class).list();  
       for(int i = 0; i < posts.size(); i++){
    	   System.out.println(posts.get(i).getEmail());
       }
       ofy().save().entity(greeting).now();  
 
        resp.sendRedirect("/blog.jsp" );
    }
    
}