.PHONY: all build run

all: build run

build:
	docker build -t pyenv-poetry .

run:
	docker run --rm -it pyenv-poetry:latest
