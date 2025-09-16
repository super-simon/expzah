ZAHID_REPO = git@github.com:super-simon/zahid.git
EXPEDITE_REPO = git@github.com:super-simon/baskim.git

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
	make -C ./expdedite prepare_loc
	make -C ./zahid prepare_loc
