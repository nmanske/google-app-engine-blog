package blog;

import java.util.Date;
import com.google.appengine.api.users.User;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

@Entity
public class Greeting implements Comparable<Greeting> {
		@Id Long id;
		User user;
		String content;
		Date date;
		
		private Greeting() {}
		
		public Greeting(User user, String content) {
			this.user = user;
			this.content = content;
			date = new Date();
		}

		public User getUser() {
			return user;
		}
		
		public String getContent() {
			return content;
		}
		
		@Override
		public int compareTo(Greeting other) {
			if (date.before(other.date)) return 1;
			else if (date.after(other.date)) return -1;
			return 0;
		}
		
		
}