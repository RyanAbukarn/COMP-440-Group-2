use 'projdb';
CREATE USER 'comp440'@'localhost' IDENTIFIED BY 'pass1234';
GRANT SELECT,INSERT ON projdb.* TO 'comp440'@'localhost';
FLUSH PRIVILEGES;