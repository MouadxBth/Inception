# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mbouthai <mbouthai@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/05/15 10:41:46 by mbouthai          #+#    #+#              #
#    Updated: 2023/08/30 20:54:15 by mbouthai         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

COMPOSE_FILE := ./srcs/docker-compose.yaml
COMPOSE_CMD := docker compose -f
HOME_DATA_DIR	:= /home/mbouthai/data

name = inception

all:
	@printf "Launch configuration ${name}...\n"
	@mkdir -p $(HOME_DATA_DIR)/wordpress
	@mkdir -p $(HOME_DATA_DIR)/mariadb
	@$(COMPOSE_CMD) $(COMPOSE_FILE) up -d

build:
	@printf "Building configuration ${name}...\n"
	@mkdir -p $(HOME_DATA_DIR)/wordpress
	@mkdir -p $(HOME_DATA_DIR)/mariadb
	@$(COMPOSE_CMD) $(COMPOSE_FILE) up -d --build

down:
	@printf "Stopping configuration ${name}...\n"
	@$(COMPOSE_CMD) $(COMPOSE_FILE) down

re: down
	@printf "Rebuild configuration ${name}...\n"
	@$(COMPOSE_CMD) $(COMPOSE_FILE) up -d --build

clean: down
	@printf "Cleaning configuration ${name}...\n"
	@docker system prune -a
	@sudo rm -rf $(HOME_DATA_DIR)/wordpress/*
	@sudo rm -rf $(HOME_DATA_DIR)/mariadb/*

fclean:
	@printf "Total clean of all configurations docker\n"
	@docker stop $$(docker ps -qa)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@sudo rm -rf $(HOME_DATA_DIR)/wordpress/*
	@sudo rm -rf $(HOME_DATA_DIR)/mariadb/*

.PHONY	: all build down re clean fclean
