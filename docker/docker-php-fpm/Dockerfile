FROM php:7.4.3-fpm-alpine3.11
# Install PHP and its modules
RUN apk update && \
	apk upgrade && \
	apk add tzdata && \
	cp /usr/share/zoneinfo/Asia/Ho_Chi_Minh /etc/localtime && \
	echo "Asia/Ho_Chi_Minh" > /etc/timezone

# Use the default production configuration
COPY "misc/php.ini" "$PHP_INI_DIR/php.ini"

RUN apk update \
    	&& apk add --no-cache \
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        gmp \
        gmp-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
	&& docker-php-ext-install -j$(nproc) gd

# database
RUN docker-php-ext-install -j$(nproc) \
	mysqli \
	pdo \
	pdo_mysql \
	gmp

# strings
RUN apk add --no-cache \
        oniguruma-dev \
        && docker-php-ext-configure mbstring --enable-mbstring

# Delete cache
RUN apk del tzdata && \
    rm -rf /tmp/* /var/cache/apk/*

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install git
RUN apk add git
