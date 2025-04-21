# Use the official PHP image with Nginx
FROM php:8.3-fpm

# Set the maintainer label
LABEL maintainer="<group>"

# Install required packages
RUN apt-get update && apt-get install -y \
    nginx \
    curl \
    zip \
    unzip \
    git \
    libonig-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip \
    && apt-get clean

# Set timezone to Brunei
ENV TZ=Asia/Brunei
RUN echo "Asia/Brunei" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata

# Set the working directory
WORKDIR /var/www/html

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]