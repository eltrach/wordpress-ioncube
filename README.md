# WordPress with ionCube Docker Setup

This repository provides a complete Docker setup for WordPress with ionCube loader support, based on the latest WordPress image with modern PHP versions.

## What's Included

- **WordPress**: Latest version with ionCube loader pre-installed
- **MySQL 8.0**: Database server with optimized configuration
- **phpMyAdmin**: Web-based database administration tool
- **ionCube Loader**: Automatically detects and installs the correct ionCube loader for the PHP version

## Features

- ✅ Latest WordPress version
- ✅ ionCube Loader automatically installed
- ✅ Increased memory limits (512M)
- ✅ Large file upload support (128MB)
- ✅ MySQL 8.0 database
- ✅ phpMyAdmin for database management
- ✅ Persistent data volumes
- ✅ Development-friendly configuration

## Quick Start

### Prerequisites

- Docker
- Docker Compose

### 1. Clone and Setup

```bash
git clone <your-repo-url>
cd wordpress-ioncube
```

### 2. Start the Services

```bash
# Build and start all services
docker-compose up -d --build

# Or start without phpMyAdmin
docker-compose up -d wordpress mysql
```

### 3. Access Your Sites

- **WordPress**: http://localhost:8888
- **phpMyAdmin**: http://localhost:8889
  - Username: `root`
  - Password: `root_password`

## Configuration

### Environment Variables

You can customize the configuration by modifying the environment variables in `docker-compose.yml`:

```yaml
environment:
  WORDPRESS_DB_HOST: mysql
  WORDPRESS_DB_USER: wordpress
  WORDPRESS_DB_PASSWORD: wordpress_password
  WORDPRESS_DB_NAME: wordpress
  WORDPRESS_DEBUG: 1
```

### Database Configuration

- **Database**: wordpress
- **Username**: wordpress
- **Password**: wordpress_password
- **Root Password**: root_password

### Ports

- **WordPress**: 8888
- **MySQL**: 3307
- **phpMyAdmin**: 8889

## File Structure

```
wordpress-ioncube/
├── Dockerfile              # Custom WordPress image with ionCube
├── docker-compose.yml      # Docker Compose configuration
├── uploads.ini             # PHP upload configuration
├── wp-content/             # WordPress content (auto-created)
└── README.md              # This file
```

## ionCube Verification

To verify that ionCube is installed correctly:

1. Access your WordPress admin area
2. Go to **Tools** > **Site Health** > **Info**
3. Look for ionCube in the PHP extensions list

Or create a PHP info file:

```php
<?php
// Create wp-content/ioncube-test.php
phpinfo();
?>
```

Then visit: `http://localhost:8888/wp-content/ioncube-test.php`

## Common Commands

```bash
# Start services
docker-compose up -d

# Stop services
docker-compose down

# View logs
docker-compose logs wordpress
docker-compose logs mysql

# Rebuild WordPress image
docker-compose build wordpress

# Reset everything (WARNING: Deletes all data)
docker-compose down -v
docker system prune -a
```

## Troubleshooting

### ionCube Not Loading

If ionCube isn't working:

1. Check the PHP version:

   ```bash
   docker exec wordpress-ioncube php -v
   ```

2. Verify ionCube extension:

   ```bash
   docker exec wordpress-ioncube php -m | grep -i ioncube
   ```

3. Check PHP configuration:
   ```bash
   docker exec wordpress-ioncube php --ini
   ```

### Database Connection Issues

If WordPress can't connect to the database:

1. Ensure MySQL is running:

   ```bash
   docker-compose ps mysql
   ```

2. Check MySQL logs:
   ```bash
   docker-compose logs mysql
   ```

### File Upload Issues

If you're having trouble uploading large files:

1. Check the `uploads.ini` file configuration
2. Restart the WordPress container:
   ```bash
   docker-compose restart wordpress
   ```

## Customization

### Adding Custom PHP Extensions

Modify the `Dockerfile` to add additional PHP extensions:

```dockerfile
RUN docker-php-ext-install extension_name
```

### Custom WordPress Configuration

Mount a custom `wp-config.php`:

```yaml
volumes:
  - ./custom-wp-config.php:/var/www/html/wp-config.php
```

## Security Notes

⚠️ **This setup is for development purposes.** For production use:

- Change all default passwords
- Use environment variables for sensitive data
- Enable SSL/HTTPS
- Configure proper firewall rules
- Regular security updates

## License

This project is open source and available under the [MIT License](LICENSE).

## Contributing

Feel free to submit issues and enhancement requests!

## References

- [Official WordPress Docker Image](https://hub.docker.com/_/wordpress)
- [ionCube Loader Documentation](https://www.ioncube.com/loaders.php)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
