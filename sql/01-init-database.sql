CREATE DATABASE  IF NOT EXISTS `vartgallery`
USE `vartgallery`;



DROP TABLE IF EXISTS `artwork`;
CREATE TABLE `artwork` (
  `id` int NOT NULL AUTO_INCREMENT,
  `artist_id` int DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` longtext,
  `image` varchar(255) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `artwork` VALUES (1,2,'Brown Eagle','A woven piece resembling a bird by Aurelia Munoz','brown-eagle.jpg',300,400,'available',0.00,NULL,'2024-07-16 12:54:33','2024-07-28 16:32:59'),(2,2,'Starry Night','A famous painting by Vincent van Gogh','starry-night.jpg',100,500,'sold',10000.00,4,'2024-07-17 14:32:47','2024-08-01 20:24:41'),(3,10,'Mona Lisa','A portrait painting by Leonardo da Vinci','mona-lisa.jpg',200,1000,'sold',20000.00,4,'2024-07-17 14:32:47','2024-08-01 20:24:41'),(4,4,'Greek Amphora','A greek amphora for storing wine','amphora.jpg',10,10,'sold',5000.00,4,'2024-07-17 14:32:47','2024-08-01 20:27:51'),(5,2,'The Persistence of Memory','A surreal painting by Salvador Dali','persistence-of-memory.jpg',150,600,'sold',50000.00,4,'2024-07-17 19:11:56','2024-08-01 20:27:51'),(6,5,'The Thinker','A bronze sculpture by Auguste Rodin','the-thinker.jpg',120,450,'sold',8000.00,4,'2024-07-17 19:11:56','2024-08-01 20:27:51'),(7,5,'The Weeping Woman','A painting by Pablo Picasso','weeping-woman.jpg',180,700,'sold',9000.00,14,'2024-07-17 19:11:56','2024-08-03 09:16:11'),(8,7,'Sunflowers','A painting by Vincent van Gogh','sunflowers.jpg',130,550,'sold',200.00,3,'2024-07-17 19:11:56','2024-08-01 20:28:50'),(9,6,'The Birth of Venus','A painting by Sandro Botticelli','birth-of-venus.jpg',210,900,'available',1700.00,NULL,'2024-07-17 19:11:56','2024-07-28 20:13:35'),(10,8,'The Kiss','A sculpture by Constantin Brâncuși','the-kiss.jpg',140,500,'available',40000.00,NULL,'2024-07-17 19:11:56','2024-07-28 20:13:35'),(12,2,'Whistler\'s Mother','Arrangement in Grey and Black No. 1, best known under its colloquial name Whistler\'s Mother or Portrait of Artist\'s Mother, is a painting in oils on canvas created by the American-born painter James McNeill Whistler in 1871.','1722346635573_whistlers-mother.jpg',0,0,'available',5.00,NULL,'2024-07-30 21:37:22','2024-08-01 20:23:30'),(13,2,'Girl with a Pearl Earring','Girl with a Pearl Earring (Dutch: Meisje met de parel) is an oil painting by Dutch Golden Age painter Johannes Vermeer, dated c. 1665. Going by various names over the centuries, it became known by its present title towards the end of the 20th century after the earring worn by the girl portrayed there. The work has been in the collection of the Mauritshuis in The Hague since 1902 and has been the subject of various literary and cinematic treatments.','1722347526973_girl-pearl-earring.jpg',0,0,'available',10000.50,NULL,'2024-07-30 21:54:23','2024-07-30 21:54:23'),(14,2,'The Last Supper (Leonardo)','The Last Supper is a mural painting by the Italian High Renaissance artist Leonardo da Vinci, dated to c. 1495–1498, housed in the refectory of the Convent of Santa Maria delle Grazie in Milan, Italy.','1722351960085_last-supper.jpg',0,0,'available',15.48,NULL,'2024-07-30 23:06:14','2024-07-30 23:06:14');



DROP TABLE IF EXISTS `exhibition`;
CREATE TABLE `exhibition` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `expo_time_start` datetime DEFAULT NULL,
  `expo_time_end` datetime DEFAULT NULL,
  `expo_space` text,
  `image` text,
  `description` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `exhibition` VALUES (1,'Modern Masters','2024-09-01 10:00:00','2024-09-30 18:00:00','Gallery A','modern_masters.jpg','Join us for an exclusive showcase of works by the most influential modern artists of the 20th and 21st centuries. This exhibition highlights the groundbreaking contributions of artists who have redefined the boundaries of contemporary art.','2024-08-03 01:22:49'),(2,'Art Beyond Borders','2024-10-01 10:00:00','2024-10-31 18:00:00','Gallery B','art_beyond_borders.jpg','Experience the diversity of global artistry in this unique exhibition that brings together works from emerging and established artists across the world. \'Art Beyond Borders\' celebrates the rich cultural heritage and innovative expressions that transcend geographical boundaries.','2024-08-03 01:22:49'),(3,'Impressionist Impressions','2024-11-01 10:00:00','2024-11-30 18:00:00','Gallery C','impressionist_impressions.jpg','Delve into the world of Impressionism with a curated collection of masterpieces that capture the essence of light and color. This exhibition features works by renowned artists who have left an indelible mark on the art world.','2024-08-03 01:22:49'),(4,'Renaissance Reverie','2024-12-01 10:00:00','2024-12-31 18:00:00','Gallery D','renaissance_reverie.jpg','Step back in time to the golden age of art with our \'Renaissance Reverie\' exhibition. Discover the beauty and innovation of this pivotal period through a selection of iconic paintings and sculptures.','2024-08-03 01:22:49'),(5,'Abstract Expressions','2024-08-01 10:00:00','2024-08-31 18:00:00','Gallery E','abstract_expressions.jpg','Explore the world of abstract art with this exhibition that showcases the dynamic and often enigmatic works of abstract expressionists. From bold colors to striking forms, these pieces challenge perceptions and ignite the imagination.','2024-08-03 01:22:49'),(6,'Sculpting the Future','2025-01-01 10:00:00','2025-01-31 18:00:00','Gallery F','sculpting_the_future.jpg','Witness the evolution of sculpture in \'Sculpting the Future\'. This exhibition features contemporary sculptors whose innovative techniques and materials are shaping the future of this timeless art form.','2024-08-03 01:22:49'),(7,'Nature\'s Palette','2024-07-01 10:00:00','2024-07-31 18:00:00','Gallery G','natures_palette.jpg','Immerse yourself in the beauty of the natural world through art. \'Nature\'s Palette\' brings together works that celebrate the vibrant colors, intricate details, and profound majesty of nature.','2024-08-03 01:22:49'),(8,'Digital Dreams','2025-02-01 10:00:00','2025-02-28 18:00:00','Gallery H','digital_dreams.jpg','Enter the realm of digital art in \'Digital Dreams\'. This exhibition highlights the cutting-edge works of artists who are pushing the boundaries of creativity through digital mediums.','2024-08-03 01:22:49'),(9,'Masterpieces in Motion','2024-06-01 10:00:00','2024-06-30 18:00:00','Gallery I','masterpieces_in_motion.jpg','Experience the dynamic energy of kinetic art in \'Masterpieces in Motion\'. This exhibition features interactive installations and sculptures that move and change, engaging viewers in a unique sensory experience.','2024-08-03 01:22:49'),(10,'Echoes of History',NULL,NULL,'Gallery J','echoes_of_history.jpg','Explore the echoes of history through art that reflects on the past and its impact on the present. This exhibition includes works that delve into historical themes, offering a contemplative journey through time.','2024-08-03 01:22:49');



DROP TABLE IF EXISTS `genre`;
CREATE TABLE `genre` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `genre` VALUES (1,'Painting','2024-07-17 17:47:33','2024-07-17 17:47:33'),(2,'Digital Painting','2024-07-17 17:47:33','2024-07-17 17:47:33'),(3,'Sculpture','2024-07-17 17:47:33','2024-07-17 17:47:33'),(4,'Textile','2024-07-17 17:47:33','2024-07-17 17:47:33'),(5,'Photography','2024-07-17 19:04:40','2024-07-17 19:04:40'),(6,'Ceramics','2024-07-17 19:04:40','2024-07-17 19:04:40'),(7,'Mixed Media','2024-07-17 19:04:40','2024-07-17 19:04:40');



DROP TABLE IF EXISTS `join_artist_genre`;
CREATE TABLE `join_artist_genre` (
  `artist_id` int NOT NULL,
  `genre_id` int NOT NULL,
  PRIMARY KEY (`artist_id`,`genre_id`),
  KEY `fk_genre` (`genre_id`),
  CONSTRAINT `fk_artist` FOREIGN KEY (`artist_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_genre` FOREIGN KEY (`genre_id`) REFERENCES `genre` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `join_artist_genre` VALUES (2,1),(4,1),(12,1),(14,1),(5,2),(12,2),(14,2),(2,3),(6,3),(12,3),(14,3),(7,4),(12,4),(8,5),(9,6),(10,7),(11,7);



DROP TABLE IF EXISTS `join_artwork_genre`;
CREATE TABLE `join_artwork_genre` (
  `artwork_id` int NOT NULL,
  `genre_id` int NOT NULL,
  PRIMARY KEY (`artwork_id`,`genre_id`),
  KEY `genre_id` (`genre_id`),
  CONSTRAINT `artwork_category_ibfk_1` FOREIGN KEY (`artwork_id`) REFERENCES `artwork` (`id`) ON DELETE CASCADE,
  CONSTRAINT `artwork_category_ibfk_2` FOREIGN KEY (`genre_id`) REFERENCES `genre` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `join_artwork_genre` VALUES (1,1),(7,1),(8,1),(12,1),(1,2),(4,2),(7,2),(8,2),(9,2),(10,2),(4,3),(6,3),(9,3),(12,3),(10,5),(12,5),(13,5),(1,6),(6,6),(13,6),(10,7),(12,7),(13,7);



DROP TABLE IF EXISTS `pending_artwork`;
CREATE TABLE `pending_artwork` (
  `id` int NOT NULL AUTO_INCREMENT,
  `artist_id` int DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` longtext,
  `image` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `genre_ids` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `artist_id` (`artist_id`),
  CONSTRAINT `pending_artwork_ibfk_1` FOREIGN KEY (`artist_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



DROP TABLE IF EXISTS `pending_user`;
CREATE TABLE `pending_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text,
  `portfolio` text,
  `portrait` text,
  `address` text,
  `phone` varchar(255) DEFAULT NULL,
  `genre_ids` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



DROP TABLE IF EXISTS `transaction`;
CREATE TABLE `transaction` (
  `id` int NOT NULL AUTO_INCREMENT,
  `transaction_id` varchar(255) NOT NULL,
  `user_id` int NOT NULL,
  `artwork_id` int NOT NULL,
  `transaction_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `amount` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `artwork_id` (`artwork_id`),
  CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `transaction_ibfk_2` FOREIGN KEY (`artwork_id`) REFERENCES `artwork` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `transaction` VALUES (1,'TRX-29bdbe42-d81f-47b8-88dc-0a6548bb37d2',4,2,'2024-08-01 20:24:41',10000.00),(2,'TRX-29bdbe42-d81f-47b8-88dc-0a6548bb37d2',4,3,'2024-08-01 20:24:41',20000.00),(3,'TRX-39224cda-90d8-4cd6-a0ab-1e416dbccf77',4,4,'2024-08-01 20:27:51',5000.00),(4,'TRX-39224cda-90d8-4cd6-a0ab-1e416dbccf77',4,5,'2024-08-01 20:27:51',50000.00),(5,'TRX-39224cda-90d8-4cd6-a0ab-1e416dbccf77',4,6,'2024-08-01 20:27:51',8000.00),(6,'TRX-ebecaede-1ba6-492e-962e-37d33d5d71ed',3,8,'2024-08-01 20:28:50',200.00),(7,'TRX-ce7ce5dd-6681-4dea-8afc-4cbf2d602975',14,7,'2024-08-03 09:16:11',9000.00);



DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `portrait` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `user` VALUES (1,'admin@vartg.com','$2a$12$VMxSJ8bFs7Tfq1B1Eyan1u9r8B4NI/4hUj9JncHWCxL/aTMqIZd96','admin','VAG Super Admin','Admin user for initial setup','placeholder.jpg','123 Art Street, Art City','123-456-7890','2024-07-16 12:54:33','2024-08-01 02:51:11'),(2,'colin.chia@live.com','$2a$12$VMxSJ8bFs7Tfq1B1Eyan1u9r8B4NI/4hUj9JncHWCxL/aTMqIZd96','artist','Colin Chia','I am an artist','aaron-tan.jpg','123 Singapore','123','2024-07-16 17:32:45','2024-07-30 20:55:25'),(3,'bruce.smith@email.com','$2a$12$VMxSJ8bFs7Tfq1B1Eyan1u9r8B4NI/4hUj9JncHWCxL/aTMqIZd96','buyer','Bruce Smith','I am a buyer','bruce-smith.jpg','123 America','123','2024-07-16 17:32:45','2024-07-24 18:06:10'),(4,'alice.johnson@email.com','$2a$12$VMxSJ8bFs7Tfq1B1Eyan1u9r8B4NI/4hUj9JncHWCxL/aTMqIZd96','artist','Alice Johnson','Contemporary artist specializing in abstract paintings.','alice-johnson.jpg','101 Art Lane, Art City','321-654-9870','2024-07-21 13:26:01','2024-07-24 18:06:10'),(5,'bob.williams@email.com','$2a$12$VMxSJ8bFs7Tfq1B1Eyan1u9r8B4NI/4hUj9JncHWCxL/aTMqIZd96','artist','Bob Williams','Sculptor known for his modern metal sculptures.','bob-williams.jpg','102 Art Lane, Art City','432-765-0981','2024-07-21 13:26:01','2024-07-24 18:06:10'),(6,'charlotte.indranee@email.com','$2a$12$VMxSJ8bFs7Tfq1B1Eyan1u9r8B4NI/4hUj9JncHWCxL/aTMqIZd96','artist','Charlotte Indranee','Mixed media artist exploring themes of nature.','charlotte-indranee.jpg','103 Art Lane, Art City','543-876-1092','2024-07-21 13:26:01','2024-07-24 18:06:10'),(7,'david.lee@email.com','$2a$12$VMxSJ8bFs7Tfq1B1Eyan1u9r8B4NI/4hUj9JncHWCxL/aTMqIZd96','artist','David Lee','Photographer focusing on urban landscapes.','david-lee.jpg','104 Art Lane, Art City','654-987-2103','2024-07-21 13:26:01','2024-07-24 18:06:10'),(8,'emily.davis@email.com','$2a$12$VMxSJ8bFs7Tfq1B1Eyan1u9r8B4NI/4hUj9JncHWCxL/aTMqIZd96','artist','Emily Davis','Painter with a passion for portraits and still life.','emily-davis.jpg','105 Art Lane, Art City','765-098-3214','2024-07-21 13:26:01','2024-07-24 18:06:10'),(9,'frank.miller@email.com','$2a$12$VMxSJ8bFs7Tfq1B1Eyan1u9r8B4NI/4hUj9JncHWCxL/aTMqIZd96','artist','Frank Miller','Digital artist creating immersive digital art.','frank-miller.jpg','106 Art Lane, Art City','876-109-4325','2024-07-21 13:26:01','2024-07-24 18:06:10'),(10,'grace.wilson@email.com','$2a$12$VMxSJ8bFs7Tfq1B1Eyan1u9r8B4NI/4hUj9JncHWCxL/aTMqIZd96','artist','Grace Wilson','Ceramic artist known for her intricate pottery designs.','grace-wilson.jpg','107 Art Lane, Art City','987-210-5436','2024-07-21 13:26:01','2024-07-24 18:06:10'),(11,'henry.moore@email.com','$2a$12$VMxSJ8bFs7Tfq1B1Eyan1u9r8B4NI/4hUj9JncHWCxL/aTMqIZd96','artist','Henry Moore','Illustrator and graphic designer.','henry-moore.jpg','108 Art Lane, Art City','098-321-6547','2024-07-21 13:26:01','2024-07-24 18:06:10'),(12,'zechie.artist@email.com','$2a$10$rKYMz0nYQ19qiqpMsJOmSuQ.P6rZ8ElK4sErVtvDQt87bV8V8Pehu','artist','Zechie Artist','I\'m an artist named Zechie.','1722408108474_portrait-zechie.jpg','123 Marina Bay','12345678',NULL,'2024-08-01 19:35:41'),(14,'colin.chia.hx@gmail.com','$2a$10$V/HGQgFwM565CHCOfCTJH.8OujKEPnO9wIX2fEQmtd57sZxyz0eL.','artist','Colin Test','Hello, I\'m an artist in Singapore.','1722647064813_colin-gmail.jpg','123 Singapore Street','123456',NULL,NULL);



DROP TABLE IF EXISTS `user_cart`;
CREATE TABLE `user_cart` (
  `user_id` int NOT NULL,
  `artwork_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`artwork_id`),
  KEY `artwork_id` (`artwork_id`),
  CONSTRAINT `user_cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `user_cart_ibfk_2` FOREIGN KEY (`artwork_id`) REFERENCES `artwork` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



DROP TABLE IF EXISTS `user_liked_artworks`;
CREATE TABLE `user_liked_artworks` (
  `user_id` int NOT NULL,
  `artwork_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`artwork_id`),
  KEY `artwork_id` (`artwork_id`),
  CONSTRAINT `user_liked_artworks_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `user_liked_artworks_ibfk_2` FOREIGN KEY (`artwork_id`) REFERENCES `artwork` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
