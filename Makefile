COMPOSE = docker compose
SERVICE = ocr
INPUT_DIR = ./input
OUTPUT_DIR = ./output

.PHONY: help build up down restart logs ps shell run clean

help:
	@echo "Usage: make [command]"
	@echo ""
	@echo "Commands:"
	@echo "  build    : Build the container image"
	@echo "  up       : Start the container in the background"
	@echo "  down     : Stop and remove the container"
	@echo "  restart  : Restart the container"
	@echo "  ps       : Check the container status"
	@echo "  logs     : Display logs (-f to follow)"
	@echo "  shell    : Enter the container shell"
	@echo "  run      : Run OCR (e.g., make run FILE=sample.jpg)"
	@echo "  clean    : Remove output results (output/)"

build:
	$(COMPOSE) build

up:
	$(COMPOSE) up -d

down:
	$(COMPOSE) down

restart:
	$(COMPOSE) restart

ps:
	$(COMPOSE) ps

logs:
	$(COMPOSE) logs -f

shell:
	$(COMPOSE) exec $(SERVICE) bash

run:
	@if [ -z "$(FILE)" ]; then \
		echo "Error: FILE is not specified. Use 'make run FILE=your_image.jpg'"; \
	else \
		$(eval DIRNAME := $(shell echo $(FILE) | cut -f 1 -d '.')) \
		mkdir -p $(OUTPUT_DIR)/$(DIRNAME); \
		$(COMPOSE) exec $(SERVICE) ndlocr-lite \
			--sourceimg $(INPUT_DIR)/$(FILE) \
			--output $(OUTPUT_DIR)/$(DIRNAME)/; \
	fi

clean:
	rm -rf $(OUTPUT_DIR)/*
	touch $(OUTPUT_DIR)/.gitkeep
	@echo "Cleaned up output directory."