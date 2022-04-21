package group2.comp440.blog.blog;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.JoinColumn;

import group2.comp440.blog.comment.Comment;
import group2.comp440.blog.tag.Tag;
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

    @Column(name = "date_posted", columnDefinition = "TEXT")
    private String date_posted;

    @ManyToOne(fetch = FetchType.LAZY)
    private User user;

    @ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinTable(name = "blog_tags", joinColumns = @JoinColumn(name = "blog_id", referencedColumnName = "id"), inverseJoinColumns = @JoinColumn(name = "tag_id", referencedColumnName = "id"))
    private Set<Tag> tags = new HashSet<>();

    @OneToMany(mappedBy = "blog", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Comment> comments = new ArrayList<Comment>();

    public Blog() {
    }

    public Blog(String subject, String description, String date_posted, User user) {
        this.subject = subject;
        this.description = description;
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

    public void setDate_Posted(String date_posted) {
        this.date_posted = date_posted;
    }

    public String getDate_Posted() {
        return date_posted;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public User getUser() {
        return user;
    }

    public List<Comment> getComments() {
        return comments;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }

    public void pushBackComment(Comment comment) {
        this.comments.add(comment);
    }

    public Set<Tag> getTags() {
        return tags;
    }

    public void setTags(Set<Tag> tags) {
        this.tags = tags;
    }

    public String getTagsAsString(){
        String s = "";
        for (Tag i : this.tags){
            s += i.getName() + ", ";
        }
        if (this.tags.size() > 0)
            return s.substring(0, s.length()-2);
        return "";
    }

}
