package group2.comp440.blog.blog;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;


import group2.comp440.blog.user.User;

public interface BlogRepository extends JpaRepository<Blog, Long> {

    List<Blog> getAllByUser(User currentUser);

}