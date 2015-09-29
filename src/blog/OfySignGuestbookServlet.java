/* URL: http://nmanske-lab2.appspot.com/ */

package blog;

import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import com.googlecode.objectify.ObjectifyService;
import static com.googlecode.objectify.ObjectifyService.ofy;

public class OfySignGuestbookServlet extends HttpServlet {
		
	static {
		ObjectifyService.register(Greeting.class);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
			UserService userService = UserServiceFactory.getUserService();
			User user = userService.getCurrentUser();
				
			String content = req.getParameter("content");
			
			Greeting greeting = new Greeting(user, content);
			
			ofy().save().entity(greeting).now(); // synchronous			
			
			resp.sendRedirect("/ofyguestbook.jsp");
	}

}
