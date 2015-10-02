package blog;

import com.google.appengine.api.users.User;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

@Entity
public class SubscribeEntry {
	@Id Long id;
	User user;
	
	private SubscribeEntry() {}
	
	public SubscribeEntry(User user) {
		this.user = user;
	}
	
	public String getUserName() {
		return user.getNickname();
	}
	
	public String getUserEmail() {
		return user.getEmail();
	}
}
