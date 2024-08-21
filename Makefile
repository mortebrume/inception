VOLUMES := srcs/volumes
RED = \033[1;31m
GREEN = \033[1;32m
YELLOW = \033[1;33m
BLUE = \033[1;34m
RESET = \033[0m

all: build up

ls:
	@echo "$(GREEN)██████████████████████████ IMAGES ███████████████████████████$(RESET)"
	@docker images
	@echo "$(YELLOW)██████████████████████ ALL CONTAINERS ███████████████████████$(RESET)"
	@docker ps -a

build: volumes
	@echo "$(BLUE)██████████████████████ Building Images ███████████████████████$(RESET)"
	docker-compose -f ./srcs/docker-compose.yml build

up:
	@echo "$(GREEN)██████████████████████ Running Containers ██████████████████████$(RESET)"
	@docker-compose -f ./srcs/docker-compose.yml up -d
	@echo "$(RED)╔════════════════════════════║NOTE:║════════════════════════╗$(RESET)"
	@echo "$(RED)║   $(BLUE) You can see The Containers logs using $(YELLOW)make logs        $(RED)║$(RESET)"
	@echo "$(RED)╚═══════════════════════════════════════════════════════════╝$(RESET)"


logs:
	@echo "$(GREEN)██████████████████████ Running Containers ██████████████████████$(RESET)"
	@docker-compose -f ./srcs/docker-compose.yml logs


status:
	@echo "$(GREEN)██████████████████████ The Running Containers ██████████████████████$(RESET)"
	@docker ps


stop:
	@echo "$(RED)████████████████████ Stoping Containers █████████████████████$(RESET)"
	docker-compose -f ./srcs/docker-compose.yml stop

start:
	@echo "$(RED)████████████████████ Starting Containers █████████████████████$(RESET)"
	docker-compose -f ./srcs/docker-compose.yml start

down:
	@echo "$(RED)██████████████████ Removing All Containers ██████████████████$(RESET)"
	docker-compose -f ./srcs/docker-compose.yml down -v

reload: down rvolumes build up

rm: rvolumes down
	@echo "$(RED)█████████████████████ Remove Everything ██████████████████████$(RESET)"
	docker system prune -a

rvolumes:
	@echo "$(RED)█████████████████████ Deleting volumes ██████████████████████$(RESET)"
	sudo rm -rf $(VOLUMES)

volumes:
	@echo "$(GREEN)█████████████████████ Creating volumes ██████████████████████$(RESET)"
	mkdir -p $(VOLUMES)/mariadb
	mkdir -p $(VOLUMES)/wordpress
	mkdir -p $(VOLUMES)/redis
	mkdir -p $(VOLUMES)/lounge

.PHONY: ls build up logs status stop start down reload rm rvolumes volumes