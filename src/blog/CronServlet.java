package blog;

import static com.googlecode.objectify.ObjectifyService.ofy;

import java.io.IOException;
import java.util.Date;
import java.util.logging.Logger;

import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import java.util.List;
import java.util.LinkedList;
import java.util.Date;
import java.util.Properties;



@SuppressWarnings("serial")
public class CronServlet extends HttpServlet {
  private static final Logger _logger = Logger.getLogger(CronServlet.class.getName());
  public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    try {
      _logger.info("Cron has been executed");
      List<Post> posts = ofy().load().type(Post.class).list();
      List<Post> rPosts = new LinkedList<Post>();
      Date date = new Date();
      date.setTime(86400000);
      for(int i = 0; i < posts.size(); i++){
    	  if(posts.get(i).getDate().compareTo(date)>0){
    		  rPosts.add(posts.get(i));
    	  }
    	  else{
    		  break;
    	  }
      }
      if(rPosts.size() != 0){
	      String strCallResult = "";;
	      for(int i = 0; i < rPosts.size(); i++){
	    	  strCallResult = "this is a test";
	      }
	      
	      List<Email> emails = ofy().load().type(Email.class).list();
	      Properties props = new Properties();
		  Session session = Session.getDefaultInstance(props, null);
	      for(int i = 0; i < emails.size(); i++){
	    	  MimeMessage outMessage = new MimeMessage(session);
				outMessage.setFrom(new InternetAddress("admin@something-for-class.appspotmail.com"));
				outMessage.addRecipient(MimeMessage.RecipientType.TO, new InternetAddress(emails.get(i).getEmail()));
				outMessage.setSubject("Blog Update");
				outMessage.setText(strCallResult);
				Transport.send(outMessage);
	      }
      }
    }
    catch (Exception ex) {
      //Log any exceptions in Cron Job
    }
  }
  
  @Override
  public void doPost(HttpServletRequest req, HttpServletResponse resp) 
  throws ServletException, IOException {
    doGet(req, resp);
  }
}