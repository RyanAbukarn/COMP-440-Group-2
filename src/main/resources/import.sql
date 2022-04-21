

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dump of table blog_tags
------------------------------------------------------------

CREATE TABLE `blog_tags` (
  `blog_id` bigint(20) NOT NULL,
  `tag_id` bigint(20) NOT NULL,
  PRIMARY KEY (`blog_id`,`tag_id`),
  KEY `FK40ssjxev6664mjrw1mrjduxns` (`tag_id`),
  CONSTRAINT `FK40ssjxev6664mjrw1mrjduxns` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`),
  CONSTRAINT `FKknhfjqf24lyrdbfobo3qm09e6` FOREIGN KEY (`blog_id`) REFERENCES `blogs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- Dump of table blogs
------------------------------------------------------------

CREATE TABLE `blogs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date_posted` text,
  `description` text,
  `subject` text,
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKpg4damav6db6a6fh5peylcni5` (`user_id`),
  CONSTRAINT `FKpg4damav6db6a6fh5peylcni5` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- Dump of table comments
------------------------------------------------------------

CREATE TABLE `comments` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date_posted` text,
  `description` varchar(255) DEFAULT NULL,
  `sentiment` bit(1) NOT NULL,
  `blog_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK9aakob3a7aghrm94k9kmbrjqd` (`blog_id`),
  KEY `FK8omq0tc18jd43bu5tjh6jvraq` (`user_id`),
  CONSTRAINT `FK8omq0tc18jd43bu5tjh6jvraq` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FK9aakob3a7aghrm94k9kmbrjqd` FOREIGN KEY (`blog_id`) REFERENCES `blogs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- Dump of table course
-- ------------------------------------------------------------

CREATE TABLE `course` (
  `course_id` varchar(8) CHARACTER SET utf8mb4 NOT NULL,
  `title` varchar(50) CHARACTER SET utf8mb4 DEFAULT NULL,
  `dept_name` varchar(20) CHARACTER SET utf8mb4 DEFAULT NULL,
  `credits` decimal(2,0) DEFAULT NULL,
  PRIMARY KEY (`course_id`),
  KEY `dept_name` (`dept_name`),
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`dept_name`) REFERENCES `department` (`dept_name`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- Dump of table department
-- ------------------------------------------------------------

CREATE TABLE `department` (
  `dept_name` varchar(20) CHARACTER SET utf8mb4 NOT NULL,
  `building` varchar(15) CHARACTER SET utf8mb4 DEFAULT NULL,
  `budget` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`dept_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- Dump of table follows
-- ------------------------------------------------------------

CREATE TABLE `follows` (
  `follower_id` bigint(20) NOT NULL,
  `user_following_id` bigint(20) NOT NULL,
  KEY `FK8605lvonutjrl84m6cq0kenv0` (`user_following_id`),
  KEY `FKqnkw0cwwh6572nyhvdjqlr163` (`follower_id`),
  CONSTRAINT `FK8605lvonutjrl84m6cq0kenv0` FOREIGN KEY (`user_following_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKqnkw0cwwh6572nyhvdjqlr163` FOREIGN KEY (`follower_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- Dump of table hobbies
-- ------------------------------------------------------------

CREATE TABLE `hobbies` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- Dump of table instructor
-- ------------------------------------------------------------

CREATE TABLE `instructor` (
  `ID` varchar(5) CHARACTER SET utf8mb4 NOT NULL,
  `name` varchar(20) CHARACTER SET utf8mb4 NOT NULL,
  `dept_name` varchar(20) CHARACTER SET utf8mb4 DEFAULT NULL,
  `salary` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `dept_name` (`dept_name`),
  CONSTRAINT `instructor_ibfk_1` FOREIGN KEY (`dept_name`) REFERENCES `department` (`dept_name`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- Dump of table tags
-- ------------------------------------------------------------

CREATE TABLE `tags` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- Dump of table user_hobbies
-- ------------------------------------------------------------

CREATE TABLE `user_hobbies` (
  `user_id` bigint(20) NOT NULL,
  `hobby_id` bigint(20) NOT NULL,
  PRIMARY KEY (`user_id`,`hobby_id`),
  KEY `FKp0lyrwcjffaldpgw3iinwqbj0` (`hobby_id`),
  CONSTRAINT `FK1aia57pgihndujoa8vm7eoccn` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKp0lyrwcjffaldpgw3iinwqbj0` FOREIGN KEY (`hobby_id`) REFERENCES `hobbies` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- Dump of table users
-- ------------------------------------------------------------

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email` text NOT NULL,
  `first_name` text NOT NULL,
  `last_name` text NOT NULL,
  `password` text NOT NULL,
  `username` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


-- SELECT p1.user_id as person1, p2.user_id as person2
-- FROM
-- (
--   SELECT user_id, group_concat(hobby_id ORDER BY hobby_id) as hobbies
--   FROM user_hobbies
--   GROUP BY user_id
-- ) p1
-- JOIN
-- (
--   SELECT user_id, group_concat(hobby_id ORDER BY hobby_id) as hobbies
--   FROM user_hobbies
--   GROUP BY user_id
-- ) p2 on p2.user_id > p1.user_id and p2.hobbies = p1.hobbies
-- ORDER BY person1, person2;


-- SELECT first_name, last_name 
-- FROM users 
-- LEFT JOIN blogs b ON users.id = b.user_id 
-- WHERE b.user_id is null;


-- SELECT first_name, last_name 
-- FROM users 
-- LEFT JOIN comments c ON users.id = c.user_id 
-- WHERE c.user_id is null;

-- SELECT first_name, last_name 
-- FROM users 
-- JOIN comments c ON users.id = c.user_id 
-- WHERE c.sentiment = 1;

-- SELECT first_name, last_name 
-- FROM users 
-- JOIN blogs b ON users.id = b.user_id 
-- JOIN comments c ON b.id = c.blog_id 
-- WHERE c.sentiment = 1;