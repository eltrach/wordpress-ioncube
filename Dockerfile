# Use WordPress with PHP 8.1 to match ionCube encoded files
FROM wordpress:php8.1-apache

# Set maintainer information
LABEL maintainer="WordPress ionCube Demo"
LABEL description="WordPress with ionCube Loader support for PHP 8.1"

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Get PHP version for ionCube compatibility
RUN PHP_VERSION=$(php -r "echo PHP_MAJOR_VERSION.'.'.PHP_MINOR_VERSION;") && \
    echo "Installing ionCube for PHP $PHP_VERSION" && \
    # Download ionCube loader
    cd /tmp && \
    wget https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz && \
    tar xzf ioncube_loaders_lin_x86-64.tar.gz && \
    # Copy the appropriate ionCube loader
    cp ioncube/ioncube_loader_lin_${PHP_VERSION}.so /usr/local/lib/php/extensions/no-debug-non-zts-*/ && \
    # Clean up
    rm -rf /tmp/ioncube* && \
    # Create ionCube configuration
    echo "zend_extension=ioncube_loader_lin_${PHP_VERSION}.so" > /usr/local/etc/php/conf.d/01-ioncube.ini

# Increase memory limits and upload sizes
RUN echo "memory_limit = 512M" >> /usr/local/etc/php/conf.d/wordpress.ini && \
    echo "upload_max_filesize = 128M" >> /usr/local/etc/php/conf.d/wordpress.ini && \
    echo "post_max_size = 128M" >> /usr/local/etc/php/conf.d/wordpress.ini && \
    echo "max_execution_time = 300" >> /usr/local/etc/php/conf.d/wordpress.ini && \
    echo "max_input_vars = 3000" >> /usr/local/etc/php/conf.d/wordpress.ini

# Set proper permissions
RUN chown -R www-data:www-data /var/www/html

# Expose port 80
EXPOSE 80

# Use the default WordPress entrypoint
CMD ["apache2-foreground"] 