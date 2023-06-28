# Webstack2

## About

This is a skeleton web stack for a lightweight local development environment for a single `PHP` application. It consists of the following containers, running as `Docker` services:

 - NGINX `1.25.1` (Alpine);

 - PHP `8.2` FPM (Alpine) packed with:

   - Composer `2.5.8`;

   - Deployer `7.3.1`;

  - MariaDB `11.0.2`.

Containers that can be invoked using `Makefile` targets:

 - NODE `18` (Alpine)
 
The PHP interpreter is running with the host user and group ID, allowing for easy management of installed vendor packages or files created with PHP on the host system. The same applies to the NODE container when invoked through the Makefile targets.

## System requirements

__Required software__:

  - Docker

  - Docker Compose

__Recommended tools:__

  - GNU make utility

## Setup

To set up the environment, you have two options.

### Using docker-compose

You can use the `docker-compose` command:

 ```
 docker-compose -p ws2 up --build
 ```

### Using make utility

You can utilize a helper `Makefile` with the `make` command:

 ```
 make install
 ```

You can find additional Makefile commands by running `make` or `make help`.

Once you have set up the environment, you can access the `public` directory in your browser by visiting [http://localhost](http://localhost).

The MariaDB container's port is bound to `127.0.0.1:3306`. The default username and password can be found in the `docker-compose.yml` file.

Note that "ws2" is the shorthand for the project name.

## Configuration of the services

Every service has an empty custom configuration file copied to its container during the build phase. You can locate and modify these files within the `docker` directory.

  - PHP: `docker/php82/conf.d/php.ini`

  - NGINX: `docker/nginx/conf.d/nginx.conf`

  - MariaDB: `docker/mariadb/mariadb.conf.d/01-docker.cnf`

If you modify any of the configuration files, you need to rebuild the containers.
