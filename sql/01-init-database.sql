-- Drop the database if it exists and create a new one
DROP DATABASE IF EXISTS `vartgallery`;
CREATE DATABASE `vartgallery`;
USE `vartgallery`;



-- Table structure for table `artwork`
DROP TABLE IF EXISTS `artwork`;
CREATE TABLE `artwork` (
  `id` int NOT NULL AUTO_INCREMENT,
  `artist_id` int DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` text,
  `image` text,
  `like_count` int DEFAULT '0',
  `view_count` int DEFAULT '0',
  `status` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `buyer_id` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `artist_id` (`artist_id`),
  KEY `buyer_id` (`buyer_id`),
  CONSTRAINT `artwork_ibfk_1` FOREIGN KEY (`artist_id`) REFERENCES `user` (`id`),
  CONSTRAINT `artwork_ibfk_2` FOREIGN KEY (`buyer_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table `artwork`
INSERT INTO `artwork` VALUES (1,2,'Brown Eagle','A woven piece resembling a bird by Aurelia Munoz','brown-eagle.jpg',300,400,'free',0.00,NULL,'2024-07-16 12:54:33','2024-07-21 13:29:48'),(2,2,'Starry Night','A famous painting by Vincent van Gogh','starry-night.jpg',100,500,'available',10000.00,NULL,'2024-07-17 14:32:47','2024-07-21 13:29:48'),(3,10,'Mona Lisa','A portrait painting by Leonardo da Vinci','mona-lisa.jpg',200,1000,'available',20000.00,NULL,'2024-07-17 14:32:47','2024-07-21 13:29:48'),(4,4,'Greek Amphora','A greek amphora for storing wine','amphora.jpg',10,10,'sold',0.00,NULL,'2024-07-17 14:32:47','2024-07-21 13:29:48'),(5,2,'The Persistence of Memory','A surreal painting by Salvador Dali','persistence-of-memory.jpg',150,600,'available',50000.00,NULL,'2024-07-17 19:11:56','2024-07-17 21:46:17'),(6,5,'The Thinker','A bronze sculpture by Auguste Rodin','the-thinker.jpg',120,450,'available',8000.00,NULL,'2024-07-17 19:11:56','2024-07-21 13:29:48'),(7,5,'The Weeping Woman','A painting by Pablo Picasso','weeping-woman.jpg',180,700,'available',9000.00,NULL,'2024-07-17 19:11:56','2024-07-21 13:29:48'),(8,7,'Sunflowers','A painting by Vincent van Gogh','sunflowers.jpg',130,550,'sold',0.00,NULL,'2024-07-17 19:11:56','2024-07-21 13:29:48'),(9,6,'The Birth of Venus','A painting by Sandro Botticelli','birth-of-venus.jpg',210,900,'available',1700.00,NULL,'2024-07-17 19:11:56','2024-07-21 13:29:48'),(10,8,'The Kiss','A sculpture by Constantin Brâncuși','the-kiss.jpg',140,500,'available',40000.00,NULL,'2024-07-17 19:11:56','2024-07-21 13:29:48');



-- Table structure for table `comment`
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `artwork_id` int NOT NULL,
  `user_id` int NOT NULL,
  `content` text NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `artwork_id` (`artwork_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`artwork_id`) REFERENCES `artwork` (`id`),
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- Table structure for table `genre`
DROP TABLE IF EXISTS `genre`;
CREATE TABLE `genre` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table `genre`
INSERT INTO `genre` VALUES (1,'Painting','2024-07-17 17:47:33','2024-07-17 17:47:33'),(2,'Digital Painting','2024-07-17 17:47:33','2024-07-17 17:47:33'),(3,'Sculpture','2024-07-17 17:47:33','2024-07-17 17:47:33'),(4,'Textile','2024-07-17 17:47:33','2024-07-17 17:47:33'),(5,'Photography','2024-07-17 19:04:40','2024-07-17 19:04:40'),(6,'Ceramics','2024-07-17 19:04:40','2024-07-17 19:04:40'),(7,'Mixed Media','2024-07-17 19:04:40','2024-07-17 19:04:40');



-- Table structure for table `join_artist_genre`
DROP TABLE IF EXISTS `join_artist_genre`;
CREATE TABLE `join_artist_genre` (
  `artist_id` int NOT NULL,
  `genre_id` int NOT NULL,
  PRIMARY KEY (`artist_id`,`genre_id`),
  KEY `fk_genre` (`genre_id`),
  CONSTRAINT `fk_artist` FOREIGN KEY (`artist_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_genre` FOREIGN KEY (`genre_id`) REFERENCES `genre` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table `join_artist_genre`
INSERT INTO `join_artist_genre` VALUES (2,1),(4,1),(5,2),(2,3),(6,3),(7,4),(8,5),(9,6),(10,7),(11,7);



-- Table structure for table `join_artwork_genre`
DROP TABLE IF EXISTS `join_artwork_genre`;
CREATE TABLE `join_artwork_genre` (
  `artwork_id` int NOT NULL,
  `genre_id` int NOT NULL,
  PRIMARY KEY (`artwork_id`,`genre_id`),
  KEY `genre_id` (`genre_id`),
  CONSTRAINT `artwork_category_ibfk_1` FOREIGN KEY (`artwork_id`) REFERENCES `artwork` (`id`) ON DELETE CASCADE,
  CONSTRAINT `artwork_category_ibfk_2` FOREIGN KEY (`genre_id`) REFERENCES `genre` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table `join_artwork_genre`
INSERT INTO `join_artwork_genre` VALUES (1,1),(2,1),(3,1),(7,1),(8,1),(1,2),(4,2),(7,2),(8,2),(9,2),(10,2),(2,3),(4,3),(5,3),(6,3),(9,3),(5,4),(3,5),(10,5),(1,6),(6,6),(10,7);



-- Table structure for table `user`
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text,
  `portrait` text,
  `address` text,
  `phone` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table `user`
INSERT INTO `user` VALUES (1,'admin@vartg.com','$2a$12$/pd1TO6ygX7kKLq4BhnPwOC1TBZ61Iu4DF1kzbS7XA3UGHdwmBavS','admin','VAG Super Admin','Admin user for initial setup','placeholder.jpg','123 Art Street, Art City','123-456-7890','2024-07-16 12:54:33','2024-07-21 20:43:27'),(2,'aaron.tan@email.com','$2a$12$/pd1TO6ygX7kKLq4BhnPwOC1TBZ61Iu4DF1kzbS7XA3UGHdwmBavS','artist','Aaron Tan','I am an artist','aaron-tan.jpg','123 Singapore','123','2024-07-16 17:32:45','2024-07-21 20:43:27'),(3,'bruce.smith@email.com','$2a$12$/pd1TO6ygX7kKLq4BhnPwOC1TBZ61Iu4DF1kzbS7XA3UGHdwmBavS','buyer','Bruce Smith','I am a buyer','bruce-smith.jpg','123 America','123','2024-07-16 17:32:45','2024-07-21 20:43:27'),(4,'alice.johnson@email.com','$2a$12$/pd1TO6ygX7kKLq4BhnPwOC1TBZ61Iu4DF1kzbS7XA3UGHdwmBavS','artist','Alice Johnson','Contemporary artist specializing in abstract paintings.','alice-johnson.jpg','101 Art Lane, Art City','321-654-9870','2024-07-21 13:26:01','2024-07-21 20:43:27'),(5,'bob.williams@email.com','$2a$12$/pd1TO6ygX7kKLq4BhnPwOC1TBZ61Iu4DF1kzbS7XA3UGHdwmBavS','artist','Bob Williams','Sculptor known for his modern metal sculptures.','bob-williams.jpg','102 Art Lane, Art City','432-765-0981','2024-07-21 13:26:01','2024-07-21 20:43:27'),(6,'charlotte.indranee@email.com','$2a$12$/pd1TO6ygX7kKLq4BhnPwOC1TBZ61Iu4DF1kzbS7XA3UGHdwmBavS','artist','Charlotte Indranee','Mixed media artist exploring themes of nature.','charlotte-indranee.jpg','103 Art Lane, Art City','543-876-1092','2024-07-21 13:26:01','2024-07-21 20:43:27'),(7,'david.lee@email.com','$2a$12$/pd1TO6ygX7kKLq4BhnPwOC1TBZ61Iu4DF1kzbS7XA3UGHdwmBavS','artist','David Lee','Photographer focusing on urban landscapes.','david-lee.jpg','104 Art Lane, Art City','654-987-2103','2024-07-21 13:26:01','2024-07-21 20:43:27'),(8,'emily.davis@email.com','$2a$12$/pd1TO6ygX7kKLq4BhnPwOC1TBZ61Iu4DF1kzbS7XA3UGHdwmBavS','artist','Emily Davis','Painter with a passion for portraits and still life.','emily-davis.jpg','105 Art Lane, Art City','765-098-3214','2024-07-21 13:26:01','2024-07-21 20:43:27'),(9,'frank.miller@email.com','$2a$12$/pd1TO6ygX7kKLq4BhnPwOC1TBZ61Iu4DF1kzbS7XA3UGHdwmBavS','artist','Frank Miller','Digital artist creating immersive digital art.','frank-miller.jpg','106 Art Lane, Art City','876-109-4325','2024-07-21 13:26:01','2024-07-21 20:43:27'),(10,'grace.wilson@email.com','$2a$12$/pd1TO6ygX7kKLq4BhnPwOC1TBZ61Iu4DF1kzbS7XA3UGHdwmBavS','artist','Grace Wilson','Ceramic artist known for her intricate pottery designs.','grace-wilson.jpg','107 Art Lane, Art City','987-210-5436','2024-07-21 13:26:01','2024-07-21 20:43:27'),(11,'henry.moore@email.com','$2a$12$/pd1TO6ygX7kKLq4BhnPwOC1TBZ61Iu4DF1kzbS7XA3UGHdwmBavS','artist','Henry Moore','Illustrator and graphic designer.','henry-moore.jpg','108 Art Lane, Art City','098-321-6547','2024-07-21 13:26:01','2024-07-21 20:43:27');



-- Table structure for table `user_cart`
DROP TABLE IF EXISTS `user_cart`;
CREATE TABLE `user_cart` (
  `user_id` int NOT NULL,
  `artwork_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`artwork_id`),
  KEY `artwork_id` (`artwork_id`),
  CONSTRAINT `user_cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `user_cart_ibfk_2` FOREIGN KEY (`artwork_id`) REFERENCES `artwork` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- Table structure for table `user_liked_artworks`
DROP TABLE IF EXISTS `user_liked_artworks`;
CREATE TABLE `user_liked_artworks` (
  `user_id` int NOT NULL,
  `artwork_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`artwork_id`),
  KEY `artwork_id` (`artwork_id`),
  CONSTRAINT `user_liked_artworks_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `user_liked_artworks_ibfk_2` FOREIGN KEY (`artwork_id`) REFERENCES `artwork` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;