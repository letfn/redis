SHELL := /bin/bash

menu:
	@perl -ne 'printf("%10s: %s\n","$$1","$$2") if m{^([\w+-]+):[^#]+#\s(.+)$$}' Makefile

build: # Build defn/redis
	podman build -t defn/redis .

push: # Push defn/redis
	podman push defn/redis

bash: # Run bash shell with defn/redis
	podman run --rm -ti --entrypoint bash defn/redis

exec:
	docker-compose exec redis bash

clean:
	docker-compose down --remove-orphans

up:
	docker-compose up -d --remove-orphans

down:
	docker-compose rm -f -s

recreate:
	$(MAKE) clean
	$(MAKE) up

recycle:
	$(MAKE) build
	$(MAKE) recreate

logs:
	docker-compose logs -f
