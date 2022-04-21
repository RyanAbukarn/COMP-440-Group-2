-- Before execute the file, ADD your database name here:
-- The database name should be the same as your database of your user table from step 1
use `projdb`; 

--
-- Table structure for table `department`
--
DROP TABLE IF EXISTS `instructor`;
DROP TABLE IF EXISTS `course`;
DROP TABLE IF EXISTS `department`;
DROP TABLE IF EXISTS `user_hobbies`;
DROP TABLE IF EXISTS `blog_tags`;
DROP TABLE IF EXISTS `comments`;
DROP TABLE IF EXISTS `tags`;
DROP TABLE IF EXISTS `hobbies`;
DROP TABLE IF EXISTS `follows`;
DROP TABLE IF EXISTS `blogs`;
DROP TABLE IF EXISTS `users`;


CREATE TABLE `department` (
  `dept_name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `building` varchar(15) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `budget` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`dept_name`),
  CONSTRAINT `department_chk_1` CHECK ((`budget` > 0))
);
--
-- Dumping data for table `department`
--
INSERT INTO `department` VALUES ('Accounting','Saucon',441840.92),('Astronomy','Taylor',617253.94),('Athletics','Bronfman',734550.70),('Biology','Candlestick',647610.55),('Civil Eng.','Chandler',255041.46),('Comp. Sci.','Lamberton',106378.69),('Cybernetics','Mercer',794541.46),('Elec. Eng.','Main',276527.61),('English','Palmer',611042.66),('Finance','Candlestick',866831.75),('Geology','Palmer',406557.93),('History','Taylor',699140.86),('Languages','Linderman',601283.60),('Marketing','Lambeau',210627.58),('Math','Brodhead',777605.11),('Mech. Eng.','Rauch',520350.65),('Physics','Wrigley',942162.76),('Pol. Sci.','Whitman',573745.09),('Psychology','Thompson',848175.04),('Statistics','Taylor',395051.74);

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `course_id` varchar(8) COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `dept_name` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `credits` decimal(2,0) DEFAULT NULL,
  PRIMARY KEY (`course_id`),
  KEY `dept_name` (`dept_name`),
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`dept_name`) REFERENCES `department` (`dept_name`) ON DELETE SET NULL,
  CONSTRAINT `course_chk_1` CHECK ((`credits` > 0))
);
--
-- Dumping data for table `course`
--
INSERT INTO `course` VALUES ('101','Diffusion and Phase Transformation','Mech. Eng.',4),('105','Image Processing','Astronomy',4),('123','Differential Equations','Mech. Eng.',4),('127','Thermodynamics','Geology',4),('130','Differential Geometry','Physics',4),('133','Antidisestablishmentarianism in Modern America','Biology',5),('137','Manufacturing','Finance',4),('139','Number Theory','English',5),('158','Elastic Structures','Cybernetics',4),('169','Marine Mammals','Elec. Eng.',4),('190','Romantic Literature','Civil Eng.',4),('192','Drama','Languages',5),('195','Numerical Methods','Geology',5),('200','The Music of the Ramones','Accounting',5),('209','International Trade','Cybernetics',5),('224','International Finance','Athletics',4),('227','Elastic Structures','Languages',5),('235','International Trade','Math',4),('236','Design and Analysis of Algorithms','Mech. Eng.',4),('237','Surfing','Cybernetics',4),('238','The Music of Donovan','Mech. Eng.',4),('239','The Music of the Ramones','Physics',5),('241','Biostatistics','Geology',4),('242','Rock and Roll','Marketing',4),('254','Security','Cybernetics',4),('258','Colloid and Surface Chemistry','Math',4),('265','Thermal Physics','Cybernetics',5),('267','Hydraulics','Physics',5),('270','Music of the 90s','Math',5),('272','Geology','Mech. Eng.',4),('274','Corporate Law','Comp. Sci.',5),('275','Romantic Literature','Languages',4),('276','Game Design','Comp. Sci.',5),('278','Greek Tragedy','Statistics',5),('284','Topology','Comp. Sci.',5),('292','Electron Microscopy','English',5),('304','Music 2 New for your Instructor','Finance',5),('313','International Trade','Marketing',7),('318','Geology','Cybernetics',4),('319','World History','Finance',5),('324','Ponzi Schemes','Civil Eng.',4),('328','Composition and Literature','Cybernetics',4),('334','International Trade','Athletics',4),('337','Differential Geometry','Statistics',4),('338','Graph Theory','Psychology',4),('340','Corporate Law','History',4),('341','Quantum Mechanics','Cybernetics',4),('344','Quantum Mechanics','Accounting',5),('345','Race Car Driving','Accounting',5),('348','Compiler Design','Elec. Eng.',4),('349','Networking','Finance',5),('352','Compiler Design','Psychology',5),('353','Operating Systems','Psychology',4),('359','Game Programming','Comp. Sci.',5),('362','Embedded Systems','Finance',5),('366','Computational Biology','English',4),('371','Milton','Finance',4),('376','Cost Accounting','Physics',5),('377','Differential Geometry','Astronomy',5),('391','Virology','Biology',4),('392','Recursive Function Theory','Astronomy',5),('393','Aerodynamics','Languages',4),('394','C  Programming','Athletics',4),('396','C  Programming','Languages',4),('399','RPG Programming','Pol. Sci.',5),('400','Visual BASIC','Psychology',5),('401','Sanitary Engineering','Athletics',5),('403','Immunology','Biology',4),('407','Industrial Organization','Languages',5),('408','Bankruptcy','Accounting',4),('411','Music of the 80s','Mech. Eng.',5),('415','Numerical Methods','Biology',7),('416','Data Mining','Accounting',4),('421','Aquatic Chemistry','Athletics',5),('426','Video Gaming','Finance',4),('436','Stream Processing','Physics',5),('442','Strength of Materials','Athletics',4),('443','Journalism','Physics',5),('445','Biostatistics','Finance',4),('451','Database System Concepts','Pol. Sci.',5),('456','Hebrew','Civil Eng.',4),('457','Systems Software','History',4),('458','The Renaissance','Civil Eng.',5),('461','Physical Chemistry','Math',4),('468','Fractal Geometry','Civil Eng.',5),('476','International Communication','Astronomy',8),('482','FOCAL Programming','Psychology',5),('486','Accounting','Geology',4),('487','Physical Chemistry','History',4),('489','Journalism','Astronomy',5),('493','Music of the 50s','Geology',4),('494','Automobile Mechanics','Pol. Sci.',5),('496','Aquatic Chemistry','Cybernetics',4),('500','Networking','Astronomy',4),('527','Graphics','Finance',4),('539','International Finance','Comp. Sci.',4),('544','Differential Geometry','Statistics',4),('545','International Practicum','History',4),('546','Creative Writing','Mech. Eng.',5),('549','Banking and Finance','Astronomy',4),('558','Environmental Law','Psychology',4),('559','Martian History','Biology',4),('561','The Music of Donovan','Elec. Eng.',5),('571','Plastics','Comp. Sci.',5),('577','The Music of Dave Edmunds','Elec. Eng.',4),('580','The Music of Dave Edmunds','Physics',5),('581','Calculus','Pol. Sci.',5),('582','Marine Mammals','Cybernetics',4),('584','Computability Theory','Comp. Sci.',4),('586','Image Processing','Finance',5),('591','Shakespeare','Pol. Sci.',5),('594','Cognitive Psychology','Finance',4),('598','Number Theory','Accounting',5),('599','Mechanics','Psychology',5),('603','Care and Feeding of Cats','Statistics',4),('604','UNIX System Programmming','Statistics',5),('608','Electron Microscopy','Mech. Eng.',4),('612','Mobile Computing','Physics',4),('618','Thermodynamics','English',5),('626','Multimedia Design','History',5),('628','Existentialism','Accounting',4),('629','Finite Element Analysis','Cybernetics',4),('630','Religion','English',4),('631','Plasma Physics','Elec. Eng.',5),('634','Astronomy','Cybernetics',5),('642','Video Gaming','Psychology',4),('647','Service-Oriented Architectures','Comp. Sci.',5),('656','Groups and Rings','Civil Eng.',5),('659','Geology','Math',5),('663','Geology','Psychology',4),('664','Elastic Structures','English',4),('666','Multivariable Calculus','Accounting',4),('679','The Beatles','Math',4),('680','Electricity and Magnetism','Civil Eng.',4),('681','Medieval Civilization or Lack Thereof','English',4),('692','Cat Herding','Athletics',4),('694','Optics','Math',4),('696','Heat Transfer','Marketing',5),('702','Arabic','Biology',4),('704','Marine Mammals','Geology',5),('716','Medieval Civilization or Lack Thereof','Languages',5),('730','Quantum Mechanics','Elec. Eng.',5),('731','The Music of Donovan','Physics',5),('735','Greek Tragedy','Geology',4),('747','International Practicum','Comp. Sci.',5),('748','Tort Law','Cybernetics',5),('760','How to Groom your Cat','Accounting',4),('761','Existentialism','Athletics',4),('762','The Monkeys','History',5),('769','Logic','Elec. Eng.',5),('770','European History','Pol. Sci.',4),('774','Game Programming','Cybernetics',5),('780','Geology','Psychology',4),('781','Compiler Design','Finance',5),('787','C  Programming','Mech. Eng.',5),('791','Operating Systems','Marketing',4),('792','Image Processing','Accounting',4),('793','Decison Support Systems','Civil Eng.',4),('795','Death and Taxes','Marketing',4),('802','African History','Cybernetics',4),('804','Introduction to Burglary','Cybernetics',5),('805','Composition and Literature','Statistics',5),('808','Organic Chemistry','English',5),('810','Mobile Computing','Geology',4),('814','Compiler Design','Elec. Eng.',4),('818','Environmental Law','Astronomy',5),('820','Assembly Language Programming','Cybernetics',4),('830','Sensor Networks','Astronomy',5),('841','Fractal Geometry','Mech. Eng.',5),('843','Environmental Law','Math',8),('852','World History','Athletics',5),('857','UNIX System Programmming','Geology',5),('858','Sailing','Math',5),('864','Heat Transfer','Geology',4),('867','The IBM 360 Architecture','History',7),('875','Bioinformatics','Cybernetics',4),('877','Composition and Literature','Biology',5),('887','Latin','Mech. Eng.',4),('893','Systems Software','Cybernetics',4),('897','How to Succeed in Business Without Really Trying','Languages',5),('898','Petroleum Engineering','Marketing',5),('902','Existentialism','Finance',4),('919','Computability Theory','Math',4),('922','Microeconomics','Finance',5),('927','Differential Geometry','Cybernetics',5),('947','Real-Time Database Systems','Accounting',4),('949','Japanese','Comp. Sci.',4),('958','Fiction Writing','Mech. Eng.',4),('959','Bacteriology','Physics',5),('960','Tort Law','Civil Eng.',4),('962','Animal Behavior','Psychology',4),('963','Groups and Rings','Languages',5),('966','Sanitary Engineering','History',4),('969','The Monkeys','Astronomy',5),('972','Greek Tragedy','Psychology',5),('974','Astronautics','Accounting',4),('983','Virology','Languages',5),('984','Music of the 50s','History',4),('991','Transaction Processing','Psychology',4),('998','Immunology','Civil Eng.',5);

--
-- Table structure for table `instructor`
--
CREATE TABLE `instructor` (
  `ID` varchar(5) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `dept_name` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `salary` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `dept_name` (`dept_name`),
  CONSTRAINT `instructor_ibfk_1` FOREIGN KEY (`dept_name`) REFERENCES `department` (`dept_name`) ON DELETE SET NULL,
  CONSTRAINT `instructor_chk_1` CHECK ((`salary` > 29000))
);
--
-- Dumping data for table `instructor`
--



INSERT INTO `instructor` VALUES ('14365','Lembr','Accounting',32241.56),('15347','Bawa','Athletics',72140.88),('19368','Wieland','Pol. Sci.',124651.41),('22591','DAgostino','Psychology',59706.49),('25946','Liley','Languages',90891.69),('28097','Kean','English',35023.18),('28400','Atanassov','Statistics',84982.92),('3199','Gustafsson','Elec. Eng.',82534.37),('3335','Bourrier','Comp. Sci.',80797.83),('34175','Bondi','Comp. Sci.',115469.11),('36897','Morris','Marketing',43770.36),('41930','Tung','Athletics',50482.03),('4233','Luo','English',88791.45),('42782','Vicentino','Elec. Eng.',34272.67),('43779','Romero','Astronomy',79070.08),('48507','Lent','Mech. Eng.',107978.47),('48570','Sarkar','Pol. Sci.',87549.80),('50330','Shuming','Physics',108011.81),('63287','Jaekel','Athletics',103146.87),('6569','Mingoz','Finance',105311.38),('65931','Pimenta','Cybernetics',79866.95),('73623','Sullivan','Elec. Eng.',90038.09),('74420','Voronina','Physics',121141.99),('77346','Mahmoud','Geology',99382.59),('79081','Ullman ','Accounting',47307.10),('80759','Queiroz','Biology',45538.32),('81991','Valtchev','Biology',77036.18),('90376','Bietzk','Cybernetics',117836.50),('90643','Choll','Statistics',57807.09),('95709','Sakurai','English',118143.98),('99052','Dale','Cybernetics',93348.83);

CREATE TABLE `tags` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `tags` (`id`, `name`) VALUES (1, 'earth');

INSERT INTO `tags` (`id`, `name`) VALUES (2, 'plant');

INSERT INTO `tags` (`id`, `name`) VALUES (3, 'engineering');

INSERT INTO `tags` (`id`, `name`) VALUES (4, 'PC');

INSERT INTO `tags` (`id`, `name`) VALUES (5, 'Best Buy');

INSERT INTO `tags` (`id`, `name`) VALUES (6, 'USA');

INSERT INTO `tags` (`id`, `name`) VALUES (7, 'State');

INSERT INTO `tags` (`id`, `name`) VALUES (8, 'electronics');

INSERT INTO `tags` (`id`, `name`) VALUES (9, 'geography');

INSERT INTO `tags` (`id`, `name`) VALUES (10, 'vehicles');

INSERT INTO `tags` (`id`, `name`) VALUES (11, 'coding');

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email` text NOT NULL,
  `first_name` text NOT NULL,
  `last_name` text NOT NULL,
  `password` text NOT NULL,
  `username` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO `users` (`id`, `email`, `first_name`, `last_name`, `password`, `username`)
VALUES
	(1, 'r@outlook.com', 'Ryan', 'Abukarn', '$2a$10$Qtvmf6F024oX1PMA7gehG.MzV9yiZmWPgI8YU3UUEERqFcomYJeBe', 'r123');

INSERT INTO `users` (`id`, `email`, `first_name`, `last_name`, `password`, `username`)
VALUES
	(2, 'j@outlook.com', 'Jozsef', 'Feher', '$2a$10$Qtvmf6F024oX1PMA7gehG.MzV9yiZmWPgI8YU3UUEERqFcomYJeBe', 'j123');

INSERT INTO `users` (`id`, `email`, `first_name`, `last_name`, `password`, `username`)
VALUES
	(3, 'b@outlook.com', 'Bruce', 'Wayne', '$2a$10$Qtvmf6F024oX1PMA7gehG.MzV9yiZmWPgI8YU3UUEERqFcomYJeBe', 'b123');
	
	INSERT INTO `users` (`id`, `email`, `first_name`, `last_name`, `password`, `username`)
VALUES
	(4, 'k@outlook.com', 'Kal', 'El', '$2a$10$Qtvmf6F024oX1PMA7gehG.MzV9yiZmWPgI8YU3UUEERqFcomYJeBe', 'k123');
	
	INSERT INTO `users` (`id`, `email`, `first_name`, `last_name`, `password`, `username`)
VALUES
	(5, 'p@outlook.com', 'Peter', 'Parker', '$2a$10$Qtvmf6F024oX1PMA7gehG.MzV9yiZmWPgI8YU3UUEERqFcomYJeBe', 'p123');

  CREATE TABLE `follows` (
  `follower_id` bigint(20) NOT NULL,
  `user_following_id` bigint(20) NOT NULL,
  KEY `FK8605lvonutjrl84m6cq0kenv0` (`user_following_id`),
  KEY `FKqnkw0cwwh6572nyhvdjqlr163` (`follower_id`),
  CONSTRAINT `FK8605lvonutjrl84m6cq0kenv0` FOREIGN KEY (`user_following_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKqnkw0cwwh6572nyhvdjqlr163` FOREIGN KEY (`follower_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO `follows` (`follower_id`, `user_following_id`) VALUES (1,2);
INSERT INTO `follows` (`follower_id`, `user_following_id`) VALUES (3,2);
INSERT INTO `follows` (`follower_id`, `user_following_id`) VALUES (2,1);
INSERT INTO `follows` (`follower_id`, `user_following_id`) VALUES (3,4);
INSERT INTO `follows` (`follower_id`, `user_following_id`) VALUES (4,5);
INSERT INTO `follows` (`follower_id`, `user_following_id`) VALUES (5,4);

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

CREATE TABLE `blog_tags` (
  `blog_id` bigint(20) NOT NULL,
  `tag_id` bigint(20) NOT NULL,
  PRIMARY KEY (`blog_id`,`tag_id`),
  KEY `FK40ssjxev6664mjrw1mrjduxns` (`tag_id`),
  CONSTRAINT `FK40ssjxev6664mjrw1mrjduxns` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`),
  CONSTRAINT `FKknhfjqf24lyrdbfobo3qm09e6` FOREIGN KEY (`blog_id`) REFERENCES `blogs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT INTO `blogs` (`id`,`date_posted`, `description`, `subject`, `user_id`)
VALUES
	(1,'05/01/2022', 'into a perfect storm, the environment, the global economic system and geopolitics are all undergoing rapid, uncontrolled change. In the same way that the climate is in a state of flux, exhibiting erratic behavior before settling into a new norm, ', 'Global warming', 1);

INSERT INTO `blog_tags` (`blog_id`, `tag_id`) VALUES (1, 1);
INSERT INTO `blog_tags` (`blog_id`, `tag_id`) VALUES (1, 2);

	
INSERT INTO `blogs` (`id`,`date_posted`, `description`, `subject`, `user_id`)
VALUES
	(2,'05/01/2022', 'A car (or automobile) is a wheeled motor vehicle used for transportation. Most definitions of cars say that they run primarily on roads, seat one to eight people, have four wheels, and mainly transport people rather than goods.', 'Cars', 2);

INSERT INTO `blog_tags` (`blog_id`, `tag_id`) VALUES (2, 10);
INSERT INTO `blog_tags` (`blog_id`, `tag_id`) VALUES (2, 3);


INSERT INTO `blogs` (`id`,`date_posted`, `description`, `subject`, `user_id`)
VALUES
	(3,'05/01/2022', "An airplane is a flying vehicle that has fixed wings and engines or propellers that thrust it forward through the air. It's most common when you travel long distances to take an airplane", 'Airplane', 3);

INSERT INTO `blog_tags` (`blog_id`, `tag_id`) VALUES (3, 10);
INSERT INTO `blog_tags` (`blog_id`, `tag_id`) VALUES (3, 3);

INSERT INTO `blogs` (`id`,`date_posted`, `description`, `subject`, `user_id`)
VALUES
	(4,'05/01/2022', 'A laptop computer, sometimes called a notebook computer by manufacturers, is a battery- or AC-powered personal computer generally smaller than a briefcase that can easily be transported and conveniently used in temporary spaces such as on airplanes, in libraries, temporary offices, and at meetings.', 'Laptop', 4);

INSERT INTO `blog_tags` (`blog_id`, `tag_id`) VALUES (4, 4);
INSERT INTO `blog_tags` (`blog_id`, `tag_id`) VALUES (4, 5);
INSERT INTO `blog_tags` (`blog_id`, `tag_id`) VALUES (4, 11);


INSERT INTO `blogs` (`id`,`date_posted`, `description`, `subject`, `user_id`)
VALUES
	(5,'05/01/2022', 'Capital: Sacramento. California lies on the Pacific Ocean and is bordered by Mexico and the U.S. states of Oregon, Nevada, and Arizona. It is the largest state in population and the third largest in area, extending about 800 mi (1,300 km) north to south and 250 mi (400 km) east to wes', 'California', 1);


INSERT INTO `blog_tags` (`blog_id`, `tag_id`) VALUES (5, 6);
INSERT INTO `blog_tags` (`blog_id`, `tag_id`) VALUES (5, 7);

INSERT INTO `blogs` (`id`,`date_posted`, `description`, `subject`, `user_id`)
VALUES
	(6,'05/01/2022', 'There are plenty of ways to build credit as a teenager — even if you’re starting from scratch. Secured credit cards, student loans, and becoming an authorized user are just a few ways you can get started when you turn 18.', 'Money under 30', 2);

INSERT INTO `blog_tags` (`blog_id`, `tag_id`) VALUES (6, 5);
INSERT INTO `blog_tags` (`blog_id`, `tag_id`) VALUES (6, 6);

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



INSERT INTO `comments` (`id`, `blog_id`, `user_id`, `date_posted`, `description`, `sentiment`)
VALUES
	(1, 1, 2, '05/01/2022', 'Awesome blog!!', 1);

  INSERT INTO `comments` (`id`, `blog_id`, `user_id`, `date_posted`, `description`, `sentiment`)
VALUES
	(2, 2, 2, '05/01/2022', 'not good blog!!', 0);

  INSERT INTO `comments` (`id`, `blog_id`, `user_id`, `date_posted`, `description`, `sentiment`)
VALUES
	(3, 3, 4, '05/01/2022', 'great blog!!', 1);

  INSERT INTO `comments` (`id`, `blog_id`, `user_id`, `date_posted`, `description`, `sentiment`)
VALUES
	(4, 4, 5, '05/01/2022', 'I hate it!!', 0);

    INSERT INTO `comments` (`id`, `blog_id`, `user_id`, `date_posted`, `description`, `sentiment`)
VALUES
	(5, 5, 5, '05/01/2022', 'Bad', 0);

CREATE TABLE `hobbies` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `hobbies` (`id`, `name`) VALUES (1, 'hiking');

INSERT INTO `hobbies` (`id`, `name`) VALUES (2, 'swimming');

INSERT INTO `hobbies` (`id`, `name`) VALUES (3, 'calligraphy');

INSERT INTO `hobbies` (`id`, `name`) VALUES (4, 'bowling');

INSERT INTO `hobbies` (`id`, `name`) VALUES (5, 'movie');

INSERT INTO `hobbies` (`id`, `name`) VALUES (6, 'cooking');

INSERT INTO `hobbies` (`id`, `name`) VALUES (7, 'dancing');


CREATE TABLE `user_hobbies` (
  `user_id` bigint(20) NOT NULL,
  `hobby_id` bigint(20) NOT NULL,
  PRIMARY KEY (`user_id`,`hobby_id`),
  KEY `FKp0lyrwcjffaldpgw3iinwqbj0` (`hobby_id`),
  CONSTRAINT `FK1aia57pgihndujoa8vm7eoccn` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKp0lyrwcjffaldpgw3iinwqbj0` FOREIGN KEY (`hobby_id`) REFERENCES `hobbies` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `user_hobbies` (`user_id`, `hobby_id`) VALUES (1, 1);

INSERT INTO `user_hobbies` (`user_id`, `hobby_id`) VALUES (2, 1);

INSERT INTO `user_hobbies` (`user_id`, `hobby_id`) VALUES (3, 2);

INSERT INTO `user_hobbies` (`user_id`, `hobby_id`) VALUES (4, 2);

INSERT INTO `user_hobbies` (`user_id`, `hobby_id`) VALUES (5, 4);

INSERT INTO `user_hobbies` (`user_id`, `hobby_id`) VALUES (1, 4);



