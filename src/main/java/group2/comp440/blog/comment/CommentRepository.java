package group2.comp440.blog.comment;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import group2.comp440.blog.user.User;

public interface CommentRepository extends JpaRepository<Comment, Long> {

    List<Comment> getAllByUser(User currentUser);

}