-- create user and grant permission to user
CREATE USER 'repl'@'%' IDENTIFIED BY 'welcome1';
GRANT all ON <database name>.* TO 'repl'@'%';
GRANT SUPER,REPLICATION CLIENT  ON *.* TO 'repl'@'%';
