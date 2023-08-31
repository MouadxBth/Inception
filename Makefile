# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mbouthai <mbouthai@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/05/15 10:41:46 by mbouthai          #+#    #+#              #
#    Updated: 2023/08/31 11:43:47 by mbouthai         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

COMPOSE_FILE := ./srcs/docker-compose.yaml
COMPOSE_CMD := docker compose -f
HOME_DATA_DIR	:= /home/mbouthai/data

name = inception

all: create_directories
	@echo "Building and running docker images...\n"
	@$(COMPOSE_CMD) $(COMPOSE_FILE) up -d --build

down:
	@echo "Stopping docker containers...\n"
	@$(COMPOSE_CMD) $(COMPOSE_FILE) down

clean: down
	@echo "Deleting docker containers...\n"
	@docker system prune -a

fclean: delete_directories
	@echo "Deleting containers, images, networks and volumes...\n"
	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force

create_directories:
	@echo "Creating data directories..."
	@mkdir -p $(HOME_DATA_DIR)/wordpress
	@mkdir -p $(HOME_DATA_DIR)/mariadb

delete_directories:
	@echo "Deleting data directories..."
	@rm -rf $(HOME_DATA_DIR)/wordpress/*
	@rm -rf $(HOME_DATA_DIR)/mariadb/*

re: down all

.PHONY	: all build down re clean fclean