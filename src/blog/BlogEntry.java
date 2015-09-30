package blog;

import java.util.Calendar;
import java.util.Date;
import com.google.appengine.api.users.User;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

@Entity
public class BlogEntry implements Comparable<BlogEntry> {
		@Id Long id;
		String title;
		User user;
		String content;
		Date date;

		private BlogEntry() {}
		
		public BlogEntry(String title, User user, String content) {
			this.title = title;
			this.user = user;
			this.content = content;
			date = Calendar.getInstance().getTime();
		}
		
		public String getTitle() {
			return title;
		}

		public User getUser() {
			return user;
		}
		
		public String getContent() {
			return content;
		}
		
		public String getDate() {
			return date.toString();
		}
		
		@Override
		public int compareTo(BlogEntry other) {
			if (date.before(other.date)) return 1;
			else if (date.after(other.date)) return -1;
			return 0;
		}
		
		
}