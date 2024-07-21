-- Create a new user and grant full access to the vartgallery database
CREATE USER 'vartgalleryadmin'@'localhost' IDENTIFIED BY 'vartgalleryadmin';
GRANT ALL PRIVILEGES ON `vartgallery`.* TO 'vartgalleryadmin'@'localhost';
FLUSH PRIVILEGES;
