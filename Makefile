IMAGE_NAME=todo-api:latest

all: build
.PHONY: all

build: tidy
	export GOOS=linux GOARCH=amd64 CGO_ENABLED=0 && go build -o dist/app cmd/server/main.go
.PHONY: build

run: build
	./dist/app
.PHONY: run

clean:
	rm -rf dist
.PHONY: clean

tidy:
	go mod tidy
.PHONY: tidy

image:
	docker build -t ${IMAGE_NAME} .
.PHONY: image

image-clean:
	docker image rm ${IMAGE_NAME}
.PHONY: image-clean

compose:
	docker-compose up -d --build
.PHONY: compose

compose-clean:
	docker-compose down
.PHONY: compose-clean
