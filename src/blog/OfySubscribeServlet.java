package blog;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import com.googlecode.objectify.ObjectifyService;
import static com.googlecode.objectify.ObjectifyService.ofy;

//@WebServlet("/ofysubscribe")
public class OfySubscribeServlet extends HttpServlet{

	static {
		ObjectifyService.register(SubscribeEntry.class);
	}
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
			UserService userService = UserServiceFactory.getUserService();
			User user = userService.getCurrentUser();
			
			if (req.getParameter("subscribeButton") != null) {
				SubscribeEntry entry = new SubscribeEntry(user);
				ofy().save().entity(entry).now();
			}
			else if (req.getParameter("unsubscribeButton") != null) {
				ofy().delete().entity(user).now();
			}
			
			resp.sendRedirect("/ofyblog.jsp");

	}
	
}
