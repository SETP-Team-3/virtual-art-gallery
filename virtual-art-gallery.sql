-- Drop tables if they exist
DROP TABLE IF EXISTS `vartgallery`.`artwork`;
DROP TABLE IF EXISTS `vartgallery`.`user`;

-- Create the user table
CREATE TABLE `vartgallery`.`user` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `email` VARCHAR(255) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    `role` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `description` TEXT,
    `portrait` TEXT,
    `address` TEXT,
    `phone` VARCHAR(255),
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create the artwork table
CREATE TABLE `vartgallery`.`artwork` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `artist_id` INT,
    `title` VARCHAR(255) NOT NULL,
    `description` TEXT,
    `image` TEXT,
    `like_count` INT DEFAULT 0,
    `view_count` INT DEFAULT 0,
    `status` VARCHAR(255),
    `price` DECIMAL(10,2),
    `buyer_id` INT,
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`artist_id`) REFERENCES `user`(`id`),
    FOREIGN KEY (`buyer_id`) REFERENCES `user`(`id`)
);

-- Insert a starter user row
INSERT INTO `vartgallery`.`user` (`email`, `password`, `role`, `name`, `description`, `portrait`, `address`, `phone`)
VALUES ('admin@vartg.com', 'hashed_password_here', 'admin', 'VAG Super Admin', 'Admin user for initial setup', '', '123 Art Street, Art City', '123-456-7890');

-- Insert a starter artwork row
INSERT INTO `vartgallery`.`artwork` (`artist_id`, `title`, `description`, `image`, `like_count`, `view_count`, `status`, `price`, `buyer_id`)
VALUES (1, 'First Artwork', 'This is the description of the first artwork.', '', 0, 0, 'available', 100.00, NULL);
