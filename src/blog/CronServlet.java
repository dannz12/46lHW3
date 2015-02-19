package blog;

import java.io.IOException;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;



@SuppressWarnings("serial")
public class CronServlet extends HttpServlet {
  private static final Logger _logger = Logger.getLogger(CronServlet.class.getName());
  public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    try {
      _logger.info("Cron has been executed");
      //the cron job, which sends an email to a list of people
      
      //I'm thinking about adding other servlets mapping to subscribe.jsp and 
      //unsubscribe.jsp, both of which prompt user into entering an email address, 
      //and adding / deleting the text string from a Set 
      //This servlet would then send email to only people on the list
      //It's not very secure but we don't have a lot of time
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