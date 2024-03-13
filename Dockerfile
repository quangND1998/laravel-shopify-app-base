
# Arguments defined in docker-compose.yml

FROM php:8.1-fpm
ARG user
ARG uid

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip
RUN apt-get update; \
    # Imagick extension
    apt-get install -y libmagickwand-dev; \
    pecl install imagick; \
    docker-php-ext-install gd; \
    docker-php-ext-enable imagick; \
    # Success
    true

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Install Postgre PDO
RUN apt-get update && apt-get install -y libpq-dev && docker-php-ext-install pdo pdo_pgsql

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Create system user to run Composer and Artisan Commands
RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user

WORKDIR /var/www/laravel-shopify-app


#-----------SUPERVISOR------------
COPY .docker/root/supervisord.conf /etc/supervisord.conf

# Task scheduling
# RUN echo "* * * * * php /app/artisan schedule:run >> /dev/null 2>&1" >> /etc/crontabs/root

# Laravel horizon
# Note that Horizon already includes worker
# Otherwise we need to run queue:work manually to spawn workers
COPY .docker/supervisor.d /etc/supervisor.d

# Copy existing application directory permissions
COPY . .

CMD supervisord -n -c /etc/supervisord.conf
