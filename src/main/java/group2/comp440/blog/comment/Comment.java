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
    @Column(name = "text", nullable = true)
    private String text;

    @ManyToOne(fetch = FetchType.LAZY)
    private Blog blog;

    @ManyToOne(fetch = FetchType.LAZY)
    private User user;

    public Comment() {
    }

    public Comment(String text) {
        this.text = text;
    }

    public Comment(String text, Blog blog, User user) {
        this.text = text;
        this.blog = blog;
        this.user = user;
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

    public String getComment() {
        return text;
    }

    public void setComment(String comment) {
        this.text = comment;
    }

    public Blog getRequest() {
        return blog;
    }

    public void setRequest(Blog blog) {
        this.blog = blog;
    }

}
