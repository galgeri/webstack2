.PHONY: help \
install \
composer \
composer-install \
composer-update \
deployer \
up up-build upd upd-build stop \
purge-db-volume \
shell-php \
shell-mariadb \
shell-node \
npm-install npm-update \
npm-run-dev \
npm-run-watch

.DEFAULT_GOAL := help

# Set dir of Makefile to a variable to use later
MAKEPATH := $(abspath $(lastword $(MAKEFILE_LIST)))
PWD := $(dir $(MAKEPATH))

PHP_CONTAINER="php82-ws2"
MARIADB_CONTAINER="mariadb-ws2"
NODE_CONTAINER="node:18-alpine3.18"

USER_ID=$(shell id -u)
GROUP_ID=$(shell id -g)

help: ## * Show help (Default task)
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

install: upd-build ## Run the up-build target
	@echo 💚 Your application is now available at http://localhost from your browser.

composer: ## Run an empty composer command in the PHP container
	docker exec -it --user=$(USER_ID):$(GROUP_ID) -w /www $(PHP_CONTAINER) composer

composer-install: ## Run composer install in the PHP container
	docker exec -it --user=$(USER_ID):$(GROUP_ID) -w /www $(PHP_CONTAINER) composer install

composer-require: ## Run composer require in the PHP container
	docker exec -it --user=$(USER_ID):$(GROUP_ID) -w /www $(PHP_CONTAINER) composer require

composer-update: ## Run composer update in the PHP container
	docker exec -it --user=$(USER_ID):$(GROUP_ID) -w /www $(PHP_CONTAINER) composer update

deployer: ## Run an empty deployer command in the PHP container
	docker exec -it --user=$(USER_ID):$(GROUP_ID) -w /www $(PHP_CONTAINER) dep

up: ## Run docker-compose up
	docker-compose -p ws2 up --remove-orphans

up-build: ## Run docker-compose up with build
	docker-compose -p ws2 up --build --remove-orphans

upd: ## Run docker-compose up with -d option
	docker-compose -p ws2 up -d --remove-orphans

upd-build: ## Run docker-compose build with --build and -d option
	docker-compose -p ws2 up -d --build --remove-orphans

stop: ## Stop docker containers
	docker-compose -p ws2 stop

purge-db-volume: ## Remove all volume data
	sudo rm -rf docker/volumes/*
	echo "*" | tee docker/volumes/.gitignore

shell-php: ## Open shell prompt in the PHP container
	docker exec -it --user=$(USER_ID):$(GROUP_ID) -w /www $(PHP_CONTAINER) sh

shell-mariadb: ## Open shell prompt in the MariaDB container
	docker exec -it $(MARIADB_CONTAINER) sh

shell-node: ## Open shell prompt in the Node container
	docker run -u $(USER_ID):$(GROUP_ID) -it -v $(PWD):/application -w /application $(NODE_CONTAINER) sh

npm-install: ## Run NPM install in the Node container
	docker run -u $(USER_ID):$(GROUP_ID) -it -v $(PWD):/application -w /application $(NODE_CONTAINER) npm install

npm-run-dev: ## Run "npm run dev" in the Node container
	docker run -u $(USER_ID):$(GROUP_ID) -it -v $(PWD):/application -w /application $(NODE_CONTAINER) npm run dev

npm-run-watch: ## Run "npm run watch" in the Node container
	docker run -u $(USER_ID):$(GROUP_ID) -it -v $(PWD):/application -w /application $(NODE_CONTAINER) npm run watch