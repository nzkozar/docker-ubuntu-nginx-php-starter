FROM ubuntu:24.04

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# install base dependencies
RUN apt-get update && apt install -y --no-install-recommends \
    software-properties-common \
    curl \
    git \
    unzip \
    ca-certificates
RUN add-apt-repository ppa:ondrej/php -y

RUN apt-get update && apt install -y \
    php8.4 \
    php8.4-fpm \
    php8.4-cli \
    php8.4-mysql \
    php8.4-pgsql \
    php8.4-sqlite3 \
    php8.4-gd \
    php8.4-curl \
    php8.4-mbstring \
    php8.4-xml \
    php8.4-zip \
    php8.4-bcmath \
    php8.4-redis \
    php8.4-intl \ 
    nginx \
    && rm -rf /var/lib/apt/lists/*

# install nginx
RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

# set work directory
WORKDIR /var/www/app

COPY . .

# Copy Nginx configuration
COPY nginx.conf /etc/nginx/sites-available/default

# set workdir permissions
RUN chown -R www-data:www-data /var/www/app/html && \
    chmod -R 755 /var/www/app/html

# configure php-fpm
RUN mv /etc/php/8.4/fpm/pool.d/www.conf /etc/php/8.4/fpm/pool.d/www.conf.original

RUN cat php-fpm-pool.conf >> /etc/php/8.4/fpm/pool.d/www.conf

# Add HEALTHCHECK (place this near the end, before CMD)
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/ || exit 1

# expose ports
EXPOSE 80

# start services
CMD ["/bin/bash","-c","service php8.4-fpm start && nginx -g 'daemon off;'"]
