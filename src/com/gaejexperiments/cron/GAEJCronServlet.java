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

	private static final Logger log = Logger.getLogger(GAEJCronServlet.class.getName());

	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		
		try {
			resp.setContentType("text/HTML");
			log.info("Cron Job is currently running!");
			
			ObjectifyService.register(blog.SubscribeEntry.class);
			List<blog.SubscribeEntry> subscriptionEntries = ObjectifyService.ofy().load().type(blog.SubscribeEntry.class).list();	
			
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