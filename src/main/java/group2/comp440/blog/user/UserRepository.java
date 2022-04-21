package group2.comp440.blog.user;

import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {

    User findByEmail(String username);

    User findByUsername(String username);

    boolean existsByUsername(String username);

    boolean existsByEmail(String email);

}