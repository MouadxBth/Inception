# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mbouthai <mbouthai@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/05/15 10:41:46 by mbouthai          #+#    #+#              #
#    Updated: 2023/08/25 02:41:39 by mbouthai         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

COMPOSE_FILE := ./scrs/docker-compose.yaml
COMPOSE_CMD := docker compose -f
HOME_DATA_DIR	:= /home/mbouthai/data

all:
	@mkdir -p $(HOME_DATA_DIR)/wordpress
	@mkdir -p $(HOME_DATA_DIR)/mariadb
	@$(COMPOSE_CMD) $(COMPOSE_FILE) up -d --build

down:
	@$(COMPOSE_CMD) $(COMPOSE_FILE) down -v

stop:
	@$(COMPOSE_CMD) $(COMPOSE_FILE) stop

clean: down
	rm -rf $(HOME_DATA_DIR)/wordpress/*
	rm -rf $(HOME_DATA_DIR)/mariadb/*
	@docker stop $$(docker ps -qa)
	@docker rm $$(docker ps -qa)

re: clean all

.PHONY: all re down clean
