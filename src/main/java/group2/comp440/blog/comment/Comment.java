package group2.comp440.blog.comment;

import group2.comp440.blog.user.User;
import group2.comp440.blog.blog.Blog;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity(name = "Comment")
@Table(name = "Comments")
public class Comment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", updatable = false)
    private long id;
    @Column(name = "sentiment", nullable = false)
    private Boolean sentiment;
    @Column(name = "description", nullable = true)
    private String description;

    @Column(name = "date_posted", columnDefinition = "TEXT")
    private String date_posted;

    @ManyToOne(fetch = FetchType.LAZY)
    private Blog blog;

    @ManyToOne(fetch = FetchType.LAZY)
    private User user;

    public Comment() {
    }

    public Comment(String description) {
        this.description = description;
    }

    public Comment(Boolean sentiment, String description, Blog blog, User user, String date_posted) {
        this.sentiment = sentiment;
        this.description = description;
        this.blog = blog;
        this.user = user;
        this.date_posted = date_posted;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Blog getRequest() {
        return blog;
    }

    public void setRequest(Blog blog) {
        this.blog = blog;
    }

    public void setSentiment(Boolean sentiment){
        this.sentiment = sentiment;
    }

    public Boolean getSentiment(){
        return sentiment;
    }

    public void setBlog(Blog blog){
        this.blog = blog;
    }

    public Blog getBlog(){
        return blog;
    }

    public void setDate_Posted(String date_posted) {
        this.date_posted = date_posted;
    }

    public String getDate_Posted() {
        return date_posted;
    }

    public String getSentimentAsString(){
        if (sentiment) return "Positive";
        return "Negative";
    }


}
