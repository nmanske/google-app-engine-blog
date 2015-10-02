package com.gaejexperiments.cron;

import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.googlecode.objectify.ObjectifyService;

@SuppressWarnings("serial")
public class GAEJCronServlet extends HttpServlet {

	private static final Logger _logger = Logger.getLogger(GAEJCronServlet.class.getName());

	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		try {
			_logger.info("Cron Job has been executed");
			
			ObjectifyService.register(blog.BlogEntry.class);
			List<blog.BlogEntry> entries = ObjectifyService.ofy().load().type(blog.BlogEntry.class).list();
			Collections.sort(entries);
			
			//Put your logic here
			//BEGIN
			//END
		}
		catch (Exception ex) {
			//Log any exceptions in your Cron Job
		}
	}

	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}