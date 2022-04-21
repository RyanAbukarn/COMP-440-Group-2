package group2.comp440.blog.user;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import group2.comp440.blog.blog.Blog;

public interface UserRepository extends JpaRepository<User, Long> {

    User findByEmail(String username);

    User findByUsername(String username);

    boolean existsByUsername(String username);

    boolean existsByEmail(String email);

    // #1
    @Query(nativeQuery = true, value = "select * from users where id IN(select b.user_id from blogs b, blog_tags bt, tags t where b.id=bt.blog_id AND bt.tag_id = t.id AND t.name = ?1 AND b.id NOT IN ( select b1.id from blogs b1, blog_tags bt, tags t where b1.id=bt.blog_id AND bt.tag_id = t.id AND t.name = ?2  ) AND users.id IN	(  select b1.user_id from blogs b1, blog_tags bt, tags t  where b1.id=bt.blog_id  AND bt.tag_id = t.id AND t.name = ?2 ) )")
    List<User> Query1(String X, String Y);
    
    // #2
    @Query("SELECT b FROM Blog b WHERE b.user = ?1 AND b IN (SELECT c.blog from Comment c where c.sentiment = 1)")
    List<Blog> Query2(User user);

    // #3
    @Query(nativeQuery = true, value = "select * from users where id IN (select user_id from blogs group by user_id having count(*) = (select count(user_id) from blogs where date_posted = '05/01/2022' group by user_id order by Count(*) desc limit 1))")
    List<User> Query3();

    // #4
    @Query(nativeQuery = true, value = "select * from users where id IN (select user_following_id from follows where follower_id = ?1 AND user_following_id IN (select user_following_id from follows where follower_id = ?2))")
    List<User> Query4(Long x, Long y);
}