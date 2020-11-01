SHELL := /bin/bash

menu:
	@perl -ne 'printf("%10s: %s\n","$$1","$$2") if m{^([\w+-]+):[^#]+#\s(.+)$$}' Makefile

build: # Build letfn/redis
	docker build -t letfn/redis .

push: # Push letfn/redis
	docker push letfn/redis

bash: # Run bash shell with letfn/redis
	docker run --rm -ti --entrypoint bash letfn/redis

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
