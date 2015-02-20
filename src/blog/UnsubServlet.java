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
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UnsubServlet extends HttpServlet{
	static {
        ObjectifyService.register(Post.class);
        ObjectifyService.register(Email.class);
    }
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    	
    	UserService userService = UserServiceFactory.getUserService();
	    User user = userService.getCurrentUser();

	    List<Email> emails = ObjectifyService.ofy().load().type(Email.class).list();
	    Email email = null;
	    for(int i = 0; i < emails.size(); i++){
	    	if(emails.get(i).getEmail().equals(user.getEmail())){
	    		email = emails.get(i);
	    	}
	    }
	     
	    ofy().delete().entity(email).now();  
	
	    resp.sendRedirect("/blog.jsp" );
    }

}