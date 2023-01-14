.PHONY: start
start: # starts dev mode
	export BUILD_VERSION=$(./scripts/get_build_version.sh) && \
	docker-compose -f docker/docker-compose.dev.yml --env-file .env up --build --remove-orphans

.PHONY: build
build:
	export BUILD_VERSION=$(./scripts/get_build_version.sh) && \
	docker compose -f docker/docker-compose.dev.yml --env-file .env build && \
	# docker compose -f docker/docker-compose.bash.yml --env-file .env build && \
	docker compose -f docker/docker-compose.dev.yml -f docker/docker-compose.test.yml --env-file .env build --no-cache

.PHONY: test
test:
	$(MAKE) unittest
	$(MAKE) inttest

.PHONY: inttest
inttest:
	export BUILD_VERSION=$(./scripts/get_build_version.sh) && \
	docker compose -f docker/docker-compose.dev.yml -f docker/docker-compose.test.yml --env-file .env up --remove-orphans --abort-on-container-exit

.PHONY: unittest
unittest:
	export BUILD_VERSION=$(./scripts/get_build_version.sh) && \
	docker compose -f docker/docker-compose.unittest.yml --env-file .env up --build --remove-orphans --abort-on-container-exit

.PHONY: lint
lint:
	./scripts/ci/run_linter.sh --backend
