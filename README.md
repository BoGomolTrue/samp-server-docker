## Docker Compose Configuration for  GTA San Andreas Multiplayer (SA:MP), Redis, Redis Commander, MySQL, and phpMyAdmin

This Docker Compose configuration file (docker-compose.yml) allows you to easily set up a multi-container environment with the following services:

- Samp: A San Andreas Multiplayer server for multiplayer gaming.
- Redis: An open-source in-memory data structure store used as a database, cache, and message broker.
- Redis Commander: A web-based management tool for Redis.
- MySQL: A popular open-source relational database management system.
- phpMyAdmin: A free and open-source administration tool for managing MySQL databases.

### How to Use

1. Prerequisites:
   - Make sure you have Docker and Docker Compose installed on your system.

2. Configuration:
   - Clone this repository to your local machine.

3. Launch the Services:
   - Run the following command in the terminal in the directory where the docker-compose.yml file is located: 
    ```
    docker-compose up -d
    ```
     

4. Accessing Services:
   - samp-server: Connect your San Andreas Multiplayer game client to the IP and port of the localhost. Default port : 7777
   - Redis Commander: Access it via http://localhost:7774 (login default credentials: root / (no password)).
   - phpMyAdmin: Access it via http://localhost:7776 (login default credentials: root / root).
   
### Docker Compose File Details

```
version: '3.1'

services:
  db:
    image: mysql:5.7
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_HOST: 127.0.0.1
    ports:
      - 3306:3306
    networks:
      - "samp-server-net"

  phpmyadmin:
    image: phpmyadmin
    restart: always
    ports:
      - 7776:80
    environment:
      - PMA_ARBITRARY=0

  redis:
    image: redis:latest
    restart: always
    ports:
      - "6379:6379"
    volumes:
      - ./scriptfiles/docker/redis/redis.conf:/usr/local/etc/redis/redis.conf
    environment:
      - REDIS_PASSWORD=root
      - REDIS_PORT=6379
      - REDIS_DATABASES=16
    networks:
      - "samp-server-net"

  redis-commander:
    image: rediscommander/redis-commander:latest
    restart: always
    environment:
      REDIS_HOSTS: redis
      REDIS_HOST: redis
      REDIS_PORT: redis:6379
      REDIS_PASSWORD: 
      HTTP_USER: root
      HTTP_PASSWORD: root
    ports:
      - 7774:8081

  samp-server:
    restart: always
    build:
      context: .
      args:
        APP_ROOT: ${APP_ROOT}
        TGZ_FILE: ${TGZ_FILE}
    entrypoint: "/start.sh"
    image: samp-server
    ports:
      - ${EXTERNAL_PORT}:7777/tcp
      - ${EXTERNAL_PORT}:7777/udp
    networks:
      - "samp-server-net"
networks:
  samp-server-net:
    name: samp-server-net
```

### Additional Information

- You can modify the configuration of each service in the docker-compose.yml file as needed.
- For detailed information on configuration options for each service, refer to the official documentation for Docker, Redis, MySQL, and phpMyAdmin.
- Make sure to secure your services and use strong passwords for MySQL and phpMyAdmin access.

Enjoy your multi-container environment with samp-server, Redis, Redis Commander, MySQL, and phpMyAdmin using Docker Compose! If you have any questions or need further assistance, feel free to reach out.