FROM php:8.2-fpm

# Install dependencies
RUN apt-get update && apt-get install -y \
  libmcrypt-dev \
  libicu-dev \
  git \
  curl \
  libpng-dev \
  libonig-dev \
  libxml2-dev \
  zip \
  libzip-dev \
  unzip \
  wget \
  ca-certificates \
  gnupg \
  nano

# Install NodeJS
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
RUN apt-get update && apt-get install nodejs -y


# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip calendar intl

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN chmod +x /usr/local/bin/composer

# Set working directory
WORKDIR /var/www/html

# Expose port 9000
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm"]
