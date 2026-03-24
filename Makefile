.PHONY: up down run logs status shell clean

up:
	docker-compose up -d --build
	@echo "Cluster started"
	@echo "NameNode UI: http://localhost:9870"
	@echo "ResourceManager UI: http://localhost:8088"

down:
	docker-compose down
	@echo "Cluster stopped"

run:
	docker exec -it namenode bash /scripts/run.sh

logs:
	docker-compose logs -f

status:
	docker-compose ps

shell:
	docker exec -it namenode bash

clean: down
	rm -rf output/*
	docker-compose rm -f
	@echo "Cleaned"