#		nome do container
name =	simple_nginx_html

all:
#		adiciona meu próprio nome localhost aos hosts
		sudo sed -i '1s/.*/127.0.0.1       wportilh.42.fr localhost/' /etc/hosts
# 		inicializa e atualiza os containers
		@docker-compose -f srcs/docker-compose.yml up -d --build

down:
#		destrói os containers, volumes se a flag -v não estiver presente e redes que não estão sendo utilizadas
		@docker-compose -f srcs/docker-compose.yml down

#		constrói os containers a partir do 0, havendo ou não alterações nos containers
re:		fclean

clean:	down
#		limpa todos os volumes, imagens e redes que não estão sendo utilizados pelo docker.
		@docker system prune -a --force

fclean:
#		exclui tudo do docker. Dessa forma começamos realmente do 0.
		@docker stop $$(docker ps -qa)
		@docker system prune --all --force --volumes
		@docker network prune --force
		@docker volume prune --force

.PHONY:	all down re clean fclean
