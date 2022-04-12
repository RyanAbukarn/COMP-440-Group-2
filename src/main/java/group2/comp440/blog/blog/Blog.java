package group2.comp440.blog.blog;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import group2.comp440.blog.user.User;

@Entity(name = "Blog")
@Table(name = "blogs")
public class Blog {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", updatable = false)
    private long id;

    @Column(name = "subject", columnDefinition = "TEXT")
    private String subject;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    
    @Column(name = "tags", columnDefinition = "TEXT")
    private String tags;

    @Column(name = "date_posted", columnDefinition = "TEXT")
    private String date_posted;

    @ManyToOne(fetch = FetchType.LAZY)
    private User user;

    public Blog(){}

    public Blog(String subject, String description, String tags, String date_posted, User user) {
       this.subject = subject;
       this.description = description;
       this.tags = tags;
       this.date_posted = date_posted;
       this.user = user;
    }

    public long getId() {
        return id;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getSubject() {
        return subject;
    }

    public void setDescription(String description) {
       this.description = description;
    }

    public String getDescription() {
        return description;
    }

    public void setTags(String tags){
        this.tags = tags;
    }

    public String getTags(){
        return tags;
    }

    public void setDate_Posted(String date_posted){
        this.date_posted = date_posted;
    }

    public String getDate_Posted(){
        return date_posted;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public User getUser() {
        return user;
    }
}
