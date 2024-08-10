CREATE DATABASE  IF NOT EXISTS `vartgallery`;
USE `vartgallery`;


-- Table structure for table `artwork`
DROP TABLE IF EXISTS `artwork`;
CREATE TABLE `artwork` (
  `id` int NOT NULL AUTO_INCREMENT,
  `artist_id` int DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` longtext,
  `dimension` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `like_count` int DEFAULT '0',
  `view_count` int DEFAULT '0',
  `status` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `buyer_id` int DEFAULT NULL,
  `version` int NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` char(1) DEFAULT 'Y',
  PRIMARY KEY (`id`),
  KEY `artist_id` (`artist_id`),
  KEY `buyer_id` (`buyer_id`),
  CONSTRAINT `artwork_ibfk_1` FOREIGN KEY (`artist_id`) REFERENCES `user` (`id`),
  CONSTRAINT `artwork_ibfk_2` FOREIGN KEY (`buyer_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `artwork` VALUES (1,2,'Nebula Dreams','A digital painting that depicts a vibrant nebula with swirling colors of pink, purple, and blue, set against a backdrop of stars. The artwork evokes a sense of cosmic wonder and the mysteries of the universe.','1920 x 1080 pixels','nebula-dreams.jpg',250,450,'available',0.00,NULL,0,'2024-08-08 12:00:00','2024-08-09 12:48:21','Y'),(2,2,'Eternal Harmony','A serene sculpture made from marble, featuring two intertwined figures symbolizing unity and balance. The smooth curves and elegant form make it a captivating centerpiece for any space.','60 x 40 x 30 cm','eternal-harmony.jpg',320,520,'available',4500.00,NULL,0,'2024-08-08 12:00:00','2024-08-10 14:15:43','Y'),(3,2,'Whispers of the Wind','A textile artwork woven with fine threads of silk and wool. The piece captures the movement and fluidity of the wind, with delicate patterns and soft hues of blue and white.','120 x 180 cm','whispers-of-the-wind.jpg',300,600,'available',3200.00,NULL,0,'2024-08-08 12:00:00','2024-08-10 14:15:43','Y'),(4,4,'Fragments of Time','A mixed media artwork combining photography and collage techniques. The piece features fragmented images of clocks and gears, layered over each other to create a sense of time breaking apart.','80 x 120 cm','fragments-of-time.jpg',150,350,'available',2800.00,NULL,0,'2024-08-08 12:00:00','2024-08-10 14:15:43','Y'),(5,4,'Midnight Reverie','A painting that captures the tranquil beauty of a midnight garden, illuminated by the soft glow of the moon. The artwork is filled with rich blues and greens, creating a peaceful and dreamlike atmosphere.','70 x 100 cm','midnight-reverie.jpg',400,700,'available',3500.00,NULL,0,'2024-08-08 12:00:00','2024-08-10 14:15:43','Y'),(6,4,'Echoes of the Past','A bronze sculpture that depicts a lone figure standing on the edge of a cliff, gazing into the distance. The rough texture and patina of the bronze convey a sense of history and endurance.','45 x 35 x 25 cm','echoes-of-the-past.jpg',500,800,'available',5000.00,NULL,0,'2024-08-08 12:00:00','2024-08-09 12:47:27','Y'),(7,6,'Crystal Shores','A glass art piece featuring a collection of glass shards arranged to mimic the shimmering effect of waves crashing on a shore. The varying shades of blue and green glass create a dynamic and mesmerizing visual.','50 x 40 cm','crystal-shores.jpg',220,500,'available',2400.00,NULL,0,'2024-08-08 12:00:00','2024-08-10 14:15:43','Y'),(8,6,'Silent Forest','A ceramic sculpture that depicts a quiet, dense forest, with towering trees and underbrush. The intricate details and earthy tones make it a striking representation of nature\\\'s beauty.','35 x 25 x 25 cm','silent-forest.jpg',270,600,'available',4200.00,NULL,0,'2024-08-08 12:00:00','2024-08-10 14:15:43','Y'),(9,7,'Rhythms of the Earth','A painting that uses bold brushstrokes and vibrant colors to capture the dynamic energy of the earth. The abstract forms and layers of paint create a sense of movement and life.','90 x 120 cm','rhythms-of-the-earth.jpg',180,400,'available',3100.00,NULL,0,'2024-08-08 12:00:00','2024-08-09 12:47:27','Y'),(10,8,'Celestial Dance','A digital painting depicting a cosmic ballet of planets and stars in a distant galaxy. The artwork is full of vibrant colors and intricate details, evoking the beauty and grandeur of the universe.','1920 x 1080 pixels','celestial-dance.jpg',160,350,'available',0.00,NULL,0,'2024-08-08 12:00:00','2024-08-09 12:48:21','Y'),(11,9,'The Wanderer','A photograph capturing a lone traveler walking through a vast desert, with the setting sun casting long shadows on the sand. The image conveys a sense of solitude and introspection.','40 x 60 cm','the-wanderer.jpg',450,700,'available',1800.00,NULL,0,'2024-08-08 12:00:00','2024-08-09 12:49:30','Y'),(12,9,'Oceanic Symphony','A mixed media artwork combining painting and digital techniques to depict the movement and energy of ocean waves. The layers of texture and color create a dynamic and immersive experience.','100 x 150 cm','oceanic-symphony.jpg',210,500,'available',3500.00,NULL,0,'2024-08-08 12:00:00','2024-08-09 12:49:30','Y');


-- Table structure for table `exhibition`
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


-- Table structure for table `genre`
DROP TABLE IF EXISTS `genre`;
CREATE TABLE `genre` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
INSERT INTO `join_artist_genre` VALUES (2,1),(4,1),(13,1),(5,2),(13,2),(2,3),(6,3),(13,3),(7,4),(8,5),(10,6),(10,7),(11,7);


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
INSERT INTO `join_artwork_genre` VALUES (1,1),(3,1),(7,1),(8,1),(10,1),(12,1),(1,2),(4,2),(7,2),(8,2),(9,2),(10,2),(11,2),(4,3),(6,3),(7,3),(9,3),(12,3),(1,5),(10,5),(12,5),(1,6),(6,6),(11,6),(1,7),(10,7),(12,7);


-- Table structure for table `pending_artwork`
DROP TABLE IF EXISTS `pending_artwork`;
CREATE TABLE `pending_artwork` (
  `id` int NOT NULL AUTO_INCREMENT,
  `artist_id` int DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` longtext,
  `dimension` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `genre_ids` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `artist_id` (`artist_id`),
  CONSTRAINT `pending_artwork_ibfk_1` FOREIGN KEY (`artist_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- Table structure for table `pending_user`
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- Table structure for table `transaction`
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- Table structure for table `user`
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
  `active` char(1) DEFAULT 'Y',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `user` VALUES (1,'admin@vartg.com','$2a$12$VMxSJ8bFs7Tfq1B1Eyan1u9r8B4NI/4hUj9JncHWCxL/aTMqIZd96','admin','Admin User','The administrator of the Virtual Art Gallery.','admin.jpg','123 Admin St, Admin City','111-111-1111','2024-08-08 12:00:00','2024-08-09 11:27:16','Y'),(2,'colin.chia@live.com','$2a$12$VMxSJ8bFs7Tfq1B1Eyan1u9r8B4NI/4hUj9JncHWCxL/aTMqIZd96','artist','Colin Chia Artist','Colin is an emerging artist with a passion for digital painting and contemporary art. His works often explore the intersection of technology and nature.','colin-artist.jpg','Singapore','404-040-4040','2024-08-08 12:00:00','2024-08-09 12:13:21','Y'),(3,'colin.chia.hx@gmail.com','$2a$12$VMxSJ8bFs7Tfq1B1Eyan1u9r8B4NI/4hUj9JncHWCxL/aTMqIZd96','buyer','Colin Chia Buyer','Colin is also an art enthusiast and collector, with a particular interest in modern and digital art. He enjoys exploring new artists and adding unique pieces to his collection.','colin-buyer.jpg','Singapore','505-050-5050','2024-08-08 12:00:00','2024-08-09 12:13:21','Y'),(4,'aurelia.munosca@email.com','$2a$12$VMxSJ8bFs7Tfq1B1Eyan1u9r8B4NI/4hUj9JncHWCxL/aTMqIZd96','artist','Aurelia Munosca','Aurelia Munosca is a textile artist known for her intricate tapestries and sculptures made of natural fibers. Her work explores themes of nature, spirituality, and the human condition.','aurelia.jpg','Barcelona, Spain','222-222-2222','2024-08-08 12:00:00','2024-08-09 13:08:02','Y'),(5,'boris.johanssen@email.com','$2a$12$VMxSJ8bFs7Tfq1B1Eyan1u9r8B4NI/4hUj9JncHWCxL/aTMqIZd96','buyer','Boris Johanssen','A passionate art collector, Boris has a keen interest in modern art and sculptures.','boris.jpg','London, UK','333-333-3333','2024-08-08 12:00:00','2024-08-09 13:08:02','Y'),(6,'carlos.garcia@email.com','$2a$12$VMxSJ8bFs7Tfq1B1Eyan1u9r8B4NI/4hUj9JncHWCxL/aTMqIZd96','artist','Carlos Garcia','Carlos is an art enthusiast who enjoys collecting contemporary Latin American art.','carlos.jpg','Mexico City, Mexico','444-444-4444','2024-08-08 12:00:00','2024-08-09 12:15:29','Y'),(7,'desmond.kiplangat@email.com','$2a$12$VMxSJ8bFs7Tfq1B1Eyan1u9r8B4NI/4hUj9JncHWCxL/aTMqIZd96','artist','Desmond Kiplangat','Desmond is a Kenyan photographer whose work captures the vibrant culture and landscapes of East Africa.','desmond.jpg','Nairobi, Kenya','555-555-5555','2024-08-08 12:00:00','2024-08-09 12:15:29','Y'),(8,'emiko.yamada@email.com','$2a$12$VMxSJ8bFs7Tfq1B1Eyan1u9r8B4NI/4hUj9JncHWCxL/aTMqIZd96','artist','Emiko Yamada','Emiko has a deep appreciation for traditional Japanese art and often collects works by emerging artists.','emiko.jpg','Tokyo, Japan','666-666-6666','2024-08-08 12:00:00','2024-08-09 12:15:29','Y'),(9,'frida.kahla@email.com','$2a$12$VMxSJ8bFs7Tfq1B1Eyan1u9r8B4NI/4hUj9JncHWCxL/aTMqIZd96','artist','Frida Kahla','Frida is a painter who is known for her deeply personal self-portraits, which explore themes of identity, postcolonialism, gender, class, and race in Mexican society.','frida.jpg','Coyoacán, Mexico','777-777-7777','2024-08-08 12:00:00','2024-08-09 13:08:44','Y'),(10,'giovanni.rossa@email.com','$2a$12$VMxSJ8bFs7Tfq1B1Eyan1u9r8B4NI/4hUj9JncHWCxL/aTMqIZd96','artist','Giovanni Rossa','Giovanni is an Italian sculptor known for his modernist works in marble and bronze.','giovanni.jpg','Florence, Italy','888-888-8888','2024-08-08 12:00:00','2024-08-09 13:08:44','Y'),(11,'haruto.taka@email.com','$2a$12$VMxSJ8bFs7Tfq1B1Eyan1u9r8B4NI/4hUj9JncHWCxL/aTMqIZd96','artist','Haruto Taka','Haruto is a young entrepreneur with a growing collection of digital art.','haruto.jpg','Osaka, Japan','999-999-9999','2024-08-08 12:00:00','2024-08-09 13:08:44','Y'),(12,'inga.nilsson@email.com','$2a$12$VMxSJ8bFs7Tfq1B1Eyan1u9r8B4NI/4hUj9JncHWCxL/aTMqIZd96','artist','Inga Nilsson','Inga is a Swedish ceramic artist whose work focuses on functional yet aesthetically pleasing pottery.','inga.jpg','Stockholm, Sweden','101-010-1010','2024-08-08 12:00:00','2024-08-09 12:15:29','Y'),(13,'jasmine.lee@email.com','$2a$12$VMxSJ8bFs7Tfq1B1Eyan1u9r8B4NI/4hUj9JncHWCxL/aTMqIZd96','artist','Jasmine Lee','Jasmine is a lover of abstract art and enjoys visiting galleries and exhibitions around the world.','jasmine.jpg','Seoul, South Korea','202-020-2020','2024-08-08 12:00:00','2024-08-09 12:15:29','Y'),(14,'khaled.mansour@email.com','$2a$12$VMxSJ8bFs7Tfq1B1Eyan1u9r8B4NI/4hUj9JncHWCxL/aTMqIZd96','artist','Khaled Mansour','Khaled is a contemporary artist from Egypt, known for his vibrant mixed media installations that often explore themes of identity and heritage.','khaled.jpg','Cairo, Egypt','303-030-3030','2024-08-08 12:00:00','2024-08-09 12:15:29','Y');


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
