ZAHID_REPO = git@github.com:super-simon/zahid.git
EXPEDITE_REPO = git@github.com:super-simon/baskim.git
ENV_LOC=loc
ENV_PROD=prod


git_pull_all: git_pull_zahid git_pull_expedite

git_pull_zahid:
	if [ -d "zahid/.git" ]; then \
		echo "zahid exists, doing git pull..."; \
		cd zahid && git pull; \
	else \
		echo "Cloning project1..."; \
		git clone $(ZAHID_REPO) zahid; \
	fi

git_pull_expedite:
	if [ -d "expedite/.git" ]; then \
		echo "expedite exists, doing git pull..."; \
		cd expedite && git pull; \
	else \
		echo "Cloning expedite..."; \
		git clone $(EXPEDITE_REPO) expedite; \
	fi

prepare_loc:
	cp .env.$(ENV_LOC) .env
	make -C ./expedite prepare_loc
	make -C ./zahid prepare_loc
	cd common-nginx; cp conf.$(ENV_LOC) ./conf.d/default.conf

cert_loc:
	make -C ./expedite cert_loc
	make -C ./zahid cert_loc
	cp ./zahid/nginx/certs/* ./common-nginx/certs/
	cp ./expedite/frontend/cert/cert.pem ./common-nginx/certs/exp.loc-cert.pem
	cp ./expedite/frontend/cert/key.pem ./common-nginx/certs/exp.loc-key.pem

build:
	make -C ./expedite build
	make -C ./zahid build

start:
	docker compose --env-file ./.env up --detach

start_foreground:
	docker compose --env-file ./.env up

stop:
	docker compose down

docker_prune:
	docker system prune -af
	docker system prune --volumes --force