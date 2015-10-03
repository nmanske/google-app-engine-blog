package blog;

import java.io.*;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.*;
import javax.servlet.http.*;
  
public class SendMail extends HttpServlet{
	
	public static ArrayList<SubscribeEntry> listOfSubscribers = new ArrayList<SubscribeEntry>();
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
      ListIterator<SubscribeEntry> subscribers = listOfSubscribers.listIterator();
      
      System.out.println("IMPORTANT TEST\n");
      
      while(subscribers.hasNext()) {
    	  System.out.println(subscribers.next().userEmail);
      }
      
      while(subscribers.hasNext()) {
    	  
    	  SubscribeEntry subscriber = subscribers.next();
          String toAddress = subscriber.getEmail();
          String fromAddress = "nathan.manske@utexas.edu";
          String hostSite = "aksharandvannara.appspot.com";
      
          Properties properties = System.getProperties();
          properties.setProperty("mail.smtp.host", hostSite);	//init mail server
          
          Session session = Session.getDefaultInstance(properties);

          response.setContentType("text/html");
          PrintWriter out = response.getWriter();
     
          try{
             MimeMessage message = new MimeMessage(session);
             message.setFrom(new InternetAddress(fromAddress));
             message.addRecipient(Message.RecipientType.TO, new InternetAddress(toAddress));
             message.setSubject("Update: Nathan and Arvind's Blog");
             message.setText("Hello " + subscriber.getFirstName() + " " + subscriber.getLastName() + ",\n" 
             + "Nathan and Arvind's Blog has updated in the past 24 hours! Check it out in the attached document.");
             
             Transport.send(message);
             String title = "Send Email";
             String res = "Sent message successfully....";
             String docType =
             "<!doctype html public \"-//w3c//dtd html 4.0 " +
             "transitional//en\">\n";
             out.println(docType +
             "<html>\n" +
             "<head><title>" + title + "</title></head>\n" +
             "<body bgcolor=\"#f0f0f0\">\n" +
             "<h1 align=\"center\">" + title + "</h1>\n" +
             "<p align=\"center\">" + res + "</p>\n" +
             "</body></html>");
          }catch (MessagingException mex) {
             mex.printStackTrace();
          }
      }
   }
}