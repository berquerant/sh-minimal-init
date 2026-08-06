.PHONY: install
install: init
	./install.sh

.PHONY: uninstall
uninstall:
	./install.sh rm

.PHONY: gitconfig
gitconfig:
	./install-gitconfig.sh

.PHONY: init
init:
	git submodule update --init

.PHONY: update
update:
	git submodule update --remote
