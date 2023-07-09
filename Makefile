# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mbouthai <mbouthai@student.1337.ma>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/05/15 10:41:46 by mbouthai          #+#    #+#              #
#    Updated: 2023/07/09 23:00:02 by mbouthai         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

COMPOSE_FILE := ./scrs/docker-compose.yaml
COMPOSE_CMD := docker compose -f

all:
	@$(COMPOSE_CMD) $(COMPOSE_FILE) up -d --build

down:
	@$(COMPOSE_CMD) $(COMPOSE_FILE) down

clean:
	@docker stop $$(docker ps -qa)
	@docker rm $$(docker ps -qa)

re: clean all

.PHONY: all re down clean
