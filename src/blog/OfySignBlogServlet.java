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

public class OfySignBlogServlet extends HttpServlet {
		
	static {
		ObjectifyService.register(BlogEntry.class);
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
			UserService userService = UserServiceFactory.getUserService();
			User user = userService.getCurrentUser();
				
			String content = req.getParameter("content");
			
			BlogEntry entry = new BlogEntry(user, content);
			
			ofy().save().entity(entry).now(); // synchronous			
			
			resp.sendRedirect("/ofyblog.jsp");
	}

}
