package blog;

public class SubscribeEntry {
	String firstName;
	String lastName;
	String userEmail;
	
	private SubscribeEntry() {}
	
	public SubscribeEntry(String firstName, String lastName, String userEmail) {
		this.firstName = firstName;
		this.lastName = lastName;
		this.userEmail = userEmail;
	}
	
	public String getFirstName() {
		return firstName;
	}
	
	public String getLastName() {
		return lastName;
	}
	
	public String getEmail() {
		return userEmail;
	}
}
