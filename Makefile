# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mbouthai <mbouthai@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/05/15 10:41:46 by mbouthai          #+#    #+#              #
#    Updated: 2023/11/05 18:29:11 by mbouthai         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

COMPOSE_CMD := docker compose -f
COMPOSE_FILE := ./srcs/docker-compose.yaml
HOME_DATA_DIR	:= /home/mbouthai/data

name = inception

all: create_directories
	@echo "Building and running docker images...\n"
	@$(COMPOSE_CMD) $(COMPOSE_FILE) up --detach --build

logs:
	@echo "Docker compose logs:"
	@$(COMPOSE_CMD) $(COMPOSE_FILE) logs

clean: down
	@echo "Deleting docker containers...\n"
	@$(COMPOSE_CMD) $(COMPOSE_FILE) down

fclean: delete_directories
	@echo "Deleting containers, images, networks and volumes...\n"
	@$(COMPOSE_CMD) $(COMPOSE_FILE) down --rmi all --volumes

create_directories:
	@echo "Creating data directories..."
	@mkdir -p $(HOME_DATA_DIR)/wordpress
	@mkdir -p $(HOME_DATA_DIR)/mariadb

delete_directories:
	@echo "Deleting data directories..."
	@rm -rf $(HOME_DATA_DIR)/wordpress/*
	@rm -rf $(HOME_DATA_DIR)/mariadb/*

re: fclean all

.PHONY	: all build down re clean fclean