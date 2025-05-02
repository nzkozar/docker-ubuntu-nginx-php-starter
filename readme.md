# Ubuntu Nginx and PHP-FPM starter Docker container

This project sets up a basic Ubuntu 24.04 LTS container with PHP 8.4 FPM and Nginx to serve a index.php file.
Usefull for jump starting a PHP project deployment using Docker

## Build
`docker build -t ubuntu-nginx-php-starter .`

## Run
`docker run --rm -p 8080:80 ubuntu-nginx-php-starter`

After running your site will be served at http://localhost:8080

## Healthcheck
`docker inspect --format='{{json .State.Health}}' <container_id>`

## Dockerhub image
https://hub.docker.com/r/nzkozar/ubuntu-nginx-php-starter