#++++++++++++++++++++++++++++++++++++++
# CentOS 8 PHP Docker container
#++++++++++++++++++++++++++++++++++++++
FROM centos:8
MAINTAINER "Tat Pham" <tat.pham89@gmail.com>

# normal updates
RUN yum -y update && yum clean all

# Install tools
RUN yum -y install \
        epel-release \
        zip \
        unzip \
        bzip2 \
        wget \
        net-tools \
        bind-utils \
        mysql \
        rsync \
        git \
    && yum clean all

# Install services
RUN yum -y install \
        dnsmasq \
        supervisor \
    && yum clean all

#Install php 7.4
RUN dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
RUN dnf -y install https://rpms.remirepo.net/enterprise/remi-release-8.rpm
RUN dnf -y module enable php:remi-7.4
RUN dnf -y install php \
    php-fpm \
    php-cli \
    php-common \
    php-pdo \
	php-mysqli \
	php-gd \
	php-pdo_mysql \
	php-pdo_sqlite \
	php-curl \
	php-bcmath \
	php-ctype \
	php-gmp \
	php-dom \
	php-hash \
	php-iconv \
	php-intl \
	php-mbstring \
	php-openssl \
	php-simplexml \
	php-soap \
	php-xsl \
	php-zip \
	php-libxml \
	&& dnf clean all

#install xdebug
RUN dnf -y install php-xdebug

WORKDIR /var/www/html

#install apache
RUN yum -y --setopt=tsflags=nodocs update && \
    yum -y --setopt=tsflags=nodocs install httpd && \
    yum clean all

#install nodejs
RUN yum module install -y nodejs
RUN yum module install -y nodejs/development

#Install ssl
RUN yum -y install mod_ssl && yum clean all

#Export port
EXPOSE 80

ADD docker/php-apache/run-httpd.sh /run-httpd.sh
RUN chmod a+x /var/www/html
RUN chmod -v +x /run-httpd.sh

COPY docker/php-apache/misc/php/php.ini /etc
COPY docker/php-apache/misc/php/www.conf /etc/php-fpm.d
COPY docker/php-apache/misc/service/laravel-queue.service /etc/systemd/system/laravel-queue.service
COPY docker/php-apache/httpd/000-default.conf /etc/httpd/conf.d
COPY docker/php-apache/httpd/000-default-normal.conf /etc/httpd/conf.d
COPY docker/php-apache/httpd/httpd.conf /etc/httpd/conf/httpd.conf
COPY docker/php-apache/httpd/welcome.conf /etc/httpd/conf.d

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Starting point
#CMD ["sh", "/run-httpd.sh", "/usr/sbin/init", "/usr/bin/supervisord -n"]
ENTRYPOINT ["sh", "/run-httpd.sh", "/usr/sbin/init", "/usr/bin/supervisord -n", "/usr/lib/systemd/systemd", "--system"]
