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

    // Get All Users follwoing
    @Query(nativeQuery = true, value = "select * from users where id IN (select user_following_id from follows where follower_id = ?1)")
    List<User> getAllUsersFollowing(Long user_id);

    // Get All followers
    @Query(nativeQuery = true, value = "select * from users where id IN (select follower_id from follows where user_following_id = ?1)")
    List<User> getAllFollowers(Long user_id);

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

    @Query(nativeQuery = true, value = "SELECT p1.user_id as person1, p2.user_id as person2 FROM ( SELECT user_id, group_concat(hobby_id ORDER BY hobby_id) as hobbies FROM user_hobbies GROUP BY user_id ) p1 JOIN ( SELECT user_id, group_concat(hobby_id ORDER BY hobby_id) as hobbies FROM user_hobbies GROUP BY user_id ) p2 on p2.user_id > p1.user_id and p2.hobbies = p1.hobbies ORDER BY person1, person2")
    List<List<Long>> Query5();

    @Query("SELECT u FROM User u LEFT JOIN Blog b ON u.id = b.user WHERE b.user is null")
    List<User> Query6();

    @Query("SELECT u FROM User u LEFT JOIN Comment c ON u.id = c.user WHERE c.user is null")
    List<User> Query7();

    @Query("SELECT distinct u FROM User u JOIN Comment c ON u.id = c.user WHERE c.sentiment = 0 AND u NOT IN (select c.user from Comment c where c.sentiment = 1)")
    List<User> Query8();

    @Query("SELECT u FROM User u JOIN Blog b ON u.id = b.user JOIN Comment c ON b.id = c.blog WHERE c.sentiment = 1 AND b NOT IN (select c.blog from Comment c where c.sentiment = 0)")
    List<User> Query9();

}