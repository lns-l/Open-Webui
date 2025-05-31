.PHONY: up up-gpu down restart restart-gpu logs

up:
	docker-compose -f docker-compose.ollama.yml up -d
	docker-compose -f docker-compose.webui.yml up -d

up-gpu:
	USE_GPU=true docker-compose -f docker-compose.ollama.yml up -d
	USE_GPU=true docker-compose -f docker-compose.webui.yml up -d

down:
	docker-compose -f docker-compose.webui.yml down
	docker-compose -f docker-compose.ollama.yml down

restart: down up

restart-gpu: down up-gpu

logs:
	docker-compose -f docker-compose.ollama.yml logs -f
