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
 


import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class EmailServlet {
	static {
        ObjectifyService.register(Post.class);
    }
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    	UserService userService = UserServiceFactory.getUserService();
	    User user = userService.getCurrentUser();
	      
	    Email email = new Email(user.getNickname());
	     
	    ofy().save().entity(email).now();  
	
	    resp.sendRedirect("/blog.jsp" );
    }
    

}
