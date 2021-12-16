# Copyright (c) Dirk Chang <dirk@kooiot.com>
# SPDX-License-Identifier: Apache-2.0

MF_DOCKER_IMAGE_NAME_PREFIX ?= kooiot

all: docker_symlink

.PHONY: all docker_symlink latest release

clean: cleandocker

clean_images:
	docker rmi -f `docker images | grep '<none>' | awk '{print $3}'`

clean_volumns:
	docker volume ls -f dangling=true -q | xargs -r docker volume rm -f

clean_all_volumns: clean_all_containers
	docker volume ls -q | xargs -r docker volume rm -f

clean_all_containers:
	docker container ls -a -q | xargs -r docker container rm -f

prepare:
	docker run --privileged --rm tonistiigi/binfmt --install all
	docker buildx create --use --name=local

docker_symlink:
	docker buildx build \
		--no-cache \
		--tag=$(MF_DOCKER_IMAGE_NAME_PREFIX)/symlink \
		--platform=linux/amd64,linux/arm64 \
		-f build/Dockerfile --push .

local:
	docker build \
		--no-cache \
		--tag=$(MF_DOCKER_IMAGE_NAME_PREFIX)/symlink \
		-f build/Dockerfile --load .

latest: docker_symlink
	docker push $(MF_DOCKER_IMAGE_NAME_PREFIX)/symlink:latest

run:
	docker-compose --project-name $(PROJECT_NAME) -f docker-compose.yml up

start:
	docker-compose --project-name $(PROJECT_NAME) -f docker-compose.yml up -d

stop:
	docker-compose --project-name $(PROJECT_NAME) -f docker-compose.yml stop

down:
	docker-compose --project-name $(PROJECT_NAME) -f docker-compose.yml down

