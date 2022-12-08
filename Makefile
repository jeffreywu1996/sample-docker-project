APP_ENV?="local"

.PHONY: start
start: # starts dev mode
	export BUILD_VERSION=$(./scripts/get_build_version.sh) && \
	docker-compose -f docker/docker-compose.dev.yml --env-file .env up --build --remove-orphans

.PHONY: build
build:
	export BUILD_VERSION=$(./scripts/get_build_version.sh) && \
	docker compose -f docker/docker-compose.dev.yml --env-file .env build && \
	docker compose -f docker/docker-compose.bash.yml --env-file .env build && \
	docker compose -f docker/docker-compose.test.yml --env-file .env build

.PHONY: exec
exec:
	docker exec -it docker-vsm-1 /bin/bash

.PHONY: bash
bash: # starts bash mode of docker, useful for running tests
	docker compose -f docker/docker-compose.bash.yml -p vsm-bash --env-file .env up -d --remove-orphans && \
	docker exec -it vsm-bash-bash-1 /bin/bash ; \
	docker compose -p vsm-bash down

.PHONY: test
test:
	$(MAKE) unittest
	$(MAKE) inttest

.PHONY: inttest
inttest:
	export BUILD_VERSION=$(./scripts/get_build_version.sh) && \
	docker compose -f docker/docker-compose.dev.yml -f docker/docker-compose.test.yml --env-file .env up --abort-on-container-exit

.PHONY: unittest
unittest:
	export BUILD_VERSION=$(./scripts/get_build_version.sh) && \
	docker compose -f docker/docker-compose.unittest.yml --env-file .env up --build --abort-on-container-exit

.PHONY: lint
lint:
	./scripts/ci/run_linter.sh --backend
