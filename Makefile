.PHONY: up down restart logs

up:
	docker-compose -f docker-compose.ollama.yml up -d
	docker-compose -f docker-compose.webui.yml up -d

down:
	docker-compose -f docker-compose.webui.yml down
	docker-compose -f docker-compose.ollama.yml down

restart: down up

logs:
	docker-compose -f docker-compose.ollama.yml logs -f
