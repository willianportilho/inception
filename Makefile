all:
		@sudo mkdir -p /home/wportilh/data/wordpress
		@sudo mkdir -p /home/wportilh/data/mariadb
		sudo sed -i '1s/.*/127.0.0.1       wportilh.42.fr localhost/' /etc/hosts
		@docker-compose -f srcs/docker-compose.yml up -d --build

down:
		@docker-compose -f srcs/docker-compose.yml down

re:		fclean all

clean:	down
		@docker system prune -a --force

fclean:
		@docker stop $$(docker ps -qa)
		@docker system prune --all --force --volumes
		@docker network prune --force
		@docker volume prune --force

.PHONY:	all down re clean fclean
