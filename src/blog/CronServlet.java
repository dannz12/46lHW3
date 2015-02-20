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
import com.googlecode.objectify.ObjectifyService;

import java.util.List;
import java.util.LinkedList;
import java.util.Date;
import java.util.Properties;



@SuppressWarnings("serial")
public class CronServlet extends HttpServlet {
	static {
        ObjectifyService.register(Post.class);
        ObjectifyService.register(Email.class);
    }
  private static final Logger _logger = Logger.getLogger(CronServlet.class.getName());
  public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
	  _logger.info("Cronhas been executed");
	  System.out.println("test");
    try {
    	 _logger.info("Cronhas been executed3");
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
	      String strCallResult = "New Posts Today"+ "\r\n";
	      for(int i = 0; i < rPosts.size(); i++){
	    	  strCallResult += rPosts.get(i).getTitle()+ "\r\n";
	      }
	      
	      List<Email> emails = ofy().load().type(Email.class).list();
	      _logger.info(emails.get(0).getEmail()+" stuff");
	      Properties props = new Properties();
		  Session session = Session.getDefaultInstance(props, null);
	      for(int i = 0; i < emails.size(); i++){
	    	  MimeMessage outMessage = new MimeMessage(session);
				outMessage.setFrom(new InternetAddress("admin@zelada-test.appspotmail.com"));
				outMessage.addRecipient(MimeMessage.RecipientType.TO, new InternetAddress("dannz512@gmail.com"));
				outMessage.setSubject("Blog Update");
				outMessage.setText(strCallResult);
				Transport.send(outMessage);
	      }
      }
    }
    catch (Exception ex) {
    	 _logger.info(ex.getMessage());
      //Log any exceptions in Cron Job
    }
  }
  
  @Override
  public void doPost(HttpServletRequest req, HttpServletResponse resp) 
  throws ServletException, IOException {
	  System.out.println("test");
    doGet(req, resp);
  }
}