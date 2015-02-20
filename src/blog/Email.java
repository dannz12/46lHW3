package blog;
import java.util.Date;

import com.google.appengine.api.users.User;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
 
 
@Entity
public class Email implements Comparable<Email> {
    @Id Long id;
    String email;
    private Email() {}
    public Email(String email) {
        this.email = email;
    }
    public String getEmail(){
    	return email;
    }
    @Override
    public int compareTo(Email  other) {
        if (email.equals(other.getEmail())) {
            return 0;
        } 
        return 1;
    }
}