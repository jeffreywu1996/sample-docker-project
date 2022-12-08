# Sample Docker Project
This repo shows how to run a sample docker project using docker development. End product is a dockerfile to run the service. Development environment will be a version of the docker. Makefile is used to wrap complex docker compose commands.

## How to run
```
# Starts backend server in a docker compose
make start

# Runs unit tests
make unittest

# Runs integration tests
make test

# Runs linter
make lint
```
